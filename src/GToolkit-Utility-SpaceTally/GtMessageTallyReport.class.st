Class {
	#name : #GtMessageTallyReport,
	#superclass : #Object,
	#instVars : [
		'textualContent',
		'imageData',
		'startTime',
		'duration',
		'pollPeriodMilliseconds',
		'numberOfSamples',
		'measuredMilliseconds',
		'vmParametersDiff',
		'messageTally'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtMessageTallyReport class >> fromMessageTally: aMessageTally [
	^ self new 
		initializeFromMessageTally: aMessageTally
]

{ #category : #serialization }
GtMessageTallyReport class >> leJsonV4AttributeMapping [
	^ #(#imageData #startTime #duration #pollPeriodMilliseconds #numberOfSamples #measuredMilliseconds #vmParametersDiff)
		collect: [ :each | each -> each ]

]

{ #category : #serialization }
GtMessageTallyReport class >> leJsonV4Name [
	^ #gtMessageTallyReport
]

{ #category : #accessing }
GtMessageTallyReport >> duration [
	^ duration

]

{ #category : #accessing }
GtMessageTallyReport >> duration: aDuration [
	duration := aDuration

]

{ #category : #'gt - extensions' }
GtMessageTallyReport >> gtImageDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Image data';
		priority: 30;
		object: [ imageData ];
		view: #gtSummaryFor:

]

{ #category : #'gt - extensions' }
GtMessageTallyReport >> gtJsonFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON';
		priority: 50;
		object: [ GtJson forJsonString: (LeJsonV4 uniqueInstance serializePretty: self) ];
		view: #gtJsonStringFor:

]

{ #category : #'gt - extensions' }
GtMessageTallyReport >> gtSaveLocallyActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons savetodisk;
		tooltip: 'Save the report locally';
		action: [ :aButton | aButton phlow spawnObject: (self storeIn: GtReportsLocalStore default) ]

]

{ #category : #'gt - extensions' }
GtMessageTallyReport >> gtStorageFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Storage';
		priority: 40;
		items: [ OrderedCollection new
			add: 'Folder' -> self storageFolderName;
			add: 'File prefix' -> self storageFilePrefix;
			add: 'Local folder' -> (GtReportsLocalStore default folderNamed: self storageFolderName);
			yourself ];
		column: 'Attribute' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]

]

{ #category : #'gt - extensions' }
GtMessageTallyReport >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ self summaryAttributes ];
		column: 'Attribute' text: [ :each | each key ] width: 150;
		column: 'Value' text: [ :each | each value ifNil: [ '-' ] ];
		send: [ :each | each value ]

]

{ #category : #'gt - extensions' }
GtMessageTallyReport >> gtTallyTreeFor: aView [
	<gtView>
	messageTally ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Tally tree';
		priority: 15;
		object: [ messageTally ];
		view: #gtMessagesTreeIn:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect the Message Tally'
			action: [ :aButton | aButton phlow spawnObject: messageTally ]

]

{ #category : #'gt - extensions' }
GtMessageTallyReport >> gtViewReportOn: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Content';
		object: [ textualContent ];
		view: #gtStringFor:
]

{ #category : #'gt - extensions' }
GtMessageTallyReport >> gtVmParametersFor: aView [
	<gtView>
	vmParametersDiff ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'VM parameters';
		priority: 20;
		object: [ vmParametersDiff ];
		view: #gtViewChangedParametersFor:

]

{ #category : #accessing }
GtMessageTallyReport >> imageData [
	^ imageData

]

{ #category : #accessing }
GtMessageTallyReport >> imageData: aReportImageData [
	imageData := aReportImageData

]

{ #category : #initialization }
GtMessageTallyReport >> initialize [
	super initialize.
	textualContent := ''.
	imageData := GtReportImageData new.
	duration := Duration zero.
	pollPeriodMilliseconds := 0.
	numberOfSamples := 0.
	measuredMilliseconds := 0

]

{ #category : #initialization }
GtMessageTallyReport >> initializeFromMessageTally: aMessageTally [
	self recordImageData.
	self recordTally: aMessageTally.
	self recordText

]

{ #category : #accessing }
GtMessageTallyReport >> measuredMilliseconds [
	^ measuredMilliseconds

]

{ #category : #accessing }
GtMessageTallyReport >> measuredMilliseconds: anInteger [
	measuredMilliseconds := anInteger

]

{ #category : #accessing }
GtMessageTallyReport >> messageTally [
	^ messageTally

]

{ #category : #accessing }
GtMessageTallyReport >> numberOfSamples [
	^ numberOfSamples

]

{ #category : #accessing }
GtMessageTallyReport >> numberOfSamples: anInteger [
	numberOfSamples := anInteger

]

{ #category : #accessing }
GtMessageTallyReport >> pollPeriodMilliseconds [
	^ pollPeriodMilliseconds

]

{ #category : #accessing }
GtMessageTallyReport >> pollPeriodMilliseconds: anInteger [
	pollPeriodMilliseconds := anInteger

]

{ #category : #printing }
GtMessageTallyReport >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			nextPutAll: duration gtHumanReadableString;
			nextPutAll: ', ';
			print: numberOfSamples;
			nextPutAll: ' samples' ]

]

{ #category : #recording }
GtMessageTallyReport >> recordImageData [
	imageData := GtReportImageData current

]

{ #category : #recording }
GtMessageTallyReport >> recordTally: aMessageTally [
	messageTally := aMessageTally.
	numberOfSamples := aMessageTally tally.
	measuredMilliseconds := aMessageTally time

]

{ #category : #recording }
GtMessageTallyReport >> recordText [
	textualContent := String streamContents: [ :aStream | messageTally report: aStream ]

]

{ #category : #accessing }
GtMessageTallyReport >> startTime [
	^ startTime

]

{ #category : #accessing }
GtMessageTallyReport >> startTime: aDateAndTime [
	startTime := aDateAndTime

]

{ #category : #storage }
GtMessageTallyReport >> storageFilePrefix [
	^ 'MessageTally-'

]

{ #category : #storage }
GtMessageTallyReport >> storageFolderName [
	^ 'message-tally'

]

{ #category : #storage }
GtMessageTallyReport >> storeIn: aStore [
	^ (aStore entryFolderName: self storageFolderName filePrefix: self storageFilePrefix)
		writeText: textualContent extension: 'txt';
		writeJsonOf: self;
		yourself

]

{ #category : #accessing }
GtMessageTallyReport >> summaryAttributes [
	^ OrderedCollection new
		add: 'Started at' -> startTime;
		add: 'Duration' -> duration;
		add: 'Poll period (ms)' -> pollPeriodMilliseconds;
		add: 'Samples' -> numberOfSamples;
		add: 'Measured time (ms)' -> measuredMilliseconds;
		add: 'Text size' -> textualContent size;
		yourself

]

{ #category : #accessing }
GtMessageTallyReport >> textualContent [
	^ textualContent
]

{ #category : #accessing }
GtMessageTallyReport >> textualContent: aString [
	textualContent := aString
]

{ #category : #accessing }
GtMessageTallyReport >> vmParametersDiff [
	^ vmParametersDiff

]

{ #category : #accessing }
GtMessageTallyReport >> vmParametersDiff: aVmAllParametersDiffReport [
	vmParametersDiff := aVmAllParametersDiffReport

]

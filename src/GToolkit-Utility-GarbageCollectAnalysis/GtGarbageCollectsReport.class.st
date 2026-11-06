Class {
	#name : #GtGarbageCollectsReport,
	#superclass : #Object,
	#instVars : [
		'events',
		'overallParametersDiffReport',
		'imageData'
	],
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #serialization }
GtGarbageCollectsReport class >> fromSerializedString: aString [
 	^ LeJsonV4 uniqueInstance deserialize:  aString readStream
]

{ #category : #serialization }
GtGarbageCollectsReport class >> leJsonV4Name [

	^ #gtGarbageCollectsReport
]

{ #category : #accessing }
GtGarbageCollectsReport >> avegareFullGcDuration [
	| fullGcDuration |
	fullGcDuration := self overallParametersDiffReport 
		fullGcDurationDiff rawDiffValue.
	fullGcDuration = 0 ifTrue:  [ ^ nil ].
	^Duration
		milliSeconds: fullGcDuration
					/ self overallParametersDiffReport fullGcCountDiff rawDiffValue
]

{ #category : #accessing }
GtGarbageCollectsReport >> events [
	^ events
]

{ #category : #accessing }
GtGarbageCollectsReport >> events: aCollection [
	events := aCollection
]

{ #category : #views }
GtGarbageCollectsReport >> gtImageDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Image data';
		priority: 30;
		object: [ imageData ];
		view: #gtSummaryFor:

]

{ #category : #views }
GtGarbageCollectsReport >> gtJsonFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON';
		priority: 50;
		object: [ GtJson forJsonString: (LeJsonV4 uniqueInstance serializePretty: self) ];
		view: #gtJsonStringFor:

]

{ #category : #views }
GtGarbageCollectsReport >> gtOverallParametersDiffReportFor: aView [
	<gtView>
	^ aView forward
		title: 'Overall Parameters Diff';
		priority: 40;
		object: [ overallParametersDiffReport ];
		view: #gtViewChangedParametersFor:
]

{ #category : #views }
GtGarbageCollectsReport >> gtSaveLocallyActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons savetodisk;
		tooltip: 'Save the report locally';
		action: [ :aButton | aButton phlow spawnObject: (self storeIn: GtReportsLocalStore default) ]

]

{ #category : #views }
GtGarbageCollectsReport >> gtStorageFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Storage';
		priority: 45;
		items: [ OrderedCollection new
			add: 'Folder' -> self storageFolderName;
			add: 'File prefix' -> self storageFilePrefix;
			add: 'Local folder' -> (GtReportsLocalStore default 
				folderNamed: self storageFolderName);
			yourself ];
		column: 'Attribute' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]

]

{ #category : #views }
GtGarbageCollectsReport >> gtSummaryFor: aView [
	<gtView>

	^ aView columnedList
		  title: 'Summary';
		  priority: 5;
		  items: [ self summaryAttributes ];
		  column: #Attribute text: [ :item | item first ];
		  column: #Value text: [ :item | item second ];
		  send: #second.
]

{ #category : #views }
GtGarbageCollectsReport >> gtViewEventsFor: aView [
	<gtView>
	events ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Events';
		priority: 10;
		object: [ events ];
		view: #gtItemsFor:
]

{ #category : #accessing }
GtGarbageCollectsReport >> imageData [
	^ imageData

]

{ #category : #accessing }
GtGarbageCollectsReport >> imageData: aReportImageData [
	imageData := aReportImageData

]

{ #category : #initialization }
GtGarbageCollectsReport >> initialize [
	super initialize.
	events := GtGarbageCollectEventsGroup new.
	imageData := GtReportImageData new

]

{ #category : #accessing }
GtGarbageCollectsReport >> overallParametersDiffReport [
	^ overallParametersDiffReport
]

{ #category : #accessing }
GtGarbageCollectsReport >> overallParametersDiffReport: aVmAllParametersDiffReport [
	overallParametersDiffReport := aVmAllParametersDiffReport
]

{ #category : #printing }
GtGarbageCollectsReport >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			print: events size;
			nextPutAll: ' recorded GC events' ]

]

{ #category : #accessing }
GtGarbageCollectsReport >> recordImageData [
	imageData := GtReportImageData current

]

{ #category : #accessing }
GtGarbageCollectsReport >> recordedEventsDuration [
	^ events  
		inject: 0 seconds 
		into: [ :total  :anEvent | 
			total + anEvent duration ]
]

{ #category : #serialization }
GtGarbageCollectsReport >> serializeForExport [
	^ LeJsonV4 uniqueInstance serialize: self
]

{ #category : #storage }
GtGarbageCollectsReport >> storageFilePrefix [
	^ 'GarbageCollectsReport-'

]

{ #category : #storage }
GtGarbageCollectsReport >> storageFolderName [
	^ 'garbage-collector'

]

{ #category : #storage }
GtGarbageCollectsReport >> storeIn: aStore [
	^ (aStore entryFolderName: self storageFolderName filePrefix: self storageFilePrefix)
		writeJsonOf: self;
		yourself

]

{ #category : #accessing }
GtGarbageCollectsReport >> summaryAttributes [
	"Answer a collection of key/value attributes that can simply be listed as a summary of the receiver"

	^ { 
		{ 'Total GC Count'. overallParametersDiffReport fullGcCountDiff diffFormattedValue diffDescription }.
		{ 'Total GC Duration'. overallParametersDiffReport fullGcDurationDiff diffFormattedValue diffDescription }.
		{'Not-recorded GC events' . overallParametersDiffReport fullGcCountDiff rawDiffValue - events size }.
		{'Recorded GC events' . events size }.
		{'Recorded events duration' . self recordedEventsDuration}.
		{'Events with basicNew source'. events numberOfEventsWithBasicNewSource}}
]

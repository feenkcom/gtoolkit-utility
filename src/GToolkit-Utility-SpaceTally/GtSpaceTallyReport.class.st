"
I hold a space tally of the whole image (the unchanged `GtSpaceTally`), the VM statistics, the time and the image data. I am stored as gzipped STON, because the plain text of a full tally is about a hundred megabytes.
"
Class {
	#name : #GtSpaceTallyReport,
	#superclass : #Object,
	#instVars : [
		'imageData',
		'reportUid',
		'timestamp',
		'spaceTally',
		'vmStatisticsReport'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtSpaceTallyReport class >> fromGzippedSton: aByteArray [
	^ STON fromString: (GZipReadStream on: aByteArray) upToEnd utf8Decoded

]

{ #category : #serialization }
GtSpaceTallyReport class >> fromStoredFiles: aStoredReportFiles [
	^ aStoredReportFiles readGzippedSton

]

{ #category : #'instance creation' }
GtSpaceTallyReport class >> imageData: anImageData [
	^ self new setImageData: anImageData

]

{ #category : #serialization }
GtSpaceTallyReport class >> leJsonV4Name [
	^ #gtSpaceTallyReport

]

{ #category : #'instance creation' }
GtSpaceTallyReport class >> recordNewReport [
	^ self recordNewReportWithImageData: GtReportImageData current

]

{ #category : #'instance creation' }
GtSpaceTallyReport class >> recordNewReportWithImageData: anImageData [
	^ (self imageData: anImageData)
		recordReportStatistics;
		yourself

]

{ #category : #'gt - extensions' }
GtSpaceTallyReport >> gtImageDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Image data';
		priority: 30;
		object: [ imageData ];
		view: #gtSummaryFor:

]

{ #category : #'gt - extensions' }
GtSpaceTallyReport >> gtPackageTalliesFor: aView [
	<gtView>
	spaceTally ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Tallies (by package)';
		priority: 15;
		object: [ spaceTally ];
		view: #gtViewPackageTalliesFor:

]

{ #category : #'gt - extensions' }
GtSpaceTallyReport >> gtRepositoryTalliesFor: aView [
	<gtView>
	spaceTally ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Tallies (by repository)';
		priority: 20;
		object: [ spaceTally ];
		view: #gtViewRepositoryTalliesFor:

]

{ #category : #'gt - extensions' }
GtSpaceTallyReport >> gtSaveLocallyActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons savetodisk;
		tooltip: 'Save the report locally';
		action: [ :aButton | 
			aButton phlow spawnObject: (self storeIn: GtReportsLocalStore default) ]

]

{ #category : #'gt - extensions' }
GtSpaceTallyReport >> gtStorageFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Storage';
		priority: 40;
		items: [ OrderedCollection new
			add: 'Report type' -> self reportType;
			add: 'Format' -> 'gzipped STON (.ston.gz)';
			add: 'Local folder' -> (GtReportsLocalStore default folderForType: self reportType);
			yourself ];
		column: 'Attribute' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]

]

{ #category : #'gt - extensions' }
GtSpaceTallyReport >> gtSummaryFor: aView [
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
GtSpaceTallyReport >> gtTalliesFor: aView [
	<gtView>
	spaceTally ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Tallies';
		priority: 10;
		object: [ spaceTally ];
		view: #gtViewItemsFor:

]

{ #category : #serialization }
GtSpaceTallyReport >> gzippedSton [
	^ ByteArray streamContents: [ :aStream |
		| gzipStream |
		gzipStream := GZipWriteStream on: aStream.
		gzipStream nextPutAll: (STON toString: self) utf8Encoded.
		gzipStream close ]

]

{ #category : #accessing }
GtSpaceTallyReport >> imageData [
	^ imageData

]

{ #category : #initialization }
GtSpaceTallyReport >> imageData: anImageData [
	imageData := anImageData

]

{ #category : #initialization }
GtSpaceTallyReport >> initialize [
	super initialize.
	imageData := GtReportImageData new.
	reportUid := UUID new

]

{ #category : #accessing }
GtSpaceTallyReport >> numberOfItems [
	^ spaceTally
		ifNil: [ 0 ]
		ifNotNil: [ :aSpaceTally | aSpaceTally results items size ]

]

{ #category : #printing }
GtSpaceTallyReport >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			print: self numberOfItems;
			nextPutAll: ' items'.
		timestamp ifNotNil: [ :aDateAndTime |
			aStream
				nextPutAll: ', ';
				print: aDateAndTime ] ]

]

{ #category : #recording }
GtSpaceTallyReport >> recordReportStatistics [
	timestamp := DateAndTime now.
	spaceTally := GtSpaceTally new.
	spaceTally systemWideSpaceTally.
	vmStatisticsReport := GtVmRuntimeStatisticsReport new.
	vmStatisticsReport recordReportStatistics

]

{ #category : #storage }
GtSpaceTallyReport >> reportType [
	^ 'space-tally'

]

{ #category : #accessing }
GtSpaceTallyReport >> reportUid [
	^ reportUid

]

{ #category : #accessing }
GtSpaceTallyReport >> reportUid: anObject [
	reportUid := anObject
]

{ #category : #initialization }
GtSpaceTallyReport >> setImageData: anImageData [
	self imageData: anImageData
]

{ #category : #accessing }
GtSpaceTallyReport >> spaceTally [
	^ spaceTally

]

{ #category : #accessing }
GtSpaceTallyReport >> spaceTally: anObject [
	spaceTally := anObject
]

{ #category : #storage }
GtSpaceTallyReport >> storeIn: aStore [
	^ aStore store: self

]

{ #category : #accessing }
GtSpaceTallyReport >> summaryAttributes [
	^ OrderedCollection new
		add: 'Recorded at' -> timestamp;
		add: 'Tally items' -> self numberOfItems;
		add: 'Instances' -> (spaceTally ifNotNil: [ :aSpaceTally | aSpaceTally results totalInstCount ]);
		add: 'Instances size' -> (spaceTally ifNotNil: [ :aSpaceTally |
			aSpaceTally results totalInstSpace humanReadableIsqByteSize ]);
		add: 'VM memory size' -> (vmStatisticsReport ifNotNil: [ :aReport |
			aReport vmMemorySize humanReadableIsqByteSize ]);
		yourself

]

{ #category : #accessing }
GtSpaceTallyReport >> timestamp [
	^ timestamp

]

{ #category : #accessing }
GtSpaceTallyReport >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #accessing }
GtSpaceTallyReport >> vmStatisticsReport [
	^ vmStatisticsReport

]

{ #category : #accessing }
GtSpaceTallyReport >> vmStatisticsReport: anObject [
	vmStatisticsReport := anObject
]

{ #category : #storage }
GtSpaceTallyReport >> writeFilesTo: anEntry [
	anEntry writeGzippedStonOf: self

]

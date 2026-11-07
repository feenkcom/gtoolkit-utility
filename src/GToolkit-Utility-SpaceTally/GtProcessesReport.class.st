Class {
	#name : #GtProcessesReport,
	#superclass : #Object,
	#instVars : [
		'processReports',
		'imageData'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtProcessesReport class >> leJsonV4Name [
	^ #gtProcessesReport
]

{ #category : #'instance creation' }
GtProcessesReport class >> recordNewReport [
	^ self new
		recordImageData;
		recordReportStatistics;
		yourself

]

{ #category : #'gt - extensions' }
GtProcessesReport >> gtImageDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Image data';
		priority: 30;
		object: [ imageData ];
		view: #gtSummaryFor:

]

{ #category : #'gt - extensions' }
GtProcessesReport >> gtJsonFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON';
		priority: 50;
		object: [ GtJson forJsonString: (LeJsonV4 uniqueInstance serializePretty: self) ];
		view: #gtJsonStringFor:

]

{ #category : #'gt - extensions' }
GtProcessesReport >> gtSaveLocallyActionFor: anAction [
	<gtAction>
	
	^ anAction button
		icon: BrGlamorousVectorIcons savetodisk;
		tooltip: 'Save the report locally';
		action: [ :aButton | aButton phlow 
			spawnObject: (self storeIn: GtReportsLocalStore default) ]

]

{ #category : #'gt - extensions' }
GtProcessesReport >> gtStorageFor: aView [
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
GtProcessesReport >> gtViewAllProcessesFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Processes';
		items: [ processReports sorted: [ :each | each priority ] descending ];
		column: 'Name' text: [ :aProcessReport |
			aProcessReport name ];
		column: 'Priority' 
			text: [ :aProcessReport | aProcessReport priority ]
			width: 100;
		column: 'Is Quiescent'
			text: [ :aProcessReport | aProcessReport isQuiescent ]
			width: 100;
		column: 'Top Context' text: [ :aProcessReport |
			aProcessReport contextReports 
				ifNil: ['']
				ifNotNil: [ :aContext |
					aContext first contextDescription ] ]
]

{ #category : #accessing }
GtProcessesReport >> imageData [
	^ imageData

]

{ #category : #accessing }
GtProcessesReport >> imageData: aReportImageData [
	imageData := aReportImageData

]

{ #category : #initialization }
GtProcessesReport >> initialize [
	super initialize.

	processReports := #().
	imageData := GtReportImageData new

]

{ #category : #printing }
GtProcessesReport >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			print: processReports size;
			nextPutAll: ' processes, ';
			print: (processReports select: [ :each | each isQuiescent ]) size;
			nextPutAll: ' quiescent' ]

]

{ #category : #accessing }
GtProcessesReport >> processReports [
	^ processReports
]

{ #category : #accessing }
GtProcessesReport >> processReports: aCollection [
	processReports := aCollection
]

{ #category : #accessing }
GtProcessesReport >> recordImageData [
	imageData := GtReportImageData current

]

{ #category : #accessing }
GtProcessesReport >> recordReportStatistics [
	| gtQuiescentProcesses allProcesses  |
	gtQuiescentProcesses := Processor gtQuiescentProcesses.
		
	allProcesses := Process allSubInstances 
		reject: [:each | each isTerminated ].
		
	processReports := allProcesses collect: [ :aProcess | 
		(GtProcessReport fromProcess: aProcess)
			isQuiescent: (gtQuiescentProcesses includes: aProcess);
			yourself ].
]

{ #category : #storage }
GtProcessesReport >> storageFilePrefix [
	^ 'ProcessesReport-'

]

{ #category : #storage }
GtProcessesReport >> storageFolderName [
	^ 'processes-report'

]

{ #category : #storage }
GtProcessesReport >> storeIn: aStore [
	^ (aStore entryFolderName: self storageFolderName filePrefix: self storageFilePrefix)
		writeJsonOf: self;
		yourself

]

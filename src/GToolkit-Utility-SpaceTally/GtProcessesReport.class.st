Class {
	#name : #GtProcessesReport,
	#superclass : #Object,
	#instVars : [
		'processReports'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtProcessesReport class >> leJsonV4Name [
	^ #gtProcessesReport
]

{ #category : #'instance creation' }
GtProcessesReport class >> recordNewReport [
	^ self new recordReportStatistics
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
GtProcessesReport >> processReports [
	^ processReports
]

{ #category : #accessing }
GtProcessesReport >> processReports: aCollection [
	processReports := aCollection
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

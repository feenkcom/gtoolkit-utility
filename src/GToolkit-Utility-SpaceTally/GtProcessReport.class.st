Class {
	#name : #GtProcessReport,
	#superclass : #Object,
	#instVars : [
		'id',
		'name',
		'priority',
		'isQuiescent',
		'contextReports'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtProcessReport class >> fromProcess: aProcess [
	^ self new 
		initializeFromProcess: aProcess
]

{ #category : #serialization }
GtProcessReport class >> leJsonV4Name [
	^ #gtProcessReport
]

{ #category : #accessing }
GtProcessReport >> contextReports [
	^ contextReports
]

{ #category : #accessing }
GtProcessReport >> contextReports: anObject [
	^ contextReports := anObject
]

{ #category : #'gt - extensions' }
GtProcessReport >> gtViewContextsListFor: aView [ 
	<gtView>
	
	^ aView list 
		title: 'Contexts';
		priority: 10;
		items: [ contextReports ifNil: [#()] ];
		itemFormat: [ :aContextReport |
			aContextReport contextDescription ]
]

{ #category : #'gt - extensions' }
GtProcessReport >> gtViewStackTraceFor: aView [ 
	<gtView>
	
	^(aView textEditor)
		title: 'Trace';
		priority: 11;
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: GtTraceStyler new;
		text: [self stackTraceDescription ]
]

{ #category : #'gt - extensions' }
GtProcessReport >> gtViewTextualReportFor: aView [ 
	<gtView>
	
	^(aView textEditor)
		title: 'Textual description';
		priority: 15;
		"aptitude: BrGlamorousCodeEditorAptitude;"
		styler: GtTraceStyler new;
		text: [self textualDescription ]
]

{ #category : #accessing }
GtProcessReport >> id [
	^ id
]

{ #category : #accessing }
GtProcessReport >> id: anId [
	id := anId
]

{ #category : #initialization }
GtProcessReport >> initializeFromProcess: aProcess [
	| ctx |
	
	priority := aProcess priority.
	id := aProcess id. 
	name := aProcess name.
	
	ctx := aProcess isActiveProcess 
		ifTrue: [ thisContext sender ] 
		ifFalse: [ aProcess suspendedContext ].	
	ctx ifNotNil: [
		contextReports := (ctx stackOfSize: 100) collect: [ :aContext |
			GtProcessContextReport fromContext: aContext ] ]
]

{ #category : #testing }
GtProcessReport >> isQuiescent [
	^ isQuiescent ifNil: [ false ]
]

{ #category : #accessing }
GtProcessReport >> isQuiescent: aBoolean [
	isQuiescent := aBoolean
]

{ #category : #accessing }
GtProcessReport >> name [
	^ name
]

{ #category : #accessing }
GtProcessReport >> name: aName [
	name := aName
]

{ #category : #printing }
GtProcessReport >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		self name 
			ifNil: [ aStream << self id second ]
			ifNotNil: [
				aStream << self name.
				aStream 
					<< '[';
					print: self id second;
					<< ']' ].
		aStream 
			nextPutAll: '; priority: '; 
			print: self priority;
			nextPutAll: '; Quiescent: '; 
			print: self isQuiescent ]
]

{ #category : #accessing }
GtProcessReport >> priority [
	^ priority
]

{ #category : #accessing }
GtProcessReport >> priority: anInteger [
	priority := anInteger
]

{ #category : #printing }
GtProcessReport >> stackTraceDescription [
	^ String streamContents: [ :aStream |
		self stackTraceDescriptionOn: aStream ]
]

{ #category : #printing }
GtProcessReport >> stackTraceDescriptionOn: aStream [
	contextReports 
		ifNotNil: [
			contextReports do: [ :aContextReport |
				aStream << aContextReport contextDescription; cr ]]
]

{ #category : #printing }
GtProcessReport >> textualDescription [
	^ String streamContents: [ :aStream |
		self textualDescriptionOn: aStream ]
]

{ #category : #printing }
GtProcessReport >> textualDescriptionOn: aStream [
	
	aStream 
		nextPutAll: 'Process: '; 
		print: self id second; 
		nextPutAll: '; priority: '; 
		print: self priority.
		
	aStream 
		nextPutAll: '; Quiescent: '; 
		print: self isQuiescent.
	aStream
		nextPutAll: ';  stack:'; cr; cr.

	self stackTraceDescriptionOn: aStream
]

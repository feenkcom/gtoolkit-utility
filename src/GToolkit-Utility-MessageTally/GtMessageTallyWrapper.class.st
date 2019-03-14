Class {
	#name : #GtMessageTallyWrapper,
	#superclass : #Object,
	#instVars : [
		'rootMessageTally',
		'messageTally'
	],
	#category : #'GToolkit-Utility-MessageTally'
}

{ #category : #ui }
GtMessageTallyWrapper >> gtMessagesTreeIn: aView [
	<gtView>
	^ messageTally 
		ifNil: [ aView ]
		ifNotNil: [ (messageTally gtMessagesTreeIn: aView)
			priority: 10 ]
]

{ #category : #ui }
GtMessageTallyWrapper >> gtSourceFor: aView [
	<gtView>
	^ messageTally 
		ifNil: [ aView ]
		ifNotNil: [ (messageTally gtSourceFor: aView)
			priority: 20 ]
]

{ #category : #ui }
GtMessageTallyWrapper >> gtTextReportFor: aView [
	<gtView>
	^ messageTally 
		ifNil: [ aView ]
		ifNotNil: [ (messageTally gtTextReportFor: aView)
			priority: 30 ]
]

{ #category : #accessing }
GtMessageTallyWrapper >> messageTally: aMessageTally [
	messageTally := aMessageTally
]

{ #category : #printing }
GtMessageTallyWrapper >> printOn: aStream [
	| aSelector aClass |
	super printOn: aStream.
	aSelector := messageTally method selector.
	aClass := messageTally method methodClass.
	aStream
		nextPut: $(;
		nextPutAll: (self tallyPercentage printShowingDecimalPlaces: 1);
		nextPutAll: '% {';
		print: self timeInMilliseconds;
		nextPutAll: 'ms} ';
		nextPutAll: self selectorDescription;
		nextPut: $)
]

{ #category : #accessing }
GtMessageTallyWrapper >> rootMessageTally: aMessageTally [
	rootMessageTally := aMessageTally
]

{ #category : #printing }
GtMessageTallyWrapper >> selectorDescription [
	| aSelector aClass |
	aSelector := messageTally method selector.
	aClass := messageTally method methodClass.
	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: self theClass name;
			nextPutAll: (aClass = messageTally theClass 
				ifTrue: ['>>']
				ifFalse: ['(' , aClass name , ')>>']);
			nextPutAll: aSelector ]
]

{ #category : #accessing }
GtMessageTallyWrapper >> tallyPercentage [
	^ messageTally tally asFloat / rootMessageTally tally * 100.0
]

{ #category : #accessing }
GtMessageTallyWrapper >> theClass [
	^ messageTally theClass
]

{ #category : #accessing }
GtMessageTallyWrapper >> timeInMilliseconds [
	^ (self tallyPercentage * rootMessageTally time / 100) rounded
]

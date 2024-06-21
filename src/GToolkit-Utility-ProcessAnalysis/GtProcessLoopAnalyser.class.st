Class {
	#name : #GtProcessLoopAnalyser,
	#superclass : #Object,
	#instVars : [
		'process',
		'delay',
		'count',
		'stacks',
		'commonStack'
	],
	#category : #'GToolkit-Utility-ProcessAnalysis'
}

{ #category : #private }
GtProcessLoopAnalyser >> collectStacks [
	| activeProcess oldPriority |

	activeProcess := Processor activeProcess.
	oldPriority := activeProcess priority.
	activeProcess priority: Processor lowIOPriority.
	stacks := Array new: count.
	1 to: count do: [ :i |
		delay wait.
		stacks at: i put: self currentStack ].
	activeProcess priority: oldPriority.
]

{ #category : #private }
GtProcessLoopAnalyser >> commonStack [

	^ commonStack ifNil: [ commonStack := self getCommonStack ].
]

{ #category : #accessing }
GtProcessLoopAnalyser >> count [
	^ count
]

{ #category : #accessing }
GtProcessLoopAnalyser >> count: anObject [
	count := anObject
]

{ #category : #private }
GtProcessLoopAnalyser >> currentStack [

	^ process suspendedContext stack.
]

{ #category : #accessing }
GtProcessLoopAnalyser >> delay [
	^ delay
]

{ #category : #accessing }
GtProcessLoopAnalyser >> delay: anObject [
	delay := anObject
]

{ #category : #private }
GtProcessLoopAnalyser >> getCommonStack [
	| index diverged minSize rStacks newCommonStack |

	index := 1.
	diverged := false.
	newCommonStack := OrderedCollection new.
	minSize := (stacks collect: #size) min.
	rStacks := stacks collect: #reversed.
	[ index <= minSize and: [ diverged not ] ] whileTrue:
		[ | frames |
		frames := rStacks collect: [ :each | each at: index ].
		diverged := (frames allSatisfy: [ :each | each == frames first ]) not.
		diverged ifFalse: [ newCommonStack add: frames first ].
		index := index + 1 ].
	commonStack := newCommonStack reversed.
	^ commonStack
]

{ #category : #accessing }
GtProcessLoopAnalyser >> gtCommonStackFor: aView [
	<gtView>
	
	commonStack ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Common Stack';
		priority: 10;
		items: [ commonStack ]
]

{ #category : #accessing }
GtProcessLoopAnalyser >> gtSampledStacksFor: aView [
	<gtView>
	
	stacks ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Sampled Stacks';
		priority: 20;
		items: [ stacks ]
]

{ #category : #initialize }
GtProcessLoopAnalyser >> initialize [

	super initialize.
	delay := 200 milliseconds.
	count := 10.
]

{ #category : #accessing }
GtProcessLoopAnalyser >> process [
	^ process
]

{ #category : #accessing }
GtProcessLoopAnalyser >> process: anObject [
	process := anObject
]

{ #category : #accessing }
GtProcessLoopAnalyser >> report [

	^ String streamContents: [ :stream |
		stream
			<< 'CommonStack'; cr;
			<< '==========='; cr;
			cr.
		commonStack ifNotNil:
			[ commonStack do: [ :context |
				stream
					print: context;
					cr ] ].
		stream
			cr; cr; cr;
			<< 'Source Stacks'; cr;
			<< '============='; cr;
			cr.
		stacks doWithIndex: [ :stack :index |
			stream
				<< 'Stack ';
					print: index;
					cr;
				<< '---------'; cr.
			stack do: [ :context |
				stream
					print: context;
					cr ].
			stream cr; cr. ] ].
]

{ #category : #actions }
GtProcessLoopAnalyser >> run [

	self collectStacks.
	commonStack := self commonStack.
]

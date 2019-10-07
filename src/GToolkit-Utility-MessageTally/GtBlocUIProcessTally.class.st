Class {
	#name : #GtBlocUIProcessTally,
	#superclass : #GtMessageTallyWrapper,
	#instVars : [
		'framePhaseTallies'
	],
	#category : #'GToolkit-Utility-MessageTally'
}

{ #category : #opening }
GtBlocUIProcessTally class >> inspectTally: aRootMessageTally [
	"Find a tally for a new process that has as child the bloc UI process"
	aRootMessageTally children
		detect: [ :aTally | 
			aTally children anySatisfy: [ :anotherTally |
				self isTallyForBlocUIProcess: anotherTally ] ]
		ifFound: [ :currentUIProcesTally |
			"If we find a tally for the Bloc UI processs we can use the specialized viewer."
			GtInspector openOn: (self new
				initializeForUIProcessTally: currentUIProcesTally 
				withRoot: aRootMessageTally) ]
		ifNone: [
			"In case we cannot locate the Bloc UI process we inspect the tally object"
			GtInspector openOn: aRootMessageTally ].
]

{ #category : #testing }
GtBlocUIProcessTally class >> isTallyForBlocUIProcess: aMessageTally [
	^ (aMessageTally method selector = #createLoopTask) and: [ 
			aMessageTally theClass = BlHostPulseLoop ] 
]

{ #category : #ui }
GtBlocUIProcessTally >> gtViewFramePhasesListFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Frame phases' translated;
		priority: 5;
		items: [ framePhaseTallies ];
		column: 'Phase' format: #selectorDescription;
		column: 'Percentage' 
			format: [ :aTally | (aTally tallyPercentage printShowingDecimalPlaces: 1), '%']
			width: 100;
		column: 'Time' 
			format: [ :aTally | aTally timeInMilliseconds asString, 'ms' ] 
			width: 100
]

{ #category : #ui }
GtBlocUIProcessTally >> gtViewFullMessagesTreeIn: aView [
	<gtView>
	^ rootMessageTally 
		ifNil: [ aView ]
		ifNotNil: [ (rootMessageTally gtMessagesTreeIn: aView)
			title: 'Full tree';
			priority: 50 ]
]

{ #category : #ui }
GtBlocUIProcessTally >> gtViewFullTextReportIn: aView [
	<gtView>
	^ rootMessageTally 
		ifNil: [ aView ]
		ifNotNil: [ (rootMessageTally gtTextReportFor: aView)
			title: 'Full text report';
			priority: 60 ]
]

{ #category : #initialization }
GtBlocUIProcessTally >> initializeForUIProcessTally: aUIMessageTally withRoot: aRootMessageTally [
	| allTallies runPhase currentFramePhase |
	messageTally := aUIMessageTally.
	rootMessageTally := aRootMessageTally.
	
	allTallies := messageTally withDeepCollect: #children.
	runPhase := allTallies 
		detect: [ :each | each method selector = #runCurrentPhaseOn: ]
		ifNone: [ ^ self ].
	currentFramePhase := runPhase receivers select: [ :each | 
		each theClass inheritsFrom: BlSpaceFramePhase ].
	framePhaseTallies := currentFramePhase collect: [ :aTally |
		GtMessageTallyWrapper new
			rootMessageTally: rootMessageTally;
			messageTally: aTally ].
]

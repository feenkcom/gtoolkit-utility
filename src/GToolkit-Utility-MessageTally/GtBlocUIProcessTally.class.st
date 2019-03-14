Class {
	#name : #GtBlocUIProcessTally,
	#superclass : #GtMessageTallyWrapper,
	#instVars : [
		'framePhaseTallies'
	],
	#category : #'GToolkit-Utility-MessageTally'
}

{ #category : #ui }
GtBlocUIProcessTally >> gtViewFramePhasesListFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Frame phases' translated;
		items: [ framePhaseTallies ];
		column: 'Phase' format: #selectorDescription;
		column: 'Percentage' 
			format: [ :aTally | (aTally tallyPercentage printShowingDecimalPlaces: 1), '%']
			width: 100;
		column: 'Time' 
			format: [ :aTally | aTally timeInMilliseconds asString, 'ms' ] 
			width: 100
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

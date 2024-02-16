Class {
	#name : #GtBeaconLogEvent,
	#superclass : #GtBeaconLogBasicEvent,
	#instVars : [
		'signals'
	],
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #accessing }
GtBeaconLogEvent class >> eventLabel [
	^ 'Beacon Event'
]

{ #category : #adding }
GtBeaconLogEvent >> addSignal: aSignal [
	self signals add: aSignal
]

{ #category : #accessing }
GtBeaconLogEvent >> allSignals [

	^ GtBeaconSignalsGroup new 
		add: self eventStartedSignal;
		addAll: self subEvents allSignals;
		add: self eventCompletedSignal;
		yourself
]

{ #category : #accessing }
GtBeaconLogEvent >> descriptionOn: aStream [

	aStream << self signals first signalTypeLabel
]

{ #category : #accessing }
GtBeaconLogEvent >> duration [
	^ self eventCompletedSignal timestamp - self eventStartedSignal timestamp
]

{ #category : #accessing }
GtBeaconLogEvent >> endTimestamp [
	^ self eventCompletedSignal timestamp
]

{ #category : #accessing }
GtBeaconLogEvent >> eventCompletedSignal [
	^ self signals last
]

{ #category : #accessing }
GtBeaconLogEvent >> eventStartedSignal [
	^ self signals first
]

{ #category : #ui }
GtBeaconLogEvent >> gtBarElements [
	^ (self gtBarElementsWithGlobalWeight: 1.0 local: 1.0) asScrollableElement
		margin: (BlInsets all: 10)
]

{ #category : #accessing }
GtBeaconLogEvent >> gtBarElementsWithGlobalWeight: aWeight local: aLocalWeight [
	| taskElements aBarColor |
	
	aBarColor := BlColorTransition interpolate: Color veryLightGray to: BrGlamorousColors errorBorderColor at: aWeight.
	
	taskElements := aWeight > 0.1
		ifTrue: [
			| myDuration |		
			myDuration := self totalDuration.
	
			self subEvents collect: [ :anEvent |
				| eachWeight |
				
				eachWeight := myDuration isZero
					ifTrue: [ 0 ]
					ifFalse: [ (anEvent totalDuration / myDuration) asFloat ].
				(anEvent gtBarElementsWithGlobalWeight: eachWeight * aWeight local: eachWeight)
					constraintsDo: [ :c | c linear weight: (eachWeight max: 0.001) ] ] ]
		ifFalse: [
			self subEvents
				ifEmpty: [ #() ]
				ifNotEmpty: [ {
					BlElement new
						layout: BlLinearLayout horizontal;
						constraintsDo: [ :c |
							c horizontal matchParent.
							c vertical exact: 20 ];
						when: BlClickEvent
						do: [ :anEvent |
							anEvent consumed: true.
							anEvent currentTarget phlow spawnObject: self ];
						geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
						border: (BlBorder paint: Color transparent width: (aWeight max: 0.1));
						background: (BlLinearGradientPaint vertical stops: {
							0 -> aBarColor.
							0.4 -> (aBarColor alpha: 0.5).
							1 -> (aBarColor alpha: 0)}) } ] ].
	
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		addChild: (BlElement new
			layout: BlLinearLayout horizontal alignCenter;
			when: BlClickEvent
			do: [ :anEvent |
				anEvent consumed: true.
				anEvent currentTarget phlow spawnObject: self ];
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical exact: 20 ];
			padding: (BlInsets top: 3 bottom: 3);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			border: (BlBorder paint: Color transparent width: 0.25);
			background: aBarColor;
			in: [ :aPane | aWeight > 0.005
				ifTrue: [ aPane addChild: (BrLabel new
					aptitude: (BrGlamorousLabelAptitude new fontSize: 10);
					text: self description) asScalableElement ] ];
			yourself);
		addChild: (BlElement new
			layout: (BlLinearLayout horizontal alignTopCenter weightSum: 1);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ];
			addChildren: taskElements);
		yourself
]

{ #category : #ui }
GtBeaconLogEvent >> gtMapFor: aView [
	<gtView>

	^ aView explicit
		title: 'Duration map';
		priority: 20;
		stencil: [ self gtBarElements ]
]

{ #category : #'gt - extensions' }
GtBeaconLogEvent >> gtViewLocalSignalsFor: aView [
	<gtView>
	
	^ aView forward
	 	title: 'Signals';
	 	priority: 30;
	 	object: [ self signals ];
	 	view: #gtItemsFor:
]

{ #category : #initialization }
GtBeaconLogEvent >> initialize [ 
	super initialize.
	
	signals := GtBeaconSignalsGroup new. 
]

{ #category : #acccessing }
GtBeaconLogEvent >> signals [
	^ signals
]

{ #category : #accessing }
GtBeaconLogEvent >> startTimestamp [
	^ self eventStartedSignal timestamp
]

{ #category : #accessing }
GtBeaconLogEvent >> totalDuration [

	^ self endTimestamp - self startTimestamp
]

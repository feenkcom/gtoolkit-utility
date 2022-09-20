Class {
	#name : #GtBeaconEventsGrouper,
	#superclass : #Object,
	#instVars : [
		'rootEvents',
		'eventsStack',
		'shouldNotifyUpdates',
		'announcer'
	],
	#category : #'GToolkit-Utility-Logging'
}

{ #category : #adding }
GtBeaconEventsGrouper >> addRootEvent: anEvent [
	self rootEvents add: anEvent.
	
	self shouldNotifyUpdates ifTrue: [
		self notifyUpdateEventAdded ]
]

{ #category : #accessing }
GtBeaconEventsGrouper >> announcer [
	^ announcer
]

{ #category : #initialization }
GtBeaconEventsGrouper >> createDefaultEventsGroup [
	^ GtBeaconLogEventsGroup new
]

{ #category : #'gt - extensions' }
GtBeaconEventsGrouper >> gtOverviewFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Overview';
		priority: 5;
		items: [ self overviewData ];
		updateWhen: Announcement in: [ self announcer ];
		column: 'Property' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ]
]

{ #category : #'gt - extensions' }
GtBeaconEventsGrouper >> gtViewRootEventsFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Events';
		priority: 10;
		updateWhen: Announcement in: [ self announcer ];
		object: [ self rootEvents ];
		view: #gtItemsFor:
]

{ #category : #initialization }
GtBeaconEventsGrouper >> initialize [
	super initialize.
	
	rootEvents := self createDefaultEventsGroup.
	eventsStack := Stack new.
	shouldNotifyUpdates := false.
	announcer := Announcer new.
]

{ #category : #notifications }
GtBeaconEventsGrouper >> notifyUpdateEventAdded [
	announcer announce: Announcement
]

{ #category : #initialization }
GtBeaconEventsGrouper >> notifyUpdates [
	shouldNotifyUpdates := true
]

{ #category : #accessing }
GtBeaconEventsGrouper >> numberOfRootEvents [
	^ self rootEvents size
]

{ #category : #'accessing - overview' }
GtBeaconEventsGrouper >> overviewData [
	^ {
		'Number of Events' -> self numberOfRootEvents.
		'Total Duration' -> self totalDuration.
	} 
]

{ #category : #actions }
GtBeaconEventsGrouper >> processEvent: anEvent [
	
	eventsStack 
		ifEmpty:  [ self addRootEvent: anEvent ]
]

{ #category : #actions }
GtBeaconEventsGrouper >> processEventSignalFor: aSignal [
	| latestEvent |
	
	aSignal isStartSignalType ifTrue: [ 
		| newEvent topEvent |
		newEvent := aSignal class eventType new.
		topEvent := eventsStack size > 0 
			ifTrue: [ eventsStack top ]
			ifFalse: [ nil ] .
		topEvent 
			ifNotNil: [ 
				topEvent addSubEvent: newEvent ].
		newEvent addSignal: aSignal.
		eventsStack push: newEvent.
		^ self ].
		
	aSignal isEndSignalType ifTrue: [ 
		eventsStack top addSignal: aSignal.
		latestEvent := eventsStack pop.
		self processEvent: latestEvent ] 
]

{ #category : #actions }
GtBeaconEventsGrouper >> processEventSignalsFor: aCollectionfSignals [
	aCollectionfSignals do: [ :aSignal |
		self processEventSignalFor: aSignal ]
]

{ #category : #accessing }
GtBeaconEventsGrouper >> rootEvents [
	^ rootEvents
]

{ #category : #accessing }
GtBeaconEventsGrouper >> shouldNotifyUpdates [
	^ shouldNotifyUpdates
]

{ #category : #accessing }
GtBeaconEventsGrouper >> shouldNotifyUpdates: aBoolean [

	shouldNotifyUpdates := aBoolean
]

{ #category : #accessing }
GtBeaconEventsGrouper >> totalDuration [
	
	^ self rootEvents
		inject: 0 seconds 
		into: [ :total  :anEvent | total + anEvent duration ]
]

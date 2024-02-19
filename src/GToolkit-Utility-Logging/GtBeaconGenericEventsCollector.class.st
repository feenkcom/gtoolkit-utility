Class {
	#name : #GtBeaconGenericEventsCollector,
	#superclass : #GtBeaconEventsCollector,
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #'instance creation' }
GtBeaconGenericEventsCollector class >> forSignalType: aSignalTypeOrAnnouncementSet groupedUsing: anEventsGrouper [
	^ self new 
		initializeSignalTypesWith: aSignalTypeOrAnnouncementSet;
		initializeEventsGrouperWith: anEventsGrouper;
		yourself
]

{ #category : #accessing }
GtBeaconGenericEventsCollector >> initializeEventsGrouperWith: anEventsGrouper [
	self assert: [ logger isRunning not ].
	self assert: [ eventsGrouper numberOfRootEvents = 0 ].
	
	eventsGrouper := anEventsGrouper.
	eventsGrouper notifyUpdates.
]

{ #category : #accessing }
GtBeaconGenericEventsCollector >> initializeSignalTypesWith: aSignalClassOrAnnouncementSet [
	self assert: [ logger isRunning not ].
	
	logger
		initializeInterestingSubscriptionsWith: aSignalClassOrAnnouncementSet
]

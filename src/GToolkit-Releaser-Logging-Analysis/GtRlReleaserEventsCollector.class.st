Class {
	#name : #GtRlReleaserEventsCollector,
	#superclass : #GtBeaconEventsCollector,
	#category : #'GToolkit-Releaser-Logging-Analysis'
}

{ #category : #accessing }
GtRlReleaserEventsCollector >> createDefaultEventsGrouper [
	^ GtRlReleaserEventsGrouper new
]

{ #category : #'gt - extensions' }
GtRlReleaserEventsCollector >> gtViewGroupedByActionTypeFor:  aView [
	<gtView>
	
	^ aView forward 
		title: 'Events by Action  Type';
		priority: 15;
		object: [ eventsGrouper ];
		view: #gtViewGroupedByActionTypeFor: 
]

{ #category : #'gt - extensions' }
GtRlReleaserEventsCollector >> gtViewGroupedByRepositoryIdFor:  aView [
	<gtView>
	
	^ aView forward 
		title: 'Events by Repository';
		priority: 20;
		object: [ eventsGrouper ];
		view: #gtViewGroupedByRepositoryIdFor: 
]

{ #category : #accessing }
GtRlReleaserEventsCollector >> relevantSignalType [
	^ GtRlActionExecutionSignal
]

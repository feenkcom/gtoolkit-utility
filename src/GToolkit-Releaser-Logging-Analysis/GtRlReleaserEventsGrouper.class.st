Class {
	#name : #GtRlReleaserEventsGrouper,
	#superclass : #GtBeaconEventsGrouper,
	#category : #'GToolkit-Releaser-Logging-Analysis'
}

{ #category : #accessing }
GtRlReleaserEventsGrouper >> createDefaultEventsGroup [
	^ GtRlActionExecutedEventsGroup new
]

{ #category : #'gt - extensions' }
GtRlReleaserEventsGrouper >> gtViewGroupedByActionTypeFor:  aView [
	<gtView>
	
	^ aView forward 
		title: 'Events by Action  Type';
		priority: 15;
		object: [ self rootEvents ];
		view: #gtViewGroupedByActionTypeFor: 
]

{ #category : #'gt - extensions' }
GtRlReleaserEventsGrouper >> gtViewGroupedByRepositoryIdFor:  aView [
	<gtView>
	
	^ aView forward 
		title: 'Events by Repository';
		priority: 20;
		object: [ self rootEvents ];
		view: #gtViewGroupedByRepositoryIdFor: 
]

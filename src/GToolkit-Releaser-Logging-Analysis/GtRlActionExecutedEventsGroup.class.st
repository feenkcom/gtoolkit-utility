Class {
	#name : #GtRlActionExecutedEventsGroup,
	#superclass : #GtBeaconLogEventsGroup,
	#category : #'GToolkit-Releaser-Logging-Analysis'
}

{ #category : #'accessing - grouping' }
GtRlActionExecutedEventsGroup >> groupedByActionType [
	^ self groupedBy: [ :anEvent | anEvent actionType ]
]

{ #category : #'accessing - grouping' }
GtRlActionExecutedEventsGroup >> groupedByRepositoryId [
	^ self groupedBy: [ :anEvent | anEvent repositoryId ]
]

{ #category : #'gt - extensions' }
GtRlActionExecutedEventsGroup >> gtItemsFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Events';
		priority: 10;
		items: [ self ];
		children: #subEvents;
		column: 'Order' text: [ :anEvent | anEvent actionOrder ] width: 60;
		column: 'Releaser Action' text: [ :anEvent | anEvent actionType ];
		column: 'Timestamp' 
			text: [ :anEvent | anEvent timestamp printToSeconds ] 
			width: 125;
		column: 'Duration' 
			text: [ :anEvent | anEvent duration ] 
			width: 125;
		column: 'Repository' 
			text: [ :anEvent | anEvent repositoryId ]
]

{ #category : #accessing }
GtRlActionExecutedEventsGroup >> gtViewGroupedByActionTypeFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'By action type';
		priority: 15;
		items: [ self groupedByActionType associations
			sorted: [ :assoc | assoc value totalDuration ] descending  ];
		column: 'Action Type' text: [ :assoc | assoc key ];
		column: 'Count' text: [ :assoc | assoc value size ] width: 120;
		column: 'Duration' text: [ :assoc | assoc value totalDuration ];
		send: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtRlActionExecutedEventsGroup >> gtViewGroupedByRepositoryIdFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'By repository';
		priority: 20;
		items: [ self groupedByRepositoryId associations
			sorted: [ :assoc | assoc value totalDuration ] descending ];
		column: 'Repository' text: [ :assoc | assoc key ];
		column: 'Count' text: [ :assoc | assoc value size ] width: 120;
		column: 'Duration' text: [ :assoc | assoc value totalDuration ];
		send: [ :assoc | assoc value ]
]

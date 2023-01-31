Class {
	#name : #GtRlActionExecutedEvent,
	#superclass : #GtBeaconLogEvent,
	#category : #'GToolkit-Releaser-Logging-Analysis'
}

{ #category : #accessing }
GtRlActionExecutedEvent class >> eventLabel [
	^ 'Action Executed'
]

{ #category : #accessing }
GtRlActionExecutedEvent >> actionOrder [ 
	^ self eventStartedSignal actionOrder
]

{ #category : #accessing }
GtRlActionExecutedEvent >> actionProperties [ 
	^ {
		'Duration' -> self duration.
		'Start Timestamp' -> self startTimestamp.
		'End Timestamp' -> self endTimestamp.
		'Process Id' -> self eventStartedSignal processId.
	} asOrderedDictionary, self eventStartedSignal actionProperties
]

{ #category : #accessing }
GtRlActionExecutedEvent >> actionType [ 
	^ self eventStartedSignal actionType
]

{ #category : #printing }
GtRlActionExecutedEvent >> descriptionOn: aStream [
	aStream 
		<< self actionType;	
		<< ', '.
		
	super descriptionOn: aStream
]

{ #category : #'gt - extensions' }
GtRlActionExecutedEvent >> gtViewDetailsFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Details';
		priority: 5;
		items: [ self actionProperties  associations ];
		column: 'Property' text: [ :assoc | assoc key ] width: 150;
		column: 'Property' text: [ :assoc | assoc value ];
		send: [ :assoc | assoc value ]
]

{ #category : #accessing }
GtRlActionExecutedEvent >> repositoryId [ 
	^ self eventStartedSignal repositoryId
]

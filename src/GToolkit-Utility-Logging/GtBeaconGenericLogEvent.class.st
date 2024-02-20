Class {
	#name : #GtBeaconGenericLogEvent,
	#superclass : #GtBeaconLogEvent,
	#category : #'GToolkit-Utility-Logging-Core'
}

{ #category : #printing }
GtBeaconGenericLogEvent >> descriptionOn: aStream [
	super descriptionOn: aStream.
	
	self signals first signalLabel ifNotNil: [ :aString |
		aStream 
			space;
			nextPutAll: aString ].
	
	aStream 
		nextPutAll: ' | ';
		nextPutAll: self signals first eventTypeLabel
]

{ #category : #accessing }
GtBeaconGenericLogEvent >> eventLabel [
	^ self signals first eventTypeLabel
]

{ #category : #printing }
GtBeaconGenericLogEvent >> shortDescriptionOn: aStream [
	self signals first signalLabel 
		ifNil: [
			aStream nextPutAll: self signals first eventTypeLabel]
		ifNotNil: [ :aString |
			aStream 
				nextPutAll: aString ]
]

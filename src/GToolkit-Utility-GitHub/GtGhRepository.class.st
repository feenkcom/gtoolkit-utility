Class {
	#name : #GtGhRepository,
	#superclass : #GtGhEntity,
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #accessing }
GtGhRepository >> createdAt [
	^ DateAndTime fromString: (self rawData at: 'created_at')
]

{ #category : #accessing }
GtGhRepository >> description [
	^ self rawData at: 'description'
]

{ #category : #accessing }
GtGhRepository >> isForked [ 
	^ self rawData at: 'fork'
]

{ #category : #accessing }
GtGhRepository >> name [ 
	^ self rawData at: 'name'
]

{ #category : #printing }
GtGhRepository >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream << self name ]
]

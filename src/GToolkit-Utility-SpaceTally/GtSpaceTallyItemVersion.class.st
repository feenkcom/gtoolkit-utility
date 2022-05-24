Class {
	#name : #GtSpaceTallyItemVersion,
	#superclass : #Object,
	#instVars : [
		'tallyVersion',
		'tallyItem'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtSpaceTallyItemVersion >> analyzedClassName [
	^ self tallyItem analyzedClassName
]

{ #category : #printing }
GtSpaceTallyItemVersion >> descriptionOn: aStream [
	aStream 
		print:  self tallyVersion index;
		nextPutAll: ', '.
	self tallyItem gtDescriptionOn: aStream
]

{ #category : #accessing }
GtSpaceTallyItemVersion >> instanceCount [
	^ self tallyItem instanceCount
]

{ #category : #printing }
GtSpaceTallyItemVersion >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: '('.
	self descriptionOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #accessing }
GtSpaceTallyItemVersion >> spaceForInstances [
	^ self tallyItem spaceForInstances
]

{ #category : #accessing }
GtSpaceTallyItemVersion >> tallyItem [

	^ tallyItem
]

{ #category : #accessing }
GtSpaceTallyItemVersion >> tallyItem: anObject [

	tallyItem := anObject
]

{ #category : #accessing }
GtSpaceTallyItemVersion >> tallyVersion [

	^ tallyVersion
]

{ #category : #accessing }
GtSpaceTallyItemVersion >> tallyVersion: anObject [

	tallyVersion := anObject
]

Class {
	#name : #GtSpaceTallyItemTallyVersion,
	#superclass : #Object,
	#instVars : [
		'tallyVersion',
		'tallyItem'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #printing }
GtSpaceTallyItemTallyVersion >> descriptionOn: aStream [
	aStream 
		print:  self tallyVersion index;
		nextPutAll: ', '.
	self tallyItem gtDescriptionOn: aStream
]

{ #category : #printing }
GtSpaceTallyItemTallyVersion >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: '('.
	self descriptionOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #accessing }
GtSpaceTallyItemTallyVersion >> spaceForInstances [
	^ self tallyItem spaceForInstances
]

{ #category : #accessing }
GtSpaceTallyItemTallyVersion >> tallyItem [

	^ tallyItem
]

{ #category : #accessing }
GtSpaceTallyItemTallyVersion >> tallyItem: anObject [

	tallyItem := anObject
]

{ #category : #accessing }
GtSpaceTallyItemTallyVersion >> tallyVersion [

	^ tallyVersion
]

{ #category : #accessing }
GtSpaceTallyItemTallyVersion >> tallyVersion: anObject [

	tallyVersion := anObject
]

{ #category : #accessing }
GtSpaceTallyItemTallyVersion >> totalInstCount [
	self subclassResponsibility
]

{ #category : #accessing }
GtSpaceTallyItemTallyVersion >> totalInstSpace [
	self subclassResponsibility
]

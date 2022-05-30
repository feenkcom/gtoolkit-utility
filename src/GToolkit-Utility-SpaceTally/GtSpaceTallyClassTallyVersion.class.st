Class {
	#name : #GtSpaceTallyClassTallyVersion,
	#superclass : #GtSpaceTallyItemTallyVersion,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtSpaceTallyClassTallyVersion >> analyzedClassName [
	^ self tallyItem analyzedClassName
]

{ #category : #printing }
GtSpaceTallyClassTallyVersion >> descriptionOn: aStream [
	aStream 
		print:  self tallyVersion index;
		nextPutAll: ', '.
	self tallyItem gtDescriptionOn: aStream
]

{ #category : #accessing }
GtSpaceTallyClassTallyVersion >> totalInstCount [
	^ self tallyItem instanceCount 
]

{ #category : #accessing }
GtSpaceTallyClassTallyVersion >> totalInstSpace [
	^ self tallyItem spaceForInstances
]

Class {
	#name : #GtSpaceTallyPackageTallyVersion,
	#superclass : #GtSpaceTallyItemTallyVersion,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtSpaceTallyPackageTallyVersion >> analyzedPackageName [
	^ self tallyItem analyzedPackageName
]

{ #category : #printing }
GtSpaceTallyPackageTallyVersion >> descriptionOn: aStream [
	aStream 
		print:  self tallyVersion index;
		nextPutAll: ', '.
	self tallyItem gtDescriptionOn: aStream
]

{ #category : #accessing }
GtSpaceTallyPackageTallyVersion >> totalInstCount [
	^ self tallyItem totalInstCount
]

{ #category : #accessing }
GtSpaceTallyPackageTallyVersion >> totalInstSpace [
	^ self tallyItem totalInstSpace
]

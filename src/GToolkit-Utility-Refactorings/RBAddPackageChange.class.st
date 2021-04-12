Class {
	#name : #RBAddPackageChange,
	#superclass : #RBPackageChange,
	#category : #'GToolkit-Utility-Refactorings-Changes'
}

{ #category : #converting }
RBAddPackageChange >> asUndoOperation [
	^ RBRemovePackageChange packageName: packageName
]

{ #category : #private }
RBAddPackageChange >> primitiveExecute [	
	(RPackage organizer includesPackageNamed: packageName)
		ifTrue: [ ^ self ].

	RPackage organizer createPackageNamed: packageName
]

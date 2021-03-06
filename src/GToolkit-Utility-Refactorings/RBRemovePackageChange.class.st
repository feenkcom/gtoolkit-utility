Class {
	#name : #RBRemovePackageChange,
	#superclass : #RBPackageChange,
	#category : #'GToolkit-Utility-Refactorings-Changes'
}

{ #category : #converting }
RBRemovePackageChange >> asUndoOperation [
	^ RBAddPackageChange packageName: packageName
]

{ #category : #private }
RBRemovePackageChange >> primitiveExecute [
	(RPackageOrganizer default
		packageNamed: packageName asSymbol
		ifAbsent: [ ^ self ]) unregister
]

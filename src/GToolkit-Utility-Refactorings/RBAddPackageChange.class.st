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
	RPackageOrganizer default createPackageNamed: packageName
]

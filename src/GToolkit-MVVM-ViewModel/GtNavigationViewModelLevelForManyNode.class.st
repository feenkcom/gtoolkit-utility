Class {
	#name : #GtNavigationViewModelLevelForManyNode,
	#superclass : #GtNavigationViewModelSimpleLevelNode,
	#instVars : [
		'suffix'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelLevelForManyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLevelForMany: self
]

{ #category : #accessing }
GtNavigationViewModelLevelForManyNode >> fullNameString [
	^ self nameString, self suffix source
]

{ #category : #generated }
GtNavigationViewModelLevelForManyNode >> suffix [
	^ suffix
]

{ #category : #generated }
GtNavigationViewModelLevelForManyNode >> suffix: aSmaCCToken [
	suffix := aSmaCCToken
]

{ #category : #generated }
GtNavigationViewModelLevelForManyNode >> tokenVariables [
	^ #(#suffix #name)
]

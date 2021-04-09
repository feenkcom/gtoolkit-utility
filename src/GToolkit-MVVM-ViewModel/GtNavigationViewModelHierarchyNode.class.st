Class {
	#name : #GtNavigationViewModelHierarchyNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelHierarchyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitHierarchy: self
]

{ #category : #generated }
GtNavigationViewModelHierarchyNode >> level [
	^ level
]

{ #category : #generated }
GtNavigationViewModelHierarchyNode >> level: aGtNavigationViewModelLevelNode [
	self level notNil
		ifTrue: [ self level parent: nil ].
	level := aGtNavigationViewModelLevelNode.
	self level notNil
		ifTrue: [ self level parent: self ]
]

{ #category : #generated }
GtNavigationViewModelHierarchyNode >> nodeVariables [
	^ #(#level)
]

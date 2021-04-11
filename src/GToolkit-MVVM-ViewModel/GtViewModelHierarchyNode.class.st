Class {
	#name : #GtViewModelHierarchyNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelHierarchyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitHierarchy: self
]

{ #category : #generated }
GtViewModelHierarchyNode >> level [
	^ level
]

{ #category : #generated }
GtViewModelHierarchyNode >> level: aGtViewModelLevelNode [
	self level notNil
		ifTrue: [ self level parent: nil ].
	level := aGtViewModelLevelNode.
	self level notNil
		ifTrue: [ self level parent: self ]
]

{ #category : #generated }
GtViewModelHierarchyNode >> nodeVariables [
	^ #(#level)
]

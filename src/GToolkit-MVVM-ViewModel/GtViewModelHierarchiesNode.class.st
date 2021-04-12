Class {
	#name : #GtViewModelHierarchiesNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'hierarchies'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelHierarchiesNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitHierarchies: self
]

{ #category : #generated }
GtViewModelHierarchiesNode >> compositeNodeVariables [
	^ #(#hierarchies)
]

{ #category : #generated }
GtViewModelHierarchiesNode >> hierarchies [
	^ hierarchies
]

{ #category : #generated }
GtViewModelHierarchiesNode >> hierarchies: anOrderedCollection [
	self setParents: self hierarchies to: nil.
	hierarchies := anOrderedCollection.
	self setParents: self hierarchies to: self
]

{ #category : #'generated-initialize-release' }
GtViewModelHierarchiesNode >> initialize [
	super initialize.
	hierarchies := OrderedCollection new: 2.
]

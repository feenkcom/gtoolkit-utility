Class {
	#name : #GtNavigationViewModelCompositeLevelNode,
	#superclass : #GtNavigationViewModelLevelNode,
	#instVars : [
		'items',
		'and'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelCompositeLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitCompositeLevel: self
]

{ #category : #generated }
GtNavigationViewModelCompositeLevelNode >> and [
	^ and
]

{ #category : #generated }
GtNavigationViewModelCompositeLevelNode >> and: aSmaCCToken [
	and := aSmaCCToken
]

{ #category : #generated }
GtNavigationViewModelCompositeLevelNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #'generated-initialize-release' }
GtNavigationViewModelCompositeLevelNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
]

{ #category : #testing }
GtNavigationViewModelCompositeLevelNode >> isCompositeLevel [
	^ true
]

{ #category : #generated }
GtNavigationViewModelCompositeLevelNode >> items [
	^ items
]

{ #category : #generated }
GtNavigationViewModelCompositeLevelNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]

{ #category : #generated }
GtNavigationViewModelCompositeLevelNode >> tokenVariables [
	^ #(#and)
]

Class {
	#name : #GtViewModelCompositeLevelNode,
	#superclass : #GtViewModelLevelNode,
	#instVars : [
		'items',
		'and'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelCompositeLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitCompositeLevel: self
]

{ #category : #generated }
GtViewModelCompositeLevelNode >> and [
	^ and
]

{ #category : #generated }
GtViewModelCompositeLevelNode >> and: aSmaCCToken [
	and := aSmaCCToken
]

{ #category : #generated }
GtViewModelCompositeLevelNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #'generated-initialize-release' }
GtViewModelCompositeLevelNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
]

{ #category : #testing }
GtViewModelCompositeLevelNode >> isCompositeLevel [
	^ true
]

{ #category : #generated }
GtViewModelCompositeLevelNode >> items [
	^ items
]

{ #category : #generated }
GtViewModelCompositeLevelNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]

{ #category : #generated }
GtViewModelCompositeLevelNode >> tokenVariables [
	^ #(#and)
]

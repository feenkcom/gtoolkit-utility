Class {
	#name : #GtNavigationViewModelPropertiesNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'properties'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelPropertiesNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProperties: self
]

{ #category : #generated }
GtNavigationViewModelPropertiesNode >> compositeNodeVariables [
	^ #(#properties)
]

{ #category : #'generated-initialize-release' }
GtNavigationViewModelPropertiesNode >> initialize [
	super initialize.
	properties := OrderedCollection new: 2.
]

{ #category : #generated }
GtNavigationViewModelPropertiesNode >> properties [
	^ properties
]

{ #category : #generated }
GtNavigationViewModelPropertiesNode >> properties: anOrderedCollection [
	self setParents: self properties to: nil.
	properties := anOrderedCollection.
	self setParents: self properties to: self
]

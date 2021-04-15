Class {
	#name : #GtViewModelSettingPropertiesListNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'properties'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelSettingPropertiesListNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSettingPropertiesList: self
]

{ #category : #generated }
GtViewModelSettingPropertiesListNode >> compositeNodeVariables [
	^ #(#properties)
]

{ #category : #'generated-initialize-release' }
GtViewModelSettingPropertiesListNode >> initialize [
	super initialize.
	properties := OrderedCollection new: 2.
]

{ #category : #generated }
GtViewModelSettingPropertiesListNode >> properties [
	^ properties
]

{ #category : #generated }
GtViewModelSettingPropertiesListNode >> properties: anOrderedCollection [
	self setParents: self properties to: nil.
	properties := anOrderedCollection.
	self setParents: self properties to: self
]

Class {
	#name : #GtViewModelSettingsNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'settings'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelSettingsNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSettings: self
]

{ #category : #generated }
GtViewModelSettingsNode >> compositeNodeVariables [
	^ #(#settings)
]

{ #category : #'generated-initialize-release' }
GtViewModelSettingsNode >> initialize [
	super initialize.
	settings := OrderedCollection new: 2.
]

{ #category : #generated }
GtViewModelSettingsNode >> settings [
	^ settings
]

{ #category : #generated }
GtViewModelSettingsNode >> settings: anOrderedCollection [
	self setParents: self settings to: nil.
	settings := anOrderedCollection.
	self setParents: self settings to: self
]

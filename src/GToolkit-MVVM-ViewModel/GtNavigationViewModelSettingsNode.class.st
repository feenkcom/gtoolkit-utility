Class {
	#name : #GtNavigationViewModelSettingsNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'settings'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelSettingsNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSettings: self
]

{ #category : #generated }
GtNavigationViewModelSettingsNode >> compositeNodeVariables [
	^ #(#settings)
]

{ #category : #'generated-initialize-release' }
GtNavigationViewModelSettingsNode >> initialize [
	super initialize.
	settings := OrderedCollection new: 2.
]

{ #category : #generated }
GtNavigationViewModelSettingsNode >> settings [
	^ settings
]

{ #category : #generated }
GtNavigationViewModelSettingsNode >> settings: anOrderedCollection [
	self setParents: self settings to: nil.
	settings := anOrderedCollection.
	self setParents: self settings to: self
]

Class {
	#name : #GtNavigationViewModelSettingNode,
	#superclass : #GtNavigationViewModelProgramNode,
	#instVars : [
		'_at',
		'name',
		'value'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelSettingNode >> _at [
	^ _at
]

{ #category : #generated }
GtNavigationViewModelSettingNode >> _at: aSmaCCToken [
	_at := aSmaCCToken
]

{ #category : #generated }
GtNavigationViewModelSettingNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSetting: self
]

{ #category : #accessing }
GtNavigationViewModelSettingNode >> literalString [
	^ self value source
]

{ #category : #generated }
GtNavigationViewModelSettingNode >> name [
	^ name
]

{ #category : #generated }
GtNavigationViewModelSettingNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtNavigationViewModelSettingNode >> nameString [
	^ self name source
]

{ #category : #generated }
GtNavigationViewModelSettingNode >> nodeVariables [
	^ #(#value)
]

{ #category : #generated }
GtNavigationViewModelSettingNode >> tokenVariables [
	^ #(#_at #name)
]

{ #category : #generated }
GtNavigationViewModelSettingNode >> value [
	^ value
]

{ #category : #generated }
GtNavigationViewModelSettingNode >> value: aGtNavigationViewModelPropertyValueNode [
	self value notNil
		ifTrue: [ self value parent: nil ].
	value := aGtNavigationViewModelPropertyValueNode.
	self value notNil
		ifTrue: [ self value parent: self ]
]

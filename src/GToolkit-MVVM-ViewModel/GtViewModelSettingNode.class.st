Class {
	#name : #GtViewModelSettingNode,
	#superclass : #GtViewModelProgramNode,
	#instVars : [
		'_at',
		'name',
		'value',
		'properties'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelSettingNode >> _at [
	^ _at
]

{ #category : #generated }
GtViewModelSettingNode >> _at: aSmaCCToken [
	_at := aSmaCCToken
]

{ #category : #generated }
GtViewModelSettingNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSetting: self
]

{ #category : #accessing }
GtViewModelSettingNode >> literalValue [
	^ self value literalValue
]

{ #category : #generated }
GtViewModelSettingNode >> name [
	^ name
]

{ #category : #generated }
GtViewModelSettingNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtViewModelSettingNode >> nameString [
	^ self name source
]

{ #category : #generated }
GtViewModelSettingNode >> nodeVariables [
	^ #(#value #properties)
]

{ #category : #generated }
GtViewModelSettingNode >> properties [
	^ properties
]

{ #category : #generated }
GtViewModelSettingNode >> properties: aGtViewModelSettingPropertiesListNode [
	self properties notNil
		ifTrue: [ self properties parent: nil ].
	properties := aGtViewModelSettingPropertiesListNode.
	self properties notNil
		ifTrue: [ self properties parent: self ]
]

{ #category : #generated }
GtViewModelSettingNode >> tokenVariables [
	^ #(#_at #name)
]

{ #category : #generated }
GtViewModelSettingNode >> value [
	^ value
]

{ #category : #generated }
GtViewModelSettingNode >> value: aGtViewModelPropertyValueNode [
	self value notNil
		ifTrue: [ self value parent: nil ].
	value := aGtViewModelPropertyValueNode.
	self value notNil
		ifTrue: [ self value parent: self ]
]

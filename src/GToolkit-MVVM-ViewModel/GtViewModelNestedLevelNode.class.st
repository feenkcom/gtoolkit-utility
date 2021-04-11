Class {
	#name : #GtViewModelNestedLevelNode,
	#superclass : #GtViewModelLevelNode,
	#instVars : [
		'parentLevel',
		'follows',
		'childLevel'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelNestedLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNestedLevel: self
]

{ #category : #generated }
GtViewModelNestedLevelNode >> childLevel [
	^ childLevel
]

{ #category : #generated }
GtViewModelNestedLevelNode >> childLevel: aGtViewModelLevelNode [
	self childLevel notNil
		ifTrue: [ self childLevel parent: nil ].
	childLevel := aGtViewModelLevelNode.
	self childLevel notNil
		ifTrue: [ self childLevel parent: self ]
]

{ #category : #generated }
GtViewModelNestedLevelNode >> follows [
	^ follows
]

{ #category : #generated }
GtViewModelNestedLevelNode >> follows: aSmaCCToken [
	follows := aSmaCCToken
]

{ #category : #accessing }
GtViewModelNestedLevelNode >> fullNameString [
	^ self parentLevel fullNameString
]

{ #category : #accessing }
GtViewModelNestedLevelNode >> nameString [
	^ self parentLevel nameString
]

{ #category : #generated }
GtViewModelNestedLevelNode >> nodeVariables [
	^ #(#parentLevel #childLevel)
]

{ #category : #generated }
GtViewModelNestedLevelNode >> parentLevel [
	^ parentLevel
]

{ #category : #generated }
GtViewModelNestedLevelNode >> parentLevel: aGtViewModelSimpleLevelNode [
	self parentLevel notNil
		ifTrue: [ self parentLevel parent: nil ].
	parentLevel := aGtViewModelSimpleLevelNode.
	self parentLevel notNil
		ifTrue: [ self parentLevel parent: self ]
]

{ #category : #generated }
GtViewModelNestedLevelNode >> tokenVariables [
	^ #(#follows)
]

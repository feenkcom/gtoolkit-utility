Class {
	#name : #GtNavigationViewModelNestedLevelNode,
	#superclass : #GtNavigationViewModelLevelNode,
	#instVars : [
		'parentLevel',
		'follows',
		'childLevel'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelNestedLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNestedLevel: self
]

{ #category : #generated }
GtNavigationViewModelNestedLevelNode >> childLevel [
	^ childLevel
]

{ #category : #generated }
GtNavigationViewModelNestedLevelNode >> childLevel: aGtNavigationViewModelLevelNode [
	self childLevel notNil
		ifTrue: [ self childLevel parent: nil ].
	childLevel := aGtNavigationViewModelLevelNode.
	self childLevel notNil
		ifTrue: [ self childLevel parent: self ]
]

{ #category : #generated }
GtNavigationViewModelNestedLevelNode >> follows [
	^ follows
]

{ #category : #generated }
GtNavigationViewModelNestedLevelNode >> follows: aSmaCCToken [
	follows := aSmaCCToken
]

{ #category : #accessing }
GtNavigationViewModelNestedLevelNode >> fullNameString [
	^ self parentLevel fullNameString
]

{ #category : #accessing }
GtNavigationViewModelNestedLevelNode >> nameString [
	^ self parentLevel nameString
]

{ #category : #generated }
GtNavigationViewModelNestedLevelNode >> nodeVariables [
	^ #(#parentLevel #childLevel)
]

{ #category : #generated }
GtNavigationViewModelNestedLevelNode >> parentLevel [
	^ parentLevel
]

{ #category : #generated }
GtNavigationViewModelNestedLevelNode >> parentLevel: aGtNavigationViewModelSimpleLevelNode [
	self parentLevel notNil
		ifTrue: [ self parentLevel parent: nil ].
	parentLevel := aGtNavigationViewModelSimpleLevelNode.
	self parentLevel notNil
		ifTrue: [ self parentLevel parent: self ]
]

{ #category : #generated }
GtNavigationViewModelNestedLevelNode >> tokenVariables [
	^ #(#follows)
]

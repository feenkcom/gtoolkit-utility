Class {
	#name : #RBClassWithTrait,
	#superclass : #RBClass,
	#instVars : [
		'traitExpression'
	],
	#category : #'GToolkit-Utility-Refactorings-Support'
}

{ #category : #converting }
RBClassWithTrait >> asClassWithTrait [
	^ self
]

{ #category : #accessing }
RBClassWithTrait >> traitExpression [
	^ traitExpression ifNil: [ traitExpression := super traitExpression ]
]

{ #category : #accessing }
RBClassWithTrait >> traitExpression: aString [
	traitExpression := aString
]

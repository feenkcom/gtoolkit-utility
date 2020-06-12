Class {
	#name : #GtRBAddTraitUsageToClassByNameTransformation,
	#superclass : #RBRefactoring,
	#instVars : [
		'className',
		'traitName'
	],
	#category : #'GToolkit-Utility-Refactorings'
}

{ #category : #'instance creation' }
GtRBAddTraitUsageToClassByNameTransformation class >> traitName: aTraitName inClassNamed: aClassName [
	^ self new
		className: aClassName asSymbol 
		traitName: aTraitName asSymbol
]

{ #category : #private }
GtRBAddTraitUsageToClassByNameTransformation >> checkClassDoesNotIncludeTraitFor: aClass [ 
	aClass withAllSuperclasses
		do: [ :each | 
			(self includesTrait: traitName in: each)
				ifTrue: [ ^ self
						refactoringError: traitName , ' is already included in ' , each name ] ]
]

{ #category : #'initialize-release' }
GtRBAddTraitUsageToClassByNameTransformation >> className: aClassName traitName: aTraitName [
	className := aClassName.
	traitName := aTraitName
]

{ #category : #private }
GtRBAddTraitUsageToClassByNameTransformation >> includesTrait: aString in: aRBClass [
	| expression |
	aRBClass traitExpression isNil
		ifTrue: [ ^ false ].
	expression := RBParser parseExpression: aRBClass traitExpression.
	expression
		nodesDo: [ :node | 
			(node isVariable and: [ node name = aString ])
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #preconditions }
GtRBAddTraitUsageToClassByNameTransformation >> preconditions [
	| class |
	class := (self model classNamed: className) asClassWithTrait.
	
	^ (RBCondition isMetaclass: class) not
		&
			(RBCondition
				withBlock: [ | trait |
					trait := Smalltalk globals
						at: traitName asSymbol
						ifAbsent: [ ^ self refactoringError: traitName , ' does not exist' ].
					trait isTrait
						ifFalse: [ ^ self refactoringError: traitName , ' is not a trait' ].
					true ])
		&
			(RBCondition
				withBlock: [ self checkClassDoesNotIncludeTraitFor: class.
					true ])
]

{ #category : #transforming }
GtRBAddTraitUsageToClassByNameTransformation >> transform [
	| newExpression class |
	class := self model classNamed: className.
	newExpression := class traitExpression
		ifNil: [ traitName ]
		ifNotNil: [ :exp | exp , ' + ' , traitName ].
	class traitExpression: newExpression.
	self model changes defineClass: class gtDefinitionString
]

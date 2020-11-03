Class {
	#name : #RBAddTraitUsageRefactoring,
	#superclass : #RBTraitRefactoring,
	#category : #'GToolkit-Utility-Refactorings-Refactorings'
}

{ #category : #private }
RBAddTraitUsageRefactoring >> checkClassDoesNotIncludeTrait [
	class := class asClassWithTrait.
	class withAllSuperclasses
		do: [ :each | 
			(self includesTrait: traitName in: each)
				ifTrue: [ ^ self
						refactoringError: traitName , ' is already included in ' , each name ] ]
]

{ #category : #preconditions }
RBAddTraitUsageRefactoring >> preconditions [
	^ super preconditions
		&
			(RBCondition
				withBlock: [ self checkClassDoesNotIncludeTrait.
					true ])
]

{ #category : #transforming }
RBAddTraitUsageRefactoring >> transform [
	| newExpression |
	newExpression := class traitExpression
		ifNil: [ traitName ]
		ifNotNil: [ :exp | exp , ' + ' , traitName ].
	class traitExpression: newExpression.
	self model changes defineClass: class gtDefinitionString
]

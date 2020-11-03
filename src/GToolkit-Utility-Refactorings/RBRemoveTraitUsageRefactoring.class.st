Class {
	#name : #RBRemoveTraitUsageRefactoring,
	#superclass : #RBTraitRefactoring,
	#category : #'GToolkit-Utility-Refactorings-Refactorings'
}

{ #category : #preconditions }
RBRemoveTraitUsageRefactoring >> checkClassIncludesTrait [
	class := class asClassWithTrait.
	(self includesTrait: traitName in: class)
		ifFalse:
			[ ^ self refactoringError: traitName , ' is not used in ' , class name ]
]

{ #category : #preconditions }
RBRemoveTraitUsageRefactoring >> preconditions [
	^ super preconditions
		&
			(RBCondition
				withBlock: [ self checkClassIncludesTrait.
					true ])
]

{ #category : #transforming }
RBRemoveTraitUsageRefactoring >> removeTraitFromExpression: anAST [
	anAST isVariable
		ifTrue: [ ^ anAST name = traitName
				ifTrue: [ nil ]
				ifFalse: [ anAST ] ].
	(anAST isMessage and: [ anAST isBinary ])
		ifTrue: [ | left right |
			left := self removeTraitFromExpression: anAST receiver.
			right := self removeTraitFromExpression: anAST arguments first.
			right isNil
				ifTrue: [ ^ left ].
			left isNil
				ifTrue: [ ^ anAST selector = #-
						ifTrue: [ nil ]
						ifFalse: [ right ] ].
			^ RBMessageNode
				receiver: left
				selector: anAST selector
				arguments: {right} ].
	anAST isLiteral
		ifTrue: [ ^ anAST ].
	self refactoringError: 'Unknown trait expression'
]

{ #category : #transforming }
RBRemoveTraitUsageRefactoring >> traitExpressionAfterRemoval [
	| expression ast |
	expression := class traitExpression.
	ast := RBParser parseExpression: expression.
	ast := self removeTraitFromExpression: ast.
	^ ast isNil
		ifTrue: [ '{}' ]
		ifFalse: [ ast formattedCode ]
]

{ #category : #transforming }
RBRemoveTraitUsageRefactoring >> transform [
	class traitExpression: self traitExpressionAfterRemoval.
	self model changes defineClass: class gtDefinitionString
]

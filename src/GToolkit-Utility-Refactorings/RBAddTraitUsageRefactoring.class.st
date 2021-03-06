Class {
	#name : #RBAddTraitUsageRefactoring,
	#superclass : #RBTraitRefactoring,
	#category : #'GToolkit-Utility-Refactorings-Refactorings'
}

{ #category : #private }
RBAddTraitUsageRefactoring >> checkClassDoesNotHaveSameSlotsAsTrait [
	| aTrait theTraitSlots aClass |

	aClass := class.
	aTrait := Smalltalk globals
		at: traitName asSymbol
		ifAbsent: [ ^ false ].

	theTraitSlots := aTrait slotNames asSet.
	({ aClass }, aClass allSubclasses, aClass allSuperclasses) do: [ :eachClass |
		| theClassSlotNames |
		theClassSlotNames := eachClass instanceVariableNames.
		theClassSlotNames
			do: [ :eachSlotName |
				(theTraitSlots includes: eachSlotName)
					ifTrue: [
						^ false ] ] ].
			
	^ true
]

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
	^ (super preconditions
		&
			(RBCondition
				withBlock: [ self checkClassDoesNotIncludeTrait.
					true ]))
				&
			(RBCondition
				withBlock: [ self checkClassDoesNotHaveSameSlotsAsTrait ]
				errorString: 'Class (superclasses or subclasses) already has slot from the ', traitName)
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

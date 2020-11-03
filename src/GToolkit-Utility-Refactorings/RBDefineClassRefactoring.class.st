Class {
	#name : #RBDefineClassRefactoring,
	#superclass : #RBClassRefactoring,
	#instVars : [
		'definitionString',
		'superclass',
		'category'
	],
	#category : #'GToolkit-Utility-Refactorings-Refactorings'
}

{ #category : #'instance creation' }
RBDefineClassRefactoring class >> model: aRBSmalltalk addClass: aName superclass: aSuperclassName category: aSymbol definition: aString [
	^self new
		model: aRBSmalltalk;
		addClass: aName
			superclass: aSuperclassName
			category: aSymbol 
			definition: aString;
		yourself
]

{ #category : #accessing }
RBDefineClassRefactoring >> addClass: aName superclass: aSuperclassName category: aSymbol definition: aString [ 
	self className: aName.
	superclass := self classObjectFor: aSuperclassName.
	category := aSymbol.

	definitionString := aString
]

{ #category : #accessing }
RBDefineClassRefactoring >> definition: aString [
	definitionString := aString
	
]

{ #category : #preconditions }
RBDefineClassRefactoring >> preconditions [
	| cond |
	cond := ((RBCondition isMetaclass: superclass) 
				errorMacro: 'Superclass must not be a metaclass') not.

	^ cond & (RBCondition isValidClassName: className) 
		& (RBCondition isGlobal: className in: self model) not 
			& (RBCondition isSymbol: category) 
			& ((RBCondition withBlock: [category isNotEmpty ]) 
					errorMacro: 'Invalid category name')
]

{ #category : #transforming }
RBDefineClassRefactoring >> transform [
	self model changes defineClass: definitionString
]

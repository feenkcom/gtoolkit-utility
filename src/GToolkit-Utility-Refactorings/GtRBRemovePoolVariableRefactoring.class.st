Class {
	#name : #GtRBRemovePoolVariableRefactoring,
	#superclass : #RBVariableRefactoring,
	#category : #'GToolkit-Utility-Refactorings-Refactorings'
}

{ #category : #preconditions }
GtRBRemovePoolVariableRefactoring >> checkClassReferencePoolVariable: anAssociation [
	class withAllSubclasses
		do: [ :sub | 
			sub realClass
				ifNotNil: [ :cls | 
					[ :behavior | 
					"Should look in the model, but currently that is not supported"
					(behavior whichSelectorsReferTo: anAssociation)
						ifNotEmpty: [ :sel | 
							self
								refactoringError:
									behavior name asString , '>>' , sel first , ' references '
										, anAssociation key ] ]
						value: cls;
						value: cls class ] ]
]

{ #category : #preconditions }
GtRBRemovePoolVariableRefactoring >> checkReferenceToPoolDictionary [
	| newPool |
	newPool := Smalltalk globals at: variableName asSymbol.
	newPool
		bindingsDo:
			[ :binding | self checkClassReferencePoolVariable: binding ]
]

{ #category : #preconditions }
GtRBRemovePoolVariableRefactoring >> preconditions [
	^ (RBCondition isMetaclass: class) not
		& (RBCondition includesPoolDictionary: variableName in: class)
		&
			(RBCondition
				withBlock: [ self checkReferenceToPoolDictionary.
					true ])
]

{ #category : #transforming }
GtRBRemovePoolVariableRefactoring >> transform [
	class removePoolDictionary: variableName asSymbol
]
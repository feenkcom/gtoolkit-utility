Class {
	#name : #RBChangeSuperclassRefactoring,
	#superclass : #RBClassRefactoring,
	#instVars : [
		'class',
		'newSuperclass'
	],
	#category : #'GToolkit-Utility-Refactorings-Refactorings'
}

{ #category : #'instance creation' }
RBChangeSuperclassRefactoring class >> changeSuperclassOf: aClass to: superClass [
	^ self new
		changeSuperclassOf: aClass to: superClass;
		yourself
]

{ #category : #'initialize-release' }
RBChangeSuperclassRefactoring >> changeSuperclassOf: aClass to: superClass [
	className := aClass name.
	class := self model classFor: aClass.
	class gtRemoveSlotsFromTraits.
	newSuperclass := self model classFor: superClass
]

{ #category : #preconditions }
RBChangeSuperclassRefactoring >> preconditions [
	^ (RBCondition isMetaclass: class) not
		& (RBCondition isMetaclass: newSuperclass) not
		&
			(RBCondition
				withBlock: [ (newSuperclass withAllSuperclasses includes: class)
						ifTrue: [ ^ self
								refactoringError:
									'Assigning superclass ' , newSuperclass name , ' to ' , class name
										, ' would create a cycle in the hierarchy' ].
					true ])
]

{ #category : #transforming }
RBChangeSuperclassRefactoring >> transform [
	class superclass: newSuperclass.
	class classSide superclass: newSuperclass classSide.
	self model changes defineClass: class gtDefinitionString
]

Class {
	#name : #RBAddClassWithVarsRefactoring,
	#superclass : #RBAddClassRefactoring,
	#instVars : [
		'instanceVariableNames',
		'classVariableNames',
		'class'
	],
	#category : #'GToolkit-Utility-Refactorings-Refactorings'
}

{ #category : #accessing }
RBAddClassWithVarsRefactoring >> classVariableNames [
	^ classVariableNames
]

{ #category : #accessing }
RBAddClassWithVarsRefactoring >> classVariableNames: anObject [
	classVariableNames := anObject
]

{ #category : #accessing }
RBAddClassWithVarsRefactoring >> classVariableNamesString [
	^ String space join: self classVariableNames
]

{ #category : #initialize }
RBAddClassWithVarsRefactoring >> initialize [
	super initialize.
	instanceVariableNames := OrderedCollection new.
	classVariableNames := OrderedCollection new
]

{ #category : #accessing }
RBAddClassWithVarsRefactoring >> instanceVariableNames [
	^ instanceVariableNames
]

{ #category : #accessing }
RBAddClassWithVarsRefactoring >> instanceVariableNames: anObject [
	instanceVariableNames := anObject
]

{ #category : #accessing }
RBAddClassWithVarsRefactoring >> instanceVariableNamesString [
	^ String space join: self instanceVariableNames
]

{ #category : #preconditions }
RBAddClassWithVarsRefactoring >> preconditions [
	| preconditions |
	preconditions := self instanceVariableNames inject: super preconditions into: [ :pre :each | 
		pre 
			& (RBCondition isValidInstanceVariableName: each for: superclass) 
			& (RBCondition definesInstanceVariable: each in: superclass ) not 
			& (RBCondition isGlobal: each in: self model) not ].
	^ self classVariableNames inject: preconditions into: [ :pre :each | 
		pre 
			"& (RBCondition isValidClassVarName: each for: class ) "
			& (RBCondition definesClassVariable: each in: superclass ) not 
			& (RBCondition isGlobal: each in: self model) not	 ]
]

{ #category : #transforming }
RBAddClassWithVarsRefactoring >> transform [
	(self model)
		defineClass: ('<1p> subclass: #<2s> instanceVariableNames: <3p> classVariableNames: <4p> poolDictionaries: '''' category: <5p>' 
					expandMacrosWithArguments: (
						Array 
							with: superclass
							with: className
							with: self instanceVariableNamesString
							with: self classVariableNamesString
							with: category asString));
		reparentClasses: subclasses to: (self model classNamed: className asSymbol)
]

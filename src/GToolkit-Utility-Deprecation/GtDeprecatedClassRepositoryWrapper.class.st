Class {
	#name : #GtDeprecatedClassRepositoryWrapper,
	#superclass : #Object,
	#instVars : [
		'baselineRepository',
		'deprecatedClasses'
	],
	#category : #'GToolkit-Utility-Deprecation'
}

{ #category : #accessing }
GtDeprecatedClassRepositoryWrapper >> addDeprecatedClasses: aCollection [
	self deprecatedClasses addAll: (aCollection 
		collect: [ :aClass|
			GtDeprecatedClassWrapper forClass: aClass ])
]

{ #category : #accessing }
GtDeprecatedClassRepositoryWrapper >> baselineRepository [
	^ baselineRepository
]

{ #category : #accessing }
GtDeprecatedClassRepositoryWrapper >> baselineRepository: anObject [
	baselineRepository := anObject
]

{ #category : #accessing }
GtDeprecatedClassRepositoryWrapper >> deprecatedClasses [
	^ deprecatedClasses
]

{ #category : #'gt - extensions' }
GtDeprecatedClassRepositoryWrapper >> gtViewDeprecatedClassesByPackageFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'By Package';
		priority: 20;
		object: [ self deprecatedClasses ];
		view: #gtViewClassesByPackageFor:
]

{ #category : #'gt - extensions' }
GtDeprecatedClassRepositoryWrapper >> gtViewDeprecatedClassesFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Deprecated Classes';
		priority: 10;
		object: [ self deprecatedClasses ];
		view: #gtItemsFor:
]

{ #category : #testing }
GtDeprecatedClassRepositoryWrapper >> hasDeprecatedClasses [
	^ self numberOfDeprecatedClasses > 0
]

{ #category : #initialization }
GtDeprecatedClassRepositoryWrapper >> initialize [
	super initialize.
	
	deprecatedClasses := GtDeprecatedClassWrappersGroup new
]

{ #category : #accessing }
GtDeprecatedClassRepositoryWrapper >> name [
	^ self baselineRepository repositoryName
]

{ #category : #accessing }
GtDeprecatedClassRepositoryWrapper >> numberOfDeprecatedClasses [
	^ self deprecatedClasses size
]

{ #category : #printing }
GtDeprecatedClassRepositoryWrapper >> printOn: aStream [ 
	| deprecationsCount |
	super printOn: aStream.
	
	deprecationsCount := self numberOfDeprecatedClasses.
	aStream parenthesize: [
		aStream 
			<< self name;
			<< ', ';
			print: deprecationsCount;
			<< ' ';
			<< ('deprecated class' asPluralBasedOn: deprecationsCount)]
]

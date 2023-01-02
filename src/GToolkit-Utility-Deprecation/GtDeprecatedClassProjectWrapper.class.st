Class {
	#name : #GtDeprecatedClassProjectWrapper,
	#superclass : #Object,
	#instVars : [
		'baselineProject',
		'repositoryWrappers'
	],
	#category : #'GToolkit-Utility-Deprecation'
}

{ #category : #'instance creation' }
GtDeprecatedClassProjectWrapper class >> forBaselineProject: aBaselineProject [
	^ self new
		initializeForBaselineProject: aBaselineProject
]

{ #category : #'instance creation' }
GtDeprecatedClassProjectWrapper class >> forGToolkit [
		
	^ self forBaselineProject: BaselineOfGToolkit fullBaselineProject
]

{ #category : #accessing }
GtDeprecatedClassProjectWrapper >> baselineProject [
	^ baselineProject
]

{ #category : #accessing }
GtDeprecatedClassProjectWrapper >> deprecatedClasses [
	^ GtDeprecatedClassWrappersGroup withAll: (self repositoryWrappers 
		flatCollect: [ :aRepository |
			aRepository deprecatedClasses])
]

{ #category : #accessing }
GtDeprecatedClassProjectWrapper >> deprecatedClassesWithNoReferences [
	^ self deprecatedClasses selectWithNoReferences
]

{ #category : #'gt - extensions' }
GtDeprecatedClassProjectWrapper >> gtViewDeprecatedClassesFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Deprecated Classes';
		priority: 20;
		object: [ self deprecatedClasses ];
		view: #gtItemsFor:
]

{ #category : #'gt - extensions' }
GtDeprecatedClassProjectWrapper >> gtViewRepositoriesFor: aView [ 
	<gtView>
	
	^ aView columnedList
		title: 'Repositories';
		priority: 10;
		items: [ self repositoryWrappers ];
		column: 'Repository' text: [ :aRepository | aRepository name ];
		column: 'Deprecated Classes' text: [ :aRepository | 
			aRepository numberOfDeprecatedClasses ];
		column: 'References' text: [ :aRepository | 
			aRepository deprecatedClasses numberOfReferences ]
]

{ #category : #initialization }
GtDeprecatedClassProjectWrapper >> initialize [
	super initialize.
	
	repositoryWrappers := OrderedCollection new.
]

{ #category : #initialization }
GtDeprecatedClassProjectWrapper >> initializeForBaselineProject: aBaselineProject [ 
	baselineProject := aBaselineProject.
	baselineProject  withAllRepositories 
		do: [ :aRepository |
			| repositoryWrapper deprecatedClasses|
			repositoryWrapper := GtDeprecatedClassRepositoryWrapper new
				baselineRepository:  aRepository.
			deprecatedClasses := aRepository containedPackages 
				flatCollect: [ :aBaselinePackage | 
					aBaselinePackage asRPackage definedClasses 
						select: [ :aClass | aClass isDeprecated ] ].
			repositoryWrapper addDeprecatedClasses: deprecatedClasses.
			repositoryWrapper hasDeprecatedClasses ifTrue: [
				self repositoryWrappers add: repositoryWrapper ] ]
]

{ #category : #accessing }
GtDeprecatedClassProjectWrapper >> name [
	^ self baselineProject name
]

{ #category : #accessing }
GtDeprecatedClassProjectWrapper >> numberOfDeprecatedClasses [
	^ self repositoryWrappers sumNumbers: [ :aRepository |
		aRepository numberOfDeprecatedClasses ]
]

{ #category : #printing }
GtDeprecatedClassProjectWrapper >> printOn: aStream [ 
	| deprecationsCount |
	super printOn: aStream.
	
	deprecationsCount := self numberOfDeprecatedClasses.
	aStream parenthesize: [
		aStream 
			<< self name;
			<< ', ';
			print: deprecationsCount;
			<< ' ';
			<< ('deprecated method' asPluralBasedOn: deprecationsCount)]
]

{ #category : #accessing }
GtDeprecatedClassProjectWrapper >> repositoryWrappers [
	^ repositoryWrappers
]

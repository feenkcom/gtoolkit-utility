"
{{gtClass:GtExtensionMethodsProjectWrapper}} is a wrapper for a project (baseline) that has a list of extension methods added by any package loaded directly or indirectly to other packages from the system. 

Extension methods are grouped by repository using {{gtClass:GtExtensionMethodsRepositoryWrapper}}.
"
Class {
	#name : #GtExtensionMethodsProjectWrapper,
	#superclass : #Object,
	#instVars : [
		'project',
		'repositoryWrappers'
	],
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> extensionMethods [ 
	^ self packageWrappers  flatCollect: [ :aPackage |
		aPackage extensionMethods ]
]

{ #category : #'accessing - grouping' }
GtExtensionMethodsProjectWrapper >> groupByMethodChangeType [
	| extensionMethodsGroup |
	extensionMethodsGroup := self extensionMethods 
		groupedBy: [ :each | each changeType ].
	
	^ extensionMethodsGroup collect: [ :aGroup |
		GtExtensionMethodsProjectBuilder new 
			buildProjectWrapperForMethodWrappers: aGroup 
			inProject: self project ]
]

{ #category : #'gt - extensions' }
GtExtensionMethodsProjectWrapper >> gtViewExtensionMethodsFor: aView [
	<gtView>
	 
	^ aView columnedList 
		title: 'Extension Methods';
		priority: 50;
		items: [ self extensionMethods ];
		column: 'Method' text: [ :aMethod | aMethod printString ];
		column: 'Package' text: [ :aMethod | aMethod package name ]
]

{ #category : #'gt - extensions' }
GtExtensionMethodsProjectWrapper >> gtViewGroupsByChangeTypeFor: aView [
	<gtView>
	 
	^ aView columnedList 
		title: 'Extension Methods (by change type)';
		priority: 55;
		items: [ 
			self groupByMethodChangeType associations ];
		column: 'Change type' text: [ :assoc | 
			assoc key capitalized "piecesCutWhereCamelCase asCommaString" ];
		column: 'Number of methods' text: [ :assoc | 
			assoc value numberOfExtensions ];
		send: [ :assoc |
			assoc value ]
]

{ #category : #'gt - extensions' }
GtExtensionMethodsProjectWrapper >> gtViewPackageWrappersFor: aView [
	<gtView>
	 
	^ aView columnedList 
		title: 'Packages';
		priority: 20;
		items: [ self packageWrappers 
			sorted: [ :aPackage | 
				aPackage numberOfExtensions ] descending ];
		column: 'Package' text: [ :aPackage | aPackage packageName ];
		column: 'Extensions' text: [ :aPackage | aPackage numberOfExtensions ]
]

{ #category : #'gt - extensions' }
GtExtensionMethodsProjectWrapper >> gtViewRepositoryWrappersFor: aView [
	<gtView>
	 
	^ aView columnedList 
		title: 'Repositories';
		priority: 10;
		items: [ 
			self repositoryWrappersWithExtensions
				sorted: [ :aRepository | 
					aRepository numberOfExtensions ] descending ];
		column: 'Repository' text: [ :aRepository | aRepository name ];
		column: 'Extensions' text: [ :aRepository | aRepository numberOfExtensions ]
]

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> name [
	^ self project name
]

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> numberOfExtensions [
	^ self repositoryWrappers 
		sumNumbers: [ :aPackageWrapper | 
			aPackageWrapper numberOfExtensions ]
]

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> numberOfPackages [
	^ self packageWrappers size
]

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> numberOfRepositoriesWithExtensions [
	^ self repositoryWrappers 
		count: [ :aRepository |
			aRepository hasExtensionMethods ]
]

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> packageWrappers [
	^ self repositoryWrappers flatCollect: [ :aRepository |
		aRepository packageWrappers ]
]

{ #category : #printing }
GtExtensionMethodsProjectWrapper >> printOn: aStream [ 
	| extensionsCount |
	super printOn: aStream.
	
	extensionsCount := self numberOfExtensions.
	aStream parenthesize: [
		aStream 
			<< self name;
			<< ', ';
			print: extensionsCount;
			<< ' ';
			<< ('extension method' asPluralBasedOn: extensionsCount)]
]

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> project [

	^ project
]

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> project: anObject [

	project := anObject
]

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> repositoryWrappers [

	^ repositoryWrappers ifNil: [ #() ]
]

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> repositoryWrappers: anObject [

	repositoryWrappers := anObject
]

{ #category : #accessing }
GtExtensionMethodsProjectWrapper >> repositoryWrappersWithExtensions [

	^ self repositoryWrappers 
		select: [ :aRepository |
			aRepository hasExtensionMethods ]
]

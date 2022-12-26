"
{{gtClass:GtExtensionMethodsRepositoryWrapper}} is a wrapper for a repository that has a list of extension methods added by  loaded packages in the repo to other classes from the system.
"
Class {
	#name : #GtExtensionMethodsRepositoryWrapper,
	#superclass : #Object,
	#instVars : [
		'icebergRepository',
		'packageWrappers'
	],
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

{ #category : #adding }
GtExtensionMethodsRepositoryWrapper >> addPackageWrapper: aPackageWrapper [
	self packageWrappers add: aPackageWrapper
]

{ #category : #accessing }
GtExtensionMethodsRepositoryWrapper >> extensionMethods [ 
	^ self packageWrappers  flatCollect: [ :aPackage |
		aPackage extensionMethods ]
]

{ #category : #'accessing - grouping' }
GtExtensionMethodsRepositoryWrapper >> groupedByClass [
	^ self extensionMethods groupedBy: [ :aMethod |
	 aMethod methodClass ]
]

{ #category : #'gt - extensions' }
GtExtensionMethodsRepositoryWrapper >> gtViewExtensionMethodsByClassFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'By Class';
		priority: 45;
		items: [ self groupedByClass associations 
			sorted: [ :assoc | assoc value size ] descending ];
		column: 'Class' text: [ :assoc | assoc key ];
		column: 'Number of Extension Methods' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
]

{ #category : #'gt - extensions' }
GtExtensionMethodsRepositoryWrapper >> gtViewExtensionMethodsFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Extension Methods';
		priority: 40;
		object: [ self extensionMethods ];
		view: #gtItemsFor:
]

{ #category : #'gt - extensions' }
GtExtensionMethodsRepositoryWrapper >> gtViewPackageWrappersFor: aView [
	<gtView>
	 
	^ aView columnedList 
		title: 'Packages';
		priority: 10;
		items: [ self packageWrappers 
			sorted: [ :aPackage | 
				aPackage numberOfExtensions ] descending ];
		column: 'Package' text: [ :aPackage | aPackage packageName ];
		column: 'Extensions' text: [ :aPackage | aPackage numberOfExtensions ]
]

{ #category : #testing }
GtExtensionMethodsRepositoryWrapper >> hasExtensionMethods [
	^ self packageWrappers anySatisfy: [ :aPackageWrapper |
		aPackageWrapper hasExtensionMethods ] 
]

{ #category : #accessing }
GtExtensionMethodsRepositoryWrapper >> icebergRepository [

	^ icebergRepository
]

{ #category : #accessing }
GtExtensionMethodsRepositoryWrapper >> icebergRepository: aRepository [

	icebergRepository := aRepository
]

{ #category : #intialization }
GtExtensionMethodsRepositoryWrapper >> initialize [
	super initialize.
	
	packageWrappers := OrderedCollection new.
]

{ #category : #accessing }
GtExtensionMethodsRepositoryWrapper >> name [
	^ self icebergRepository name
]

{ #category : #accessing }
GtExtensionMethodsRepositoryWrapper >> numberOfExtensions [
	^ self packageWrappers 
		sumNumbers: [ :aPackageWrapper | 
			aPackageWrapper numberOfExtensions ]
]

{ #category : #accessing }
GtExtensionMethodsRepositoryWrapper >> packageWrappers [
	^ packageWrappers
]

{ #category : #printing }
GtExtensionMethodsRepositoryWrapper >> printOn: aStream [ 
	| extensionsCount |
	super printOn: aStream.
	
	extensionsCount := self numberOfExtensions.
	aStream parenthesize: [
		aStream 
			<< self name;
			<< ', ';
			print: extensionsCount;
			<< ' ';
			<< ('extension methods' asPluralBasedOn: extensionsCount)]
]

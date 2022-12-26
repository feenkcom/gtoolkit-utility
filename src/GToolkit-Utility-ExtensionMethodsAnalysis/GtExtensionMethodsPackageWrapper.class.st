"
{{gtClass:GtExtensionMethodsPackageWrapper}} is a wrapper for a package that stores a list of extension methods added by that package to other classes from the system.
"
Class {
	#name : #GtExtensionMethodsPackageWrapper,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'extensionMethods'
	],
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

{ #category : #accessing }
GtExtensionMethodsPackageWrapper >> extensionMethods [

	^ extensionMethods
]

{ #category : #accessing }
GtExtensionMethodsPackageWrapper >> extensionMethods: anObject [

	extensionMethods := anObject
]

{ #category : #printing }
GtExtensionMethodsPackageWrapper >> extensionsDescription [
	^ String streamContents: [ :aStream | 
		aStream 
			print: self numberOfExtensions;
			space;
			<< ('extension method' asPluralBasedOn: self numberOfExtensions) ]
]

{ #category : #'accessing - grouping' }
GtExtensionMethodsPackageWrapper >> groupedByClass [
	^ self extensionMethods groupedBy: [ :aMethod |
	 aMethod methodClass ]
]

{ #category : #'gt - extensions' }
GtExtensionMethodsPackageWrapper >> gtViewExtensionMethodsByClassFor: aView [
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
GtExtensionMethodsPackageWrapper >> gtViewExtensionMethodsFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Extension Methods';
		object: [ extensionMethods ];
		view: #gtItemsFor:
]

{ #category : #testing }
GtExtensionMethodsPackageWrapper >> hasExtensionMethods [
	^ self numberOfExtensions > 0
]

{ #category : #accessing }
GtExtensionMethodsPackageWrapper >> numberOfExtensions [
	^ self extensionMethods size
]

{ #category : #accessing }
GtExtensionMethodsPackageWrapper >> packageName [

	^ packageName
]

{ #category : #accessing }
GtExtensionMethodsPackageWrapper >> packageName: anObject [

	packageName := anObject
]

{ #category : #printing }
GtExtensionMethodsPackageWrapper >> printOn: aStream [ 
	super printOn: aStream .
	
	aStream parenthesize: [
		aStream 
			<< self packageName;
			<< ', ';
			<< self extensionsDescription ]
]

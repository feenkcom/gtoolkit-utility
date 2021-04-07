"
! Class from a template generator

Usage example:
[[[
GtClassGenerator new
	className: 'NewClass';
	packageName: 'MyPackage';
	traits: { TGtAssert };
	templateClass: GtWithDomainModelClassTemplate;
	templateMap: { 
		#__MODEL_NAME__ -> 'snippetWithText'.
		#__MODEL_NAME_TEXT__ -> 'snippet with text'.
		#__MODEL_NAME_CAPITALIZED__ -> 'SnippetWithText' };
	generate
]]]
"
Class {
	#name : #GtClassGenerator,
	#superclass : #Object,
	#instVars : [
		'templateClass',
		'traits',
		'templateMap',
		'className',
		'packageName'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #accessing }
GtClassGenerator >> className [
	^ className
]

{ #category : #accessing }
GtClassGenerator >> className: anObject [
	className := anObject
]

{ #category : #generation }
GtClassGenerator >> generate [
	| generatedClass templateSlots |
	<return: #Class>
	
	templateSlots := self templateClass slots collect: [ :eachSlot |
		eachSlot copy name: (GtGeneratorUtilities formatString: eachSlot name mapping: templateMap) ].
	
	generatedClass := Object
		subclass: self className
		uses: self traits
		slots: templateSlots
		classVariables: ''
		package: self packageName.

	generatedClass comment: (GtGeneratorUtilities formatString: self templateClass comment mapping: templateMap).

	self templateClass localMethods do: [ :eachTemplateMethod |
		| methodSource methodProtocol |
		
		methodSource := GtGeneratorUtilities formatString: eachTemplateMethod sourceCode mapping: templateMap.
		methodProtocol := GtGeneratorUtilities formatString: eachTemplateMethod protocol mapping: templateMap.
		generatedClass compile: methodSource classified: methodProtocol ].
	
	^ generatedClass
]

{ #category : #initialization }
GtClassGenerator >> initialize [
	super initialize.
	
	traits := #()
]

{ #category : #accessing }
GtClassGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
GtClassGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
GtClassGenerator >> templateClass [
	^ templateClass
]

{ #category : #accessing }
GtClassGenerator >> templateClass: anObject [
	templateClass := anObject
]

{ #category : #accessing }
GtClassGenerator >> templateMap [
	^ templateMap
]

{ #category : #accessing }
GtClassGenerator >> templateMap: aCollectionOfAssociations [
	templateMap := aCollectionOfAssociations asOrderedDictionary
]

{ #category : #accessing }
GtClassGenerator >> traits [
	^ traits
]

{ #category : #accessing }
GtClassGenerator >> traits: anObject [
	traits := anObject
]

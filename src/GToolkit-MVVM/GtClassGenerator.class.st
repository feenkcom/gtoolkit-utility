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
		'environment',
		'templateClass',
		'traits',
		'templateMap',
		'className',
		'packageName',
		'tagName'
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

{ #category : #accessing }
GtClassGenerator >> environment [
	^ environment
]

{ #category : #accessing }
GtClassGenerator >> environment: anEnvironment [
	environment := anEnvironment
]

{ #category : #generation }
GtClassGenerator >> generate [
	| aTemplateMap aPackageName generatedClass templateSlots |
	<return: #Class>
	
	aTemplateMap := templateMap, { #__timestamp__ -> DateAndTime now printString printString }.
	
	templateSlots := self templateClass slots collect: [ :eachSlot |
		eachSlot copy name: (GtGeneratorUtilities formatString: eachSlot name mapping: aTemplateMap) ].
	
	aPackageName := self packageName, (self tagName
		ifEmpty: [ '' ]
		ifNotEmpty: [ :aTagName | '-', aTagName ]).
	
	generatedClass := Object
		subclass: self className
		uses: self traits
		slots: templateSlots
		classVariables: ''
		package: aPackageName.

	generatedClass comment: (GtGeneratorUtilities formatString: self templateClass comment mapping: aTemplateMap).

	self templateClass localMethods do: [ :eachTemplateMethod |
		| methodSource methodProtocol |
		
		methodSource := GtGeneratorUtilities formatString: eachTemplateMethod sourceCode mapping: aTemplateMap.
		methodProtocol := GtGeneratorUtilities formatString: eachTemplateMethod protocol mapping: aTemplateMap.
		generatedClass compile: methodSource classified: methodProtocol ].
	
	^ generatedClass
]

{ #category : #generation }
GtClassGenerator >> generateBehaviorDefinition [
	| aTemplateMap generatedClass aClassName |
	<return: #RGBehavior>
	
	aTemplateMap := templateMap, { #__timestamp__ -> DateAndTime now printString printString }.

	aClassName := self className asSymbol.

	generatedClass := GtBehaviorDefinition fromBehavior: self templateClass.
	generatedClass name: aClassName.	
	generatedClass instanceSideDefinition category package name: self packageName.
	generatedClass instanceSideDefinition category tag name: self tagName.
	
	self environment
		ifNotNil: [ :anEnvironment |
			generatedClass environment: anEnvironment.
			anEnvironment registerBehavior: generatedClass ].
	
	self traits do: [ :eachTrait | generatedClass instanceSideDefinition traits addTraitNamed: eachTrait name  ].
	
	generatedClass instanceSideDefinition slots removeAllSlots.
	self templateClass slots do: [ :eachSlot |
		| eachSlotName |
		eachSlotName := (GtGeneratorUtilities formatString: eachSlot name mapping: aTemplateMap) asSymbol.
		generatedClass instanceSideDefinition slots addSlotNamed: eachSlotName ].
	
	generatedClass withMethodsFromClass: self templateClass.
	generatedClass instanceSideDefinition methods do: [ :eachMethodDefinition |
		| methodSource methodProtocol |
		
		methodSource := GtGeneratorUtilities formatString: eachMethodDefinition sourceCode mapping: aTemplateMap.
		methodProtocol := GtGeneratorUtilities formatString: eachMethodDefinition protocol mapping: aTemplateMap.
		
		eachMethodDefinition protocol: methodProtocol.
		eachMethodDefinition sourceCode: methodSource ].
	
	self templateClass hasComment
		ifTrue: [
			| aComment |
			aComment := (GtGeneratorUtilities
				formatString: self templateClass comment
				mapping: aTemplateMap).	
		generatedClass comment content: aComment ].
	
	^ generatedClass
]

{ #category : #initialization }
GtClassGenerator >> initialize [
	super initialize.
	
	traits := #().
	tagName := ''
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
GtClassGenerator >> tagName [
	^ tagName
]

{ #category : #accessing }
GtClassGenerator >> tagName: anObject [
	tagName := anObject ifNil: [ '' ]
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

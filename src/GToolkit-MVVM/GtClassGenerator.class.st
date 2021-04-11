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
	| aTemplateMap generatedClass templateSlots |
	<return: #Class>
	
	aTemplateMap := templateMap, { #__timestamp__ -> DateAndTime now printString printString }.
	
	templateSlots := self templateClass slots collect: [ :eachSlot |
		eachSlot copy name: (GtGeneratorUtilities formatString: eachSlot name mapping: aTemplateMap) ].
	
	generatedClass := Object
		subclass: self className
		uses: self traits
		slots: templateSlots
		classVariables: ''
		package: self packageName.

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
	| aTemplateMap generatedClass aComment aClassName |
	<return: #RGBehavior>
	
	aTemplateMap := templateMap, { #__timestamp__ -> DateAndTime now printString printString }.

	aClassName := self className asSymbol.

	generatedClass := GtBehaviorDefinition fromBehavior: self templateClass.
	generatedClass name: aClassName.	
	generatedClass instanceSideDefinition category package name: self packageName.
	generatedClass instanceSideDefinition category tag name: ''.
	
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

	"aComment := RGComment parent: generatedClass.
	aComment content: (GtGeneratorUtilities formatString: self templateClass comment mapping: templateMap).	
	generatedClass comment: aComment."
	
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

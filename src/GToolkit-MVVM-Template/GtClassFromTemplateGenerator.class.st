Class {
	#name : #GtClassFromTemplateGenerator,
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
	#category : #'GToolkit-MVVM-Template-Generator'
}

{ #category : #accessing }
GtClassFromTemplateGenerator >> className [
	^ className
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> className: anObject [
	className := anObject
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> environment [
	^ environment
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> environment: anEnvironment [
	environment := anEnvironment
]

{ #category : #generation }
GtClassFromTemplateGenerator >> generate [
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
GtClassFromTemplateGenerator >> generateBehaviorDefinition [
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

	self templateClass methods
		select: [ :eachCompiledMethod | eachCompiledMethod hasPragmaNamed: #gtMethodTemplate ]
		thenDo: [ :eachCompiledMethod |
			| aTemplateCoder |
			aTemplateCoder := GtPharoTemplateMethodCoder new forMethod: eachCompiledMethod.
			aTemplateCoder mappings: aTemplateMap associations.

			generatedClass instanceSideDefinition methods
				addMethod: aTemplateCoder translate
				protocol: aTemplateCoder protocol ].

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
GtClassFromTemplateGenerator >> initialize [
	super initialize.
	
	traits := #().
	tagName := ''
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> tagName [
	^ tagName
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> tagName: anObject [
	tagName := anObject ifNil: [ '' ]
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> templateClass [
	^ templateClass
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> templateClass: anObject [
	templateClass := anObject
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> templateMap [
	^ templateMap
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> templateMap: aCollectionOfAssociations [
	templateMap := aCollectionOfAssociations asOrderedDictionary
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> traits [
	^ traits
]

{ #category : #accessing }
GtClassFromTemplateGenerator >> traits: anObject [
	traits := anObject
]

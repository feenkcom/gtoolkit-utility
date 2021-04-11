"
! Trait from a template generator

Usage example:
[[[
GtTraitGenerator new
	traitName: 'TNewTrait';
	packageName: 'MyPackage';
	templateTrait: TGtWithDomainModelTraitTemplate;
	templateMap: { 
		#__MODEL_NAME__ -> 'snippetWithText'.
		#__MODEL_NAME_TEXT__ -> 'snippet with text'.
		#__MODEL_NAME_CAPITALIZED__ -> 'SnippetWithText' };
	generate
]]]
"
Class {
	#name : #GtTraitGenerator,
	#superclass : #Object,
	#instVars : [
		'environment',
		'templateTrait',
		'templateMap',
		'traitName',
		'packageName'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #accessing }
GtTraitGenerator >> environment [
	^ environment
]

{ #category : #accessing }
GtTraitGenerator >> environment: anEnvironment [
	environment := anEnvironment
]

{ #category : #generation }
GtTraitGenerator >> generate [
	| aTemplateMap generatedTrait templateSlots |
	<return: #Trait>
	
	aTemplateMap := templateMap, { #__timestamp__ -> DateAndTime now printString printString }.
	
	templateSlots := self templateTrait slots collect: [ :eachSlot |
		eachSlot copy name: (GtGeneratorUtilities formatString: eachSlot name mapping: aTemplateMap) ].
	
	generatedTrait := Trait named: self traitName
		uses: {}
		slots: templateSlots
		package: self packageName.
		
	generatedTrait comment: (GtGeneratorUtilities formatString: self templateTrait comment mapping: aTemplateMap).

	self templateTrait localMethods do: [ :eachTemplateMethod |
		| methodSource methodProtocol |
		
		methodSource := GtGeneratorUtilities formatString: eachTemplateMethod sourceCode mapping: aTemplateMap.
		methodProtocol := GtGeneratorUtilities formatString: eachTemplateMethod protocol mapping: aTemplateMap.
		generatedTrait compile: methodSource classified: methodProtocol ].
	
	^ generatedTrait
]

{ #category : #generation }
GtTraitGenerator >> generateBehaviorDefinition [
	| aTemplateMap generatedTrait |
	<return: #Trait>
	
	aTemplateMap := templateMap, { #__timestamp__ -> DateAndTime now printString printString }.
	
	generatedTrait := GtBehaviorDefinition fromBehavior: self templateTrait.
	generatedTrait name: self traitName.
	generatedTrait category package name: self packageName.
	generatedTrait category tag name: ''.
	
	self environment
		ifNotNil: [ :anEnvironment |
			generatedTrait environment: anEnvironment.
			anEnvironment registerBehavior: generatedTrait ].

	generatedTrait slots removeAllSlots.
	self templateTrait slots do: [ :eachSlot |
		| eachSlotName |
		eachSlotName := (GtGeneratorUtilities formatString: eachSlot name mapping: aTemplateMap) asSymbol.
		generatedTrait slots addSlotNamed: eachSlotName ].

	"generatedTrait comment: (GtGeneratorUtilities formatString: self templateTrait comment mapping: templateMap)."

	generatedTrait withMethodsFromTrait: self templateTrait.
	generatedTrait methods do: [ :eachMethodDefinition |
		| methodSource methodProtocol |
		
		methodSource := GtGeneratorUtilities formatString: eachMethodDefinition sourceCode mapping: aTemplateMap.
		methodProtocol := GtGeneratorUtilities formatString: eachMethodDefinition protocol mapping: aTemplateMap.
		
		eachMethodDefinition protocol: methodProtocol.
		eachMethodDefinition sourceCode: methodSource ].
	
	^ generatedTrait
]

{ #category : #accessing }
GtTraitGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
GtTraitGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
GtTraitGenerator >> templateMap [
	^ templateMap
]

{ #category : #accessing }
GtTraitGenerator >> templateMap: aCollectionOfAssociations [
	templateMap := aCollectionOfAssociations asOrderedDictionary
]

{ #category : #accessing }
GtTraitGenerator >> templateTrait [
	^ templateTrait
]

{ #category : #accessing }
GtTraitGenerator >> templateTrait: anObject [
	templateTrait := anObject
]

{ #category : #accessing }
GtTraitGenerator >> traitName [
	<return: #Symbol>

	^ traitName
]

{ #category : #accessing }
GtTraitGenerator >> traitName: anObject [
	traitName := anObject
]

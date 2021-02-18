"
! Trait from a template generator

Usage example:
[[[
GtWithTraitGenerator new
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
	#name : #GtWithTraitGenerator,
	#superclass : #Object,
	#instVars : [
		'templateTrait',
		'templateMap',
		'traitName',
		'packageName'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #private }
GtWithTraitGenerator >> formatString: aString mapping: aDictionaryOfReplacements [
	| aFormattedString |
	
	aFormattedString := aString.
	aDictionaryOfReplacements associationsDo: [ :eachAssociation |
		aFormattedString := aFormattedString copyReplaceAll: eachAssociation key with: eachAssociation value ].
	^ aFormattedString
]

{ #category : #generation }
GtWithTraitGenerator >> generate [
	| generatedTrait templateSlots |
	<return: #Trait>
	
	templateSlots := self templateTrait slots collect: [ :eachSlot |
		eachSlot copy name: (self formatString: eachSlot name mapping: templateMap) ].
	
	generatedTrait := Trait named: self traitName
		uses: {}
		slots: templateSlots
		package: self packageName.

	self templateTrait localMethods do: [ :eachTemplateMethod |
		| methodSource methodProtocol |
		
		methodSource := self formatString: eachTemplateMethod sourceCode mapping: templateMap.
		methodProtocol := self formatString: eachTemplateMethod protocol mapping: templateMap.
		generatedTrait compile: methodSource classified: methodProtocol ].
	
	^ generatedTrait
]

{ #category : #accessing }
GtWithTraitGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
GtWithTraitGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
GtWithTraitGenerator >> templateMap [
	^ templateMap
]

{ #category : #accessing }
GtWithTraitGenerator >> templateMap: aCollectionOfAssociations [
	templateMap := aCollectionOfAssociations asOrderedDictionary
]

{ #category : #accessing }
GtWithTraitGenerator >> templateTrait [
	^ templateTrait
]

{ #category : #accessing }
GtWithTraitGenerator >> templateTrait: anObject [
	templateTrait := anObject
]

{ #category : #accessing }
GtWithTraitGenerator >> traitName [
	<return: #Symbol>

	^ traitName
]

{ #category : #accessing }
GtWithTraitGenerator >> traitName: anObject [
	traitName := anObject
]

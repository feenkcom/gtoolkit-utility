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
		'templateTrait',
		'templateMap',
		'traitName',
		'packageName'
	],
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #generation }
GtTraitGenerator >> generate [
	| generatedTrait templateSlots |
	<return: #Trait>
	
	templateSlots := self templateTrait slots collect: [ :eachSlot |
		eachSlot copy name: (GtGeneratorUtilities formatString: eachSlot name mapping: templateMap) ].
	
	generatedTrait := Trait named: self traitName
		uses: {}
		slots: templateSlots
		package: self packageName.
		
	generatedTrait comment: (GtGeneratorUtilities formatString: self templateTrait comment mapping: templateMap).

	self templateTrait localMethods do: [ :eachTemplateMethod |
		| methodSource methodProtocol |
		
		methodSource := GtGeneratorUtilities formatString: eachTemplateMethod sourceCode mapping: templateMap.
		methodProtocol := GtGeneratorUtilities formatString: eachTemplateMethod protocol mapping: templateMap.
		generatedTrait compile: methodSource classified: methodProtocol ].
	
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

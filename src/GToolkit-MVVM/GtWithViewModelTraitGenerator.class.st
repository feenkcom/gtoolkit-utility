"
! View Trait generator

Usage example:
[[[
GtWithViewModelTraitGenerator new
	modelName: 'testModel';
	projectPrefix: 'Pr';
	packageName: 'GToolkit-MVVM-Test';
	generate	
]]]
"
Class {
	#name : #GtWithViewModelTraitGenerator,
	#superclass : #Object,
	#instVars : [
		'modelName',
		'projectPrefix',
		'packageName'
	],
	#category : #'GToolkit-MVVM-Generators'
}

{ #category : #private }
GtWithViewModelTraitGenerator >> formatString: aString mapping: aDictionaryOfReplacements [
	| aFormattedString |
	
	aFormattedString := aString.
	aDictionaryOfReplacements associationsDo: [ :eachAssociation |
		aFormattedString := aFormattedString copyReplaceAll: eachAssociation key with: eachAssociation value ].
	^ aFormattedString
]

{ #category : #generation }
GtWithViewModelTraitGenerator >> generate [
	| templateMap generatedTrait templateSlots |
	<return: #Trait>
	
	templateMap := {
		#__MODEL_NAME__ -> self modelName.
		#__MODEL_NAME_CAPITALIZED__-> self modelName capitalized.
		#__MODEL_NAME_TEXT__ -> (String streamContents: [ :aStream | 
			self modelName gtPiecesCutWhereCamelCase 
				do: [ :eachPiece | aStream nextPutAll: eachPiece asLowercase ]
				separatedBy: [ aStream nextPut: Character space ] ]) } asOrderedDictionary.
	
	templateSlots := TGtWithViewModelTraitTemplate slots collect: [ :eachSlot |
		eachSlot copy name: (self formatString: eachSlot name mapping: templateMap) ].
	
	generatedTrait := Trait named: self traitName
		uses: {}
		slots: templateSlots
		package: self packageName.

	TGtWithViewModelTraitTemplate localMethods do: [ :eachTemplateMethod |
		| methodSource methodProtocol |
		
		methodSource := self formatString: eachTemplateMethod sourceCode mapping: templateMap.
		methodProtocol := self formatString: eachTemplateMethod protocol mapping: templateMap.
		generatedTrait compile: methodSource classified: methodProtocol ].
	
	^ generatedTrait
]

{ #category : #private }
GtWithViewModelTraitGenerator >> methodProtocolPattern [
	^ 'api - {1} view model'
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> modelName [
	^ modelName
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> modelName: anObject [
	modelName := anObject
]

{ #category : #private }
GtWithViewModelTraitGenerator >> modelNameSuffix [
	^ 'ViewModel'
]

{ #category : #private }
GtWithViewModelTraitGenerator >> modelNameSuffixInText [
	^ String streamContents: [ :aStream | 
			self modelNameSuffix gtPiecesCutWhereCamelCase
				do: [ :eachPiece | aStream nextPutAll: eachPiece asLowercase ]
				separatedBy: [ aStream nextPut: Character space ] ]
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> projectPrefix [
	^ projectPrefix
]

{ #category : #accessing }
GtWithViewModelTraitGenerator >> projectPrefix: anObject [
	projectPrefix := anObject
]

{ #category : #private }
GtWithViewModelTraitGenerator >> traitName [
	<return: #Symbol>

	^ Symbol streamContents: [ :aStream |
		aStream
			nextPut: $T;
			nextPutAll: self projectPrefix;
			nextPutAll: 'With';
			nextPutAll: self modelName capitalized;
			nextPutAll: 'ViewModel' ]
]

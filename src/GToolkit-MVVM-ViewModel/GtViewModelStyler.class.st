Class {
	#name : #GtViewModelStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TGtViewModelProgramNodeVisitor',
	#classTraits : 'TGtViewModelProgramNodeVisitor classTrait',
	#category : #'GToolkit-MVVM-ViewModel-Coder'
}

{ #category : #'api - styling' }
GtViewModelStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		ensure: [ text := nil ]
]

{ #category : #generated }
GtViewModelStyler >> visitGlobalPropertyValue: aGlobalPropertyValue [
	self visitPropertyValue: aGlobalPropertyValue.
	
	self
		attribute: (BlTextForegroundAttribute color: Color blue muchDarker)
		from: aGlobalPropertyValue startPosition
		to: aGlobalPropertyValue stopPosition
]

{ #category : #generated }
GtViewModelStyler >> visitItemsProperty: anItemsProperty [
	self visitProperty: anItemsProperty.
	
	self
		attribute: (BlTextForegroundAttribute color: Color cyan muchDarker)
		from: anItemsProperty name startPosition
		to: anItemsProperty name stopPosition
]

{ #category : #generated }
GtViewModelStyler >> visitLevelForMany: aLevelForMany [
	self visitSimpleLevel: aLevelForMany.
	
	self
		attributes: {
			BlFontEmphasisAttribute italic.
			BlTextForegroundAttribute color: Color blue muchDarker
		}
		from: aLevelForMany suffix startPosition
		to: aLevelForMany suffix stopPosition
]

{ #category : #generated }
GtViewModelStyler >> visitModelAnnotation: aModelAnnotation [
	| aColor |
	
	self visitProgram: aModelAnnotation.
	
	aColor := self class environment
		at: aModelAnnotation nameString asSymbol
		ifPresent: [ :aGlobal |
			aGlobal isBehavior
				ifTrue: [ Color green muchDarker ]
				ifFalse: [ Color red ] ]
		ifAbsent: [ Color red ].
	
	self
		attribute: (BlTextForegroundAttribute color: aColor)
		from: aModelAnnotation name startPosition
		to: aModelAnnotation name stopPosition.
	
	aModelAnnotation apiNameString
		ifNil: [ ^ self ].
	
	aColor := self class environment
		at: aModelAnnotation apiNameString asSymbol
		ifPresent: [ :aGlobal |
			aGlobal isBehavior
				ifTrue: [ Color green muchDarker ]
				ifFalse: [ Color red ] ]
		ifAbsent: [ Color red ].
	
	self
		attribute: (BlTextForegroundAttribute color: aColor)
		from: aModelAnnotation api startPosition
		to: aModelAnnotation api stopPosition.
		
	
]

{ #category : #generated }
GtViewModelStyler >> visitNestedLevel: aNestedLevel [
	self visitLevel: aNestedLevel.
	
	self
		attribute: (BlTextForegroundAttribute color: Color gray)
		from: aNestedLevel follows startPosition
		to: aNestedLevel follows stopPosition
]

{ #category : #generated }
GtViewModelStyler >> visitSetting: aSetting [
	self visitProgram: aSetting.
	
	self
		attribute: (BlTextForegroundAttribute color: Color gray)
		from: aSetting startPosition
		to: aSetting stopPosition
]

{ #category : #generated }
GtViewModelStyler >> visitSimpleLevel: aSimpleLevel [
	self visitLevel: aSimpleLevel.
	
	self
		attributes: {
			BlFontWeightAttribute medium.
			BlTextForegroundAttribute color: Color blue muchDarker
		}
		from: aSimpleLevel name startPosition
		to: aSimpleLevel name stopPosition
]

{ #category : #generated }
GtViewModelStyler >> visitSymbolPropertyValue: aSymbolPropertyValue [
	self visitPropertyValue: aSymbolPropertyValue.
	
	self
		attributes: {
			BlTextForegroundAttribute color: Color magenta muchDarker
		}
		from: aSymbolPropertyValue startPosition
		to: aSymbolPropertyValue stopPosition
]

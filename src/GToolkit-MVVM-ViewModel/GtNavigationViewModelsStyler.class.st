Class {
	#name : #GtNavigationViewModelsStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TGtNavigationViewModelProgramNodeVisitor',
	#classTraits : 'TGtNavigationViewModelProgramNodeVisitor classTrait',
	#category : #'GToolkit-MVVM-ViewModel-Coder'
}

{ #category : #'api - styling' }
GtNavigationViewModelsStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		ensure: [ text := nil ]
]

{ #category : #generated }
GtNavigationViewModelsStyler >> visitGlobalPropertyValue: aGlobalPropertyValue [
	self visitPropertyValue: aGlobalPropertyValue.
	
	self
		attribute: (BlTextForegroundAttribute color: Color blue muchDarker)
		from: aGlobalPropertyValue startPosition
		to: aGlobalPropertyValue stopPosition
]

{ #category : #generated }
GtNavigationViewModelsStyler >> visitItemsProperty: anItemsProperty [
	self visitProperty: anItemsProperty.
	
	self
		attribute: (BlTextForegroundAttribute color: Color cyan muchDarker)
		from: anItemsProperty name startPosition
		to: anItemsProperty name stopPosition
]

{ #category : #generated }
GtNavigationViewModelsStyler >> visitLevelForMany: aLevelForMany [
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
GtNavigationViewModelsStyler >> visitModelAnnotation: aModelAnnotation [
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
GtNavigationViewModelsStyler >> visitNameProperty: aNameProperty [
	self visitProperty: aNameProperty.
	
	self
		attribute: (BlTextForegroundAttribute color: Color cyan muchDarker)
		from: aNameProperty name startPosition
		to: aNameProperty name stopPosition
]

{ #category : #generated }
GtNavigationViewModelsStyler >> visitNestedLevel: aNestedLevel [
	self visitLevel: aNestedLevel.
	
	self
		attribute: (BlTextForegroundAttribute color: Color gray)
		from: aNestedLevel follows startPosition
		to: aNestedLevel follows stopPosition
]

{ #category : #generated }
GtNavigationViewModelsStyler >> visitSetting: aSetting [
	self visitProgram: aSetting.
	
	self
		attribute: (BlTextForegroundAttribute color: Color gray)
		from: aSetting startPosition
		to: aSetting stopPosition
]

{ #category : #generated }
GtNavigationViewModelsStyler >> visitSimpleLevel: aSimpleLevel [
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
GtNavigationViewModelsStyler >> visitSymbolPropertyValue: aSymbolPropertyValue [
	self visitPropertyValue: aSymbolPropertyValue.
	
	self
		attributes: {
			BlTextForegroundAttribute color: Color magenta muchDarker
		}
		from: aSymbolPropertyValue startPosition
		to: aSymbolPropertyValue stopPosition
]
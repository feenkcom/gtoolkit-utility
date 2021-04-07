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
		attributes: {
			BlTextForegroundAttribute color: aColor
		}
		from: aModelAnnotation startPosition
		to: aModelAnnotation stopPosition
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

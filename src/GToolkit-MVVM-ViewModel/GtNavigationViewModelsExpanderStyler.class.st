Class {
	#name : #GtNavigationViewModelsExpanderStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TGtNavigationViewModelProgramNodeVisitor',
	#classTraits : 'TGtNavigationViewModelProgramNodeVisitor classTrait',
	#category : #'GToolkit-MVVM-ViewModel-Coder'
}

{ #category : #'api - styling' }
GtNavigationViewModelsExpanderStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		ensure: [ text := nil ]
]

{ #category : #generated }
GtNavigationViewModelsExpanderStyler >> visitSymbolPropertyValue: aSymbolPropertyValue [
	| aDefinitionNode aModelName aBehavior aSelector |
	self visitPropertyValue: aSymbolPropertyValue.
	
	aDefinitionNode := (aSymbolPropertyValue parentOfType: GtNavigationViewModelDefinitionNode)
		ifNil: [ ^ self ].
		
	aModelName := aDefinitionNode model
		ifNil: [ ^ self ]
		ifNotNil: [ :aModelNode | aModelNode nameString asSymbol ].
		
	aBehavior := self class environment
		at: aModelName
		ifAbsent: [ ^ self ].
	
	aBehavior isBehavior
		ifFalse: [ ^ self ].
	
	aSelector := aSymbolPropertyValue asSymbol.
	
	(aBehavior canUnderstand: aSelector)
		ifFalse: [ ^ self ].

	self
		attribute: (GtPharoMethodExpanderAttribute
			forClass: aBehavior
			andSelector: aSelector)
		from: aSymbolPropertyValue stopPosition
		to: aSymbolPropertyValue stopPosition
]

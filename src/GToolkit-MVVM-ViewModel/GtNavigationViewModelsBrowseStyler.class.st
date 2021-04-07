Class {
	#name : #GtNavigationViewModelsBrowseStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TGtNavigationViewModelProgramNodeVisitor',
	#classTraits : 'TGtNavigationViewModelProgramNodeVisitor classTrait',
	#category : #'GToolkit-MVVM-ViewModel-Coder'
}

{ #category : #'api - styling' }
GtNavigationViewModelsBrowseStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		ensure: [ text := nil ]
]

{ #category : #generated }
GtNavigationViewModelsBrowseStyler >> visitModelAnnotation: aModelAnnotation [
	| aGlobal |
	self visitProgram: aModelAnnotation.
	
	aGlobal := self class environment
		at: aModelAnnotation nameString asSymbol
		ifAbsent: [ ^ self ].
	
	aGlobal isBehavior
		ifFalse: [ ^ self ].
	
	self
		attributes: {
			GtButtonAttribute new
				beAppend;
				stencil: ([ BrButton new
					beTinySize;
					aptitude: ((BrGlamorousButtonRectangularAptitude paddingScale: 0.2) +
							BrGlamorousButtonIconAptitude +
							BrGlamorousButtonWithLabelTooltipAptitude +
							BrGlamorousButtonFlatExteriorAptitude);
					label: 'Browse ', aGlobal asString;
					icon: BrGlamorousVectorIcons browse;
					action: [ :aButton | aButton phlow spawnTool: (GtClassCoderTool forClass: aGlobal) ] ] asStencil)
		}
		from: aModelAnnotation name stopPosition
		to: aModelAnnotation name stopPosition
]

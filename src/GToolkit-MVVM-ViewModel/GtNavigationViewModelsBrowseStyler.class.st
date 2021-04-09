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

{ #category : #private }
GtNavigationViewModelsBrowseStyler >> styleGlobalNamed: aSymbol token: aSmaCCToken [
	| aGlobal |

	aGlobal := self class environment
		at: aSymbol
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
		from: aSmaCCToken stopPosition
		to: aSmaCCToken stopPosition
]

{ #category : #generated }
GtNavigationViewModelsBrowseStyler >> visitGlobalPropertyValue: aGlobalPropertyValue [
	self visitPropertyValue: aGlobalPropertyValue.
	
	self
		styleGlobalNamed: aGlobalPropertyValue value source asSymbol
		token: aGlobalPropertyValue value
]

{ #category : #generated }
GtNavigationViewModelsBrowseStyler >> visitModelAnnotation: aModelAnnotation [
	self visitProgram: aModelAnnotation.
	
	self
		styleGlobalNamed: aModelAnnotation nameString asSymbol
		token: aModelAnnotation name.
		
	aModelAnnotation api
		ifNil: [ ^ self ].
		
	self
		styleGlobalNamed: aModelAnnotation apiNameString asSymbol
		token: aModelAnnotation api
]

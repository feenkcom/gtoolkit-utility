Class {
	#name : #GtViewModelBrowseStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TGtViewModelProgramNodeVisitor',
	#classTraits : 'TGtViewModelProgramNodeVisitor classTrait',
	#category : #'GToolkit-MVVM-ViewModel-Coder'
}

{ #category : #'api - styling' }
GtViewModelBrowseStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		ensure: [ text := nil ]
]

{ #category : #private }
GtViewModelBrowseStyler >> styleGlobalNamed: aSymbol token: aSmaCCToken [
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
GtViewModelBrowseStyler >> visitGlobalPropertyValue: aGlobalPropertyValue [
	self visitPropertyValue: aGlobalPropertyValue.
	
	self
		styleGlobalNamed: aGlobalPropertyValue value source asSymbol
		token: aGlobalPropertyValue value
]

{ #category : #generated }
GtViewModelBrowseStyler >> visitModelAnnotation: aModelAnnotation [
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

Class {
	#name : #GtSearchTemplateMethodsInInstanceAndClassSideFilter,
	#superclass : #GtSearchMethodsContainedInClassFilter,
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #testing }
GtSearchTemplateMethodsInInstanceAndClassSideFilter >> includesMethod: aCompiledMethod [
	| methodClass |
	
	(aCompiledMethod pragmaAt: #gtMethodTemplate)
		ifNil: [ ^ false ].
	
	methodClass := aCompiledMethod methodClass.
	^ (methodClass = class instanceSide) or: [ 
		methodClass = class classSide ]
]

{ #category : #enumerating }
GtSearchTemplateMethodsInInstanceAndClassSideFilter >> methodsDo: aBlock [
	class instanceSide methods do: aBlock.

	"#methods includes ones from TraitedClass"
	class classSide visibleMethods do: aBlock
]

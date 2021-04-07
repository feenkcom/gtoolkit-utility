Class {
	#name : #GtViewModelGenerator,
	#superclass : #Object,
	#traits : 'TGtModelClassGenerator',
	#classTraits : 'TGtModelClassGenerator classTrait',
	#instVars : [
		'viewModelName'
	],
	#category : #'GToolkit-MVVM-Generators'
}

{ #category : #accessing }
GtViewModelGenerator >> className [
	<return: #Symbol>
	
	^ Symbol streamContents: [ :aStream |
		aStream
			nextPutAll: self projectPrefix;
			nextPutAll: (self viewModelName ifNil: [ self modelName ]) capitalized;
			nextPutAll: 'ViewModel' ]
]

{ #category : #initialization }
GtViewModelGenerator >> initialize [
	super initialize.
	
	properties := #()
]

{ #category : #accessing }
GtViewModelGenerator >> templateClass [
	^ GtViewModelClassTemplate
]

{ #category : #accessing }
GtViewModelGenerator >> traits [
	| aWithModelTraitName thePropertyTraitNames |

	aWithModelTraitName := GtWithDomainModelTraitGenerator new
		modelName: self modelName;
		projectPrefix: self projectPrefix;
		packageName: self packageName;
		traitName.
		
	thePropertyTraitNames := self properties collect: [ :eachPropertyNameOrTrait |
		eachPropertyNameOrTrait isTrait
			ifTrue: [ eachPropertyNameOrTrait name ]
			ifFalse: [
				GtWithPropertyTraitGenerator new
					propertyName: eachPropertyNameOrTrait;
					projectPrefix: self projectPrefix;
					packageName: self packageName;
					traitName ] ].

	^ ({ aWithModelTraitName }, thePropertyTraitNames)
		collect: [ :eachTraitName |
			self class environment
				at: eachTraitName asSymbol
				ifAbsent: [ nil ] ]
		thenSelect: [ :eachTrait | eachTrait notNil ]
]

{ #category : #accessing }
GtViewModelGenerator >> viewModelName [
	^ viewModelName
]

{ #category : #accessing }
GtViewModelGenerator >> viewModelName: anObject [
	viewModelName := anObject
]

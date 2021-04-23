Class {
	#name : #GtRobocoderMetamodelModelDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'name',
		'api',
		'type'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelModelDerive class >> label [
	^ 'model'
]

{ #category : #'accessing - methods' }
GtRobocoderMetamodelModelDerive class >> modelGetterMethodIn: aGtRobocoderMetamodelWithCodeDefinition [
	^ aGtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: self modelGetterPragma
]

{ #category : #accessing }
GtRobocoderMetamodelModelDerive class >> modelGetterPragma [
	^ (self pragmaName, #Getter:) asSymbol
]

{ #category : #'accessing - selectors' }
GtRobocoderMetamodelModelDerive class >> modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition [
	<return: #Symbol or: nil>

	^ (self modelGetterMethodIn: aGtRobocoderMetamodelWithCodeDefinition)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'accessing - methods' }
GtRobocoderMetamodelModelDerive class >> modelSetterMethodIn: aGtRobocoderMetamodelWithCodeDefinition [
	^ aGtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: self modelSetterPragma
]

{ #category : #accessing }
GtRobocoderMetamodelModelDerive class >> modelSetterPragma [
	^ (self pragmaName, #Setter:) asSymbol
]

{ #category : #'accessing - selectors' }
GtRobocoderMetamodelModelDerive class >> modelSetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition [
	<return: #Symbol or: nil>

	^ (self modelSetterMethodIn: aGtRobocoderMetamodelWithCodeDefinition)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelModelDerive class >> pragmaName [
	^ 'model'
]

{ #category : #accessing }
GtRobocoderMetamodelModelDerive >> api [
	^ api
]

{ #category : #accessing }
GtRobocoderMetamodelModelDerive >> api: anObject [
	name
		ifNotNil: [ self error: 'Either name or api trait must be used' ].

	api := anObject
]

{ #category : #private }
GtRobocoderMetamodelModelDerive >> apiTrait [
	self api
		ifNil: [ ^ nil ].

	^ self class environment
		at: self api asSymbol
		ifPresent: [ :aGlobal |
			aGlobal isTrait
				ifTrue: [ aGlobal ]
				ifFalse: [ nil ] ]
		ifAbsent: [ nil ]
]

{ #category : #'api - generation' }
GtRobocoderMetamodelModelDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		api ifNotNil: [
			| anApiTrait aDomainModelTraitDefinition |
			
			anApiTrait := self apiTrait.
			anApiTrait ifNil: [ self error: 'Api is defined but trait does not exist' ].
			aDomainModelTraitDefinition := GtTraitDefinition fromTrait: anApiTrait in: eachMetamodelWithCodeDefinition environment.
			aDomainModelTraitDefinition withMethodsFromTrait: anApiTrait.
			
			(eachMetamodelWithCodeDefinition definition instanceSideDefinition traits hasTraitNamed: aDomainModelTraitDefinition name)
				ifFalse: [ eachMetamodelWithCodeDefinition definition instanceSideDefinition traits addTrait: aDomainModelTraitDefinition ]
		] ifNil: [
			| aModelName aDomainModelTraitDefinition aMetamodel |
			
			aMetamodel := eachMetamodelWithCodeDefinition metamodel.
			
			aModelName := name ifNil: [ self fallbackModelNameFor: aMetamodel ].
			
			aDomainModelTraitDefinition := GtRobocoderWithObjectTraitGenerator new
				objectName: aModelName;
				pragmaName: self class pragmaName;
				projectPrefix: aMetamodel prefix, aMetamodel project capitalized;
				packageName: aMetamodel package;
				tagName: aMetamodel fullTagForTraits;
				generate.

			aMetamodel mergeBehaviorDefinition: aDomainModelTraitDefinition into: eachMetamodelWithCodeDefinition definition ] ]
]

{ #category : #private }
GtRobocoderMetamodelModelDerive >> fallbackModelNameFor: aRobocoderMetamodel [
	"If name is not specified explicitly, use this one instead"

	^ aRobocoderMetamodel name, 'Model'
]

{ #category : #accessing }
GtRobocoderMetamodelModelDerive >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodelModelDerive >> name: anObject [
	api
		ifNotNil: [ self error: 'Either name or api trait must be used' ].
	
	name := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelModelDerive >> type [
	^ type
]

{ #category : #accessing }
GtRobocoderMetamodelModelDerive >> type: aSymbol [
	type := aSymbol
]

Class {
	#name : #GtRobocoderMetamodelRemoveDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'delegate'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive class >> label [
	^ 'remove'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelRemoveDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				delegate
					ifNil: [ self generateRemovalForMany: eachMetamodelWithCodeDefinition ]
					ifNotNil: [ self generateRemovalDelegationForMany: eachMetamodelWithCodeDefinition ] ]
			ifFalse: [  ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive >> delegate [
	^ delegate
]

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive >> delegate: aSymbol [
	delegate := aSymbol
]

{ #category : #'private - generation' }
GtRobocoderMetamodelRemoveDerive >> generateRemovalDelegationForMany: aGtRobocoderMetamodelWithCodeDefinition [
	| eachNameMethodSourceCode modelGetter |
	
	modelGetter := (GtRobocoderMetamodelModelDerive modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].
	
	eachNameMethodSourceCode := GtRobocoderTemplateMethodCoder new
		forMethod: self class >> #removeDelegateTemplate;
		mappings: {
			#removeSelector -> delegate.
			#modelGetter -> modelGetter.
			#childName -> (aGtRobocoderMetamodelWithCodeDefinition project, aGtRobocoderMetamodelWithCodeDefinition forOneModel name capitalized) };
		translate.

	aGtRobocoderMetamodelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: eachNameMethodSourceCode
		protocol: 'api - removing'
]

{ #category : #'private - generation' }
GtRobocoderMetamodelRemoveDerive >> generateRemovalForMany: aGtRobocoderMetamodelWithCodeDefinition [
	| aMetamodel aDefinition childrenGetter childrenFinder |
	
	aMetamodel := aGtRobocoderMetamodelWithCodeDefinition metamodel.
	
	childrenGetter := (GtRobocoderMetamodelChildrenDerive
		childObjectGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
		childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel)
			ifNil: [ ^ self ].
			
	childrenFinder := (GtRobocoderMetamodelChildrenDerive
		childObjectFinderSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
		childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel)
			ifNil: [ ^ self ].
	
	aDefinition := GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelRemovalForManyTemplate;
		mappings: { 
			#childName -> aMetamodel forOneModel name.
			#objectName -> (aMetamodel generateSingularChildObjectGetterSelectorFor: aMetamodel forOneModel) uncapitalized.
			#objectFinder -> childrenFinder.
			#childrenGetter -> childrenGetter.
		};
		generate.

	aMetamodel
		mergeBehaviorDefinition: aDefinition
		into: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #initialization }
GtRobocoderMetamodelRemoveDerive >> initialize [
	super initialize.

	delegate := nil
]

{ #category : #templates }
GtRobocoderMetamodelRemoveDerive >> removeDelegateTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{removeSelector gtAsReader}}: a{{childName capitalized}}
	"Request the model to remove a given child object.
	I do nothing and simply delegate the removal. If the operation will trigger
	an announcement and I react to it, it will trigger an update"

	self {{modelGetter}} {{removeSelector gtAsReader}}: a{{childName capitalized}}';
		storageMethod: thisContext method
]

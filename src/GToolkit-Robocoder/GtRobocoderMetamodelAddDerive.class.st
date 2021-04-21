Class {
	#name : #GtRobocoderMetamodelAddDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'delegate'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelAddDerive class >> announcementNameFor: aGtRobocoderMetamodelWithCodeDefinition [
	^ '{prefix}{project}{name}{suffix}AddedAnnouncement'
		format: {
			#prefix -> aGtRobocoderMetamodelWithCodeDefinition prefix capitalized.
			#project -> aGtRobocoderMetamodelWithCodeDefinition project capitalized.
			#name -> (aGtRobocoderMetamodelWithCodeDefinition isForMany
				ifTrue: [ aGtRobocoderMetamodelWithCodeDefinition forOneModel name ]
				ifFalse: [ aGtRobocoderMetamodelWithCodeDefinition name ]) capitalized.
			#suffix -> aGtRobocoderMetamodelWithCodeDefinition suffix capitalized.
		} asDictionary
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive class >> label [
	^ 'add'
]

{ #category : #templates }
GtRobocoderMetamodelAddDerive >> addDelegateTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{addSelector gtAsReader}}: a{{childName capitalized}}
	"Request the model to add a given child object.
	I do nothing and simply delegate the addition. If the operation will trigger
	an announcement and I react to it, it will trigger an update"

	self {{modelGetter}} {{addSelector gtAsReader}}: a{{childName capitalized}}';
		storageMethod: thisContext method
]

{ #category : #'api - generation' }
GtRobocoderMetamodelAddDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				delegate
					ifNil: [ self generateAdditionForMany: eachMetamodelWithCodeDefinition ]
					ifNotNil: [ self generateAdditionDelegationForMany: eachMetamodelWithCodeDefinition ] ]
			ifFalse: [  ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive >> delegate [
	^ delegate
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive >> delegate: aSymbol [
	delegate := aSymbol
]

{ #category : #'private - generation' }
GtRobocoderMetamodelAddDerive >> generateAdditionDelegationForMany: aGtRobocoderMetamodelWithCodeDefinition [
	| eachNameMethodSourceCode modelGetter |
	
	modelGetter := (GtRobocoderMetamodelModelDerive modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].
	
	eachNameMethodSourceCode := GtRobocoderTemplateMethodCoder new
		forMethod: self class >> #addDelegateTemplate;
		mappings: {
			#addSelector -> delegate.
			#modelGetter -> modelGetter.
			#childName -> (aGtRobocoderMetamodelWithCodeDefinition project, aGtRobocoderMetamodelWithCodeDefinition forOneModel name capitalized) };
		translate.

	aGtRobocoderMetamodelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: eachNameMethodSourceCode
		protocol: 'api - adding'
]

{ #category : #'private - generation' }
GtRobocoderMetamodelAddDerive >> generateAdditionForMany: aGtRobocoderMetamodelWithCodeDefinition [
	| aMetamodel aDefinition childrenGetter childrenFinder |
	
	self generateAnnouncementForMany: aGtRobocoderMetamodelWithCodeDefinition.
	
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
		templateTrait: TGtRobocoderMetamodelAdditionForManyTemplate;
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

{ #category : #'private - generation' }
GtRobocoderMetamodelAddDerive >> generateAnnouncementForMany: aRobocoderMetamodelWithCodeDefinition [
	| aDefinition |

	aDefinition := GtRobocoderClassGenerator new
		templateClass: GtRobocoderMetamodelAnnouncementTemplate;
		mappings: { 
			#announcementName -> (self class announcementNameFor: aRobocoderMetamodelWithCodeDefinition).
			#superclass -> #Announcement.
			#package -> aRobocoderMetamodelWithCodeDefinition package.
			#tag -> aRobocoderMetamodelWithCodeDefinition metamodel fullTagForAnnouncements.
			#objectName -> (aRobocoderMetamodelWithCodeDefinition metamodel generateSingularChildObjectGetterSelectorFor: aRobocoderMetamodelWithCodeDefinition forOneModel) uncapitalized.
			#objectId -> aRobocoderMetamodelWithCodeDefinition forOneModel name.
		};
		generate.
		
	aRobocoderMetamodelWithCodeDefinition addExtraDefinition: aDefinition
]

{ #category : #initialization }
GtRobocoderMetamodelAddDerive >> initialize [
	super initialize.

	delegate := nil
]

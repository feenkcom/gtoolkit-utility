Class {
	#name : #GtRobocoderMetamodelAddDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'delegate',
		'subscription'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #'api - classes' }
GtRobocoderMetamodelAddDerive class >> announcementClassIn: aGtRobocoderMetamodelWithCodeDefinition [
	<return: #GtFullClassDefinition or: nil>

	^ aGtRobocoderMetamodelWithCodeDefinition extraDefinitionNamed: (self announcementNameFor: aGtRobocoderMetamodelWithCodeDefinition)
]

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

{ #category : #'api - generation' }
GtRobocoderMetamodelAddDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				
				"I announce addition only if we do not have a delegate or if subscription is specified"
				(delegate isNil or: [ subscription notNil ])
					ifTrue: [ self generateAnnouncementForMany: eachMetamodelWithCodeDefinition ].
				
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
	| modelGetter anAnnouncementDefinition aChildAnnouncementDefinition childObjectCreator childObjectGetter |

	modelGetter := (GtRobocoderMetamodelModelDerive modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	aGtRobocoderMetamodelWithCodeDefinition
		mergeTemplateTrait: TGtRobocoderMetamodelAdditionForManyWithDelegateTemplate
		mappings: { 
			#addSelector -> delegate.
			#modelGetter -> modelGetter.
			#childName -> (aGtRobocoderMetamodelWithCodeDefinition project, aGtRobocoderMetamodelWithCodeDefinition forOneModel name capitalized) }.
	
	subscription ifNil: [ ^ self ].

	anAnnouncementDefinition := (self class announcementClassIn: aGtRobocoderMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	childObjectCreator := (GtRobocoderMetamodelChildrenDerive
		childObjectCreatorSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
		childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel)
			ifNil: [ ^ self ].
			
	childObjectGetter := (GtRobocoderMetamodelChildrenDerive
		childObjectGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
		childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel)
			ifNil: [ ^ self ].

	aChildAnnouncementDefinition := GtBehaviorDefinition fromBehavior: (self class environment at: subscription asSymbol).
	aChildAnnouncementDefinition withMethodsFromClass: (self class environment at: subscription asSymbol).
	
	aGtRobocoderMetamodelWithCodeDefinition
		mergeTemplateTraits: TGtRobocoderMetamodelAdditionHookAndNotifyTemplate + TGtRobocoderMetamodelAdditionForManyWithSubscriptionTemplate
		mappings: {
			#childName -> aGtRobocoderMetamodelWithCodeDefinition forOneModel name.
			#objectName -> aGtRobocoderMetamodelWithCodeDefinition forOneModel fullName.
			#announce -> (aGtRobocoderMetamodelWithCodeDefinition anyMethodNamedSelectorOrNil: #announce:).
			#announcementClass -> (self class announcementNameFor: aGtRobocoderMetamodelWithCodeDefinition).
			#announcementSetter -> (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #objectSetter:
				inFullClass: anAnnouncementDefinition).
			#childObjectCreator -> childObjectCreator.
			#childObjectGetter -> childObjectGetter.
			#childAnnouncementClass -> aChildAnnouncementDefinition name.
			#childAnnouncementGetter -> (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #objectGetter:
				inFullClass: aChildAnnouncementDefinition) }.

	aGtRobocoderMetamodelWithCodeDefinition
		addSubscriptionWhen: aChildAnnouncementDefinition name
		in: modelGetter
		send: (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #modelEventHandler:
				andValue: aGtRobocoderMetamodelWithCodeDefinition forOneModel name
				inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition)
]

{ #category : #'private - generation' }
GtRobocoderMetamodelAddDerive >> generateAdditionForMany: aGtRobocoderMetamodelWithCodeDefinition [
	| childrenGetter childrenFinder anAnnouncementDefinition |

	anAnnouncementDefinition := (self class announcementClassIn: aGtRobocoderMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	childrenGetter := (GtRobocoderMetamodelChildrenDerive
		childObjectGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
		childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel)
			ifNil: [ ^ self ].

	childrenFinder := (GtRobocoderMetamodelChildrenDerive
		childObjectFinderSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
		childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel)
			ifNil: [ ^ self ].

	aGtRobocoderMetamodelWithCodeDefinition
		mergeTemplateTraits: TGtRobocoderMetamodelAdditionForManyTemplate + TGtRobocoderMetamodelAdditionHookAndNotifyTemplate
		mappings: { 
			#childName -> aGtRobocoderMetamodelWithCodeDefinition forOneModel name.
			#objectName -> aGtRobocoderMetamodelWithCodeDefinition forOneModel fullName.
			#objectFinder -> childrenFinder.
			#childrenGetter -> childrenGetter.
			#announce -> (aGtRobocoderMetamodelWithCodeDefinition anyMethodNamedSelectorOrNil: #announce:).
			#announcementClass -> (self class announcementNameFor: aGtRobocoderMetamodelWithCodeDefinition).
			#announcementSetter -> (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #objectSetter:
				inFullClass: anAnnouncementDefinition) }
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
		
	aRobocoderMetamodelWithCodeDefinition addExtraDefinition: aDefinition.
	
	^ aDefinition
]

{ #category : #initialization }
GtRobocoderMetamodelAddDerive >> initialize [
	super initialize.

	delegate := nil
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive >> subscribe: anAnnouncementName [
	subscription := anAnnouncementName
]

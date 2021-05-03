Class {
	#name : #GtRobocoderMetamodelWithPropertyDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #testing }
GtRobocoderMetamodelWithPropertyDerive class >> isAbstract [
	^ self = GtRobocoderMetamodelWithPropertyDerive
]

{ #category : #'private - generation' }
GtRobocoderMetamodelWithPropertyDerive >> generatePropertyChangedAnnouncementFor: aRobocoderMetamodelWithCodeDefinition [
	| aDefinition |
	
	aDefinition := GtRobocoderClassGenerator new
		templateClass: GtRobocoderMetamodelAnnouncementTemplate;
		mappings: { 
			#announcementName -> (self propertyChangedAnnouncementClassNameFor: aRobocoderMetamodelWithCodeDefinition).
			#superclass -> #Announcement.
			#package -> aRobocoderMetamodelWithCodeDefinition package.
			#tag -> aRobocoderMetamodelWithCodeDefinition metamodel fullTagForAnnouncements.
			#objectName -> (self propertyNameFor: aRobocoderMetamodelWithCodeDefinition) uncapitalized.
			#objectId -> aRobocoderMetamodelWithCodeDefinition forOneModel name.
		};
		generate.
	
	aRobocoderMetamodelWithCodeDefinition addExtraDefinition: aDefinition
]

{ #category : #'private - generation' }
GtRobocoderMetamodelWithPropertyDerive >> generatePropertyChangedNotifierMethodFor: aViewModelModelWithCodeDefinition [
	| aMethodDefinition methodSourceCode |

	aMethodDefinition := self
		propertyChangeNotifierMethodOf: aViewModelModelWithCodeDefinition.
			
	methodSourceCode := aMethodDefinition sourceCode, String cr, String cr, String tab, 
		'self announce: ', (self propertyChangedAnnouncementClassNameFor: aViewModelModelWithCodeDefinition metamodel),' new'.

	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: methodSourceCode
		protocol: aMethodDefinition protocol
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyChangeNotifierMethodOf: aViewModelModelWithCodeDefinition [
	^ self
		propertyMethodOfType: #propertyChangeNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - class names' }
GtRobocoderMetamodelWithPropertyDerive >> propertyChangedAnnouncementClassNameFor: aViewModelModel [
	<return: #Symbol>

	^ ('{prefix}{project}{propertyName}Changed'
		format: {
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#propertyName -> (self propertyNameFor: aViewModelModel) capitalized.
			#suffix -> aViewModelModel suffix capitalized.
		} asDictionary) capitalized asSymbol
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyGetterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertyGetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithPropertyDerive >> propertyGetterSelectorOf: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyGetterMethodOf: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyMethodOfType: aMethodType inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition [
	^ aViewModelModelWithCodeDefinition metamodel
		propertyMethodFor: (self propertyNameFor: aViewModelModelWithCodeDefinition metamodel)
		ofType: aMethodType
		inViewModelBehavior: aViewModelModelWithCodeDefinition definition
]

{ #category : #'private - accessing' }
GtRobocoderMetamodelWithPropertyDerive >> propertyNameFor: aViewModelModel [
	^ self subclassResponsibility
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertySetHookMethodOf: aViewModelModelWithCodeDefinition [
	^ self
		propertyMethodOfType: #propertySetHook:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertySetterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertySetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithPropertyDerive >> propertySetterSelectorOf: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertySetterMethodOf: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyTesterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertyTester:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithPropertyDerive >> propertyTesterSelectorOf: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyTesterMethodOf: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyUnsetHookMethodOf: aViewModelModelWithCodeDefinition [
	^ self
		propertyMethodOfType: #propertyUnsetHook:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyUnsetterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertyUnsetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithPropertyDerive >> propertyUnsetterSelectorOf: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyUnsetterMethodOf: aViewModelModelWithCodeDefinition) selector
]

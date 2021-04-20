Class {
	#name : #GtViewModelWithPropertyDirective,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #testing }
GtViewModelWithPropertyDirective class >> isAbstract [
	^ self = GtViewModelWithPropertyDirective
]

{ #category : #'private - generation' }
GtViewModelWithPropertyDirective >> generatePropertyChangedAnnouncementFor: aViewModelModel [
	| aDefinition |
	
	aDefinition := GtClassDefinition forNew.
	aDefinition name: (self propertyChangedAnnouncementClassNameFor: aViewModelModel).
	aDefinition superclass name: #Announcement.
	aDefinition category package name: aViewModelModel package.
	aDefinition category tag name: aViewModelModel fullTagForAnnouncements.
	
	^ aDefinition
]

{ #category : #'private - generation' }
GtViewModelWithPropertyDirective >> generatePropertyChangedNotifierMethodFor: aViewModelModelWithCodeDefinition [
	| aMethodDefinition methodSourceCode |

	aMethodDefinition := self
		propertyChangeNotifierMethodOf: aViewModelModelWithCodeDefinition.
			
	methodSourceCode := aMethodDefinition sourceCode, String cr, String cr, String tab, 
		'self announce: ', (self propertyChangedAnnouncementClassNameFor: aViewModelModelWithCodeDefinition viewModelModel),' new'.

	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: methodSourceCode
		protocol: aMethodDefinition protocol
]

{ #category : #'private - methods' }
GtViewModelWithPropertyDirective >> propertyChangeNotifierMethodOf: aViewModelModelWithCodeDefinition [
	^ self
		propertyMethodOfType: #propertyChangeNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - class names' }
GtViewModelWithPropertyDirective >> propertyChangedAnnouncementClassNameFor: aViewModelModel [
	<return: #Symbol>

	^ ('{project}{prefix}{suffix}{propertyName}Changed'
		format: {
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#propertyName -> (self propertyNameFor: aViewModelModel) capitalized.
			#suffix -> aViewModelModel suffix capitalized.
		} asDictionary) capitalized asSymbol
]

{ #category : #'private - methods' }
GtViewModelWithPropertyDirective >> propertyGetterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertyGetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - selectors' }
GtViewModelWithPropertyDirective >> propertyGetterSelectorOf: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyGetterMethodOf: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtViewModelWithPropertyDirective >> propertyMethodOfType: aMethodType inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition [
	^ aViewModelModelWithCodeDefinition viewModelModel
		propertyMethodFor: (self propertyNameFor: aViewModelModelWithCodeDefinition viewModelModel)
		ofType: aMethodType
		inViewModelBehavior: aViewModelModelWithCodeDefinition definition
]

{ #category : #'private - accessing' }
GtViewModelWithPropertyDirective >> propertyNameFor: aViewModelModel [
	^ self subclassResponsibility
]

{ #category : #'private - methods' }
GtViewModelWithPropertyDirective >> propertySetHookMethodOf: aViewModelModelWithCodeDefinition [
	^ self
		propertyMethodOfType: #propertySetHook:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - methods' }
GtViewModelWithPropertyDirective >> propertySetterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertySetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - selectors' }
GtViewModelWithPropertyDirective >> propertySetterSelectorOf: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertySetterMethodOf: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtViewModelWithPropertyDirective >> propertyTesterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertyTester:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - selectors' }
GtViewModelWithPropertyDirective >> propertyTesterSelectorOf: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyTesterMethodOf: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtViewModelWithPropertyDirective >> propertyUnsetHookMethodOf: aViewModelModelWithCodeDefinition [
	^ self
		propertyMethodOfType: #propertyUnsetHook:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - methods' }
GtViewModelWithPropertyDirective >> propertyUnsetterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertyUnsetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - accessors' }
GtViewModelWithPropertyDirective >> propertyUnsetterSelectorOf: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyUnsetterMethodOf: aViewModelModelWithCodeDefinition) selector
]

Class {
	#name : #GtRobocoderMetamodelWithSelectionDerive,
	#superclass : #GtRobocoderMetamodelWithChoicePropertyFromManyDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelWithSelectionDerive class >> label [
	^ 'selection'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelWithSelectionDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	"The generation of the selection behavior requires three passes:
	 - first we generate the template code which is independent for each view model
	 - once the basic code skeleton is generated we glue children to their parents during the second pass
	 - finally, we implement a few placeholder methods in parent to glue them with children"
	
	"first pass to generae independent code"
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				| aSelectionTraitDefinition aSelectedViewModelChangedAnnouncement |
	
				aSelectionTraitDefinition := self generateWithSelectedViewModelTraitFor: eachMetamodelWithCodeDefinition.
				eachMetamodelWithCodeDefinition definition instanceSideDefinition traits addTrait: aSelectionTraitDefinition.
				
				aSelectedViewModelChangedAnnouncement := self
					generatePropertyChangedAnnouncementFor: eachMetamodelWithCodeDefinition metamodel.
				
				eachMetamodelWithCodeDefinition addExtraDefinitions: {
					aSelectionTraitDefinition.
					aSelectedViewModelChangedAnnouncement
				} ].
		eachMetamodelWithCodeDefinition isForOne
			ifTrue: [
				eachMetamodelWithCodeDefinition addExtraDefinitions: { 
					self generateViewModelSelectedAnnouncementFor: eachMetamodelWithCodeDefinition metamodel.
					self generateViewModelDeselectedAnnouncementFor: eachMetamodelWithCodeDefinition metamodel.
				} ] ].

	"second pass to glue children with parents"
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		eachMetamodelWithCodeDefinition isForOne
			ifTrue: [
				self generateSelectableChildAccessorsFor: eachMetamodelWithCodeDefinition.
				self generateDeselectOtherEntitiesMethodFor: eachMetamodelWithCodeDefinition.
				self generateHasOtherSelectedEntitiesMethodFor: eachMetamodelWithCodeDefinition
			] ].
	
	"third pass to glue parents with children"
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				self generatePropertyChangedNotifierMethodFor: eachMetamodelWithCodeDefinition.
				self generateSelectionSetHookMethodTo: eachMetamodelWithCodeDefinition.
				self generateSelectionUnsetHookMethodTo: eachMetamodelWithCodeDefinition
			] ].
	

]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateDeselectOtherEntitiesMethodFor: aViewModelModelWithCodeDefinition [
	| aViewModelModel aMethodDefinition methodSourceCode theChildrenForMany |

	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can implement child specific selection methods' ].

	aViewModelModel := aViewModelModelWithCodeDefinition metamodel.
	
	theChildrenForMany := aViewModelModelWithCodeDefinition children select: #isForMany.
	
	theChildrenForMany
		ifEmpty: [ ^ self ].

	aMethodDefinition := self
		propertyUnsetOthersMethodOfOne: aViewModelModelWithCodeDefinition.
	
	aMethodDefinition
		ifNil: [ ^ self ].
	
	methodSourceCode := String streamContents: [ :aStream |
		aStream
			nextPutAll: aMethodDefinition sourceCode; cr.
		
		theChildrenForMany do: [ :eachChildViewModelModelWithCodeDefinition |
			aStream
				cr;
				tab;
					nextPutAll: 'self';
					space;
					nextPutAll: (aViewModelModel generateChildObjectGetterSelectorFor: eachChildViewModelModelWithCodeDefinition metamodel) uncapitalized;
					space;
					nextPutAll: (self propertyUnsetterSelectorOf: eachChildViewModelModelWithCodeDefinition);
					nextPut: $. ] ].

	aMethodDefinition sourceCode: methodSourceCode
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateHasOtherSelectedEntitiesMethodFor: aViewModelModelWithCodeDefinition [
	| aViewModelModel theChildrenForMany aMethodDefinition methodSourceCode |

	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can implement child specific selection methods' ].

	aViewModelModel := aViewModelModelWithCodeDefinition metamodel.
	
	theChildrenForMany := aViewModelModelWithCodeDefinition children select: #isForMany.
	theChildrenForMany
		ifEmpty: [ ^ self ].

	aMethodDefinition := self
		propertyMethodOfType: #propertyTestOthers:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition.

	aMethodDefinition
		ifNil: [ ^ self ].
		
	methodSourceCode := String streamContents: [ :aStream |		
		aStream
			nextPutAll: (aMethodDefinition sourceCode copyReplaceAll: '^ false' with: '').
		
		aStream nextPutAll: '^ '.
		theChildrenForMany doWithIndex: [ :eachChildViewModelModelWithCodeDefinition :eachIndex |
			eachIndex > 1
				ifTrue: [
					aStream
						space;
						nextPutAll: 'or: [';
						space ].
			
			aStream
				nextPutAll: 'self';
				space;
				nextPutAll: (aViewModelModel generateChildObjectGetterSelectorFor: eachChildViewModelModelWithCodeDefinition metamodel) uncapitalized;
				space;
				nextPutAll: (self propertyTesterSelectorOf: eachChildViewModelModelWithCodeDefinition) ].
		
		((theChildrenForMany size - 1) max: 0) timesRepeat: [ aStream space; nextPut: $] ] ].

	aMethodDefinition sourceCode: methodSourceCode
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateSelectableChildAccessorsDefinitionFor: aViewModelModelWithCodeDefinition [
	^ GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelParentAccessorTemplate;
		mappings: { 
			#__View_model_class__ -> aViewModelModelWithCodeDefinition metamodel objectClassName.
			#__Parent_view_model_class__ -> aViewModelModelWithCodeDefinition metamodel parent objectClassName.
			#protocol -> 'selection'.
			
			#statusAdjective -> 'selected'.
			#negativeStatusAdjective -> 'deselected'.
			#setVerb -> 'select'.
			#unsetVerb -> 'deselect'.
			#objectName -> aViewModelModelWithCodeDefinition name.
			#propertyName -> (self propertyNameFor: aViewModelModelWithCodeDefinition parent metamodel).
			#parentObjectGetter -> aViewModelModelWithCodeDefinition parentViewModelSelectorName.
			#parentPropertyGetter -> (self propertyGetterSelectorOf: aViewModelModelWithCodeDefinition parent).
			#parentPropertySetter -> (self propertySetterSelectorOf: aViewModelModelWithCodeDefinition parent).
			#parentPropertyTester -> (self propertyTesterSelectorOf: aViewModelModelWithCodeDefinition parent).
			
			#statusAnnouncementClass -> (self viewModelSelectedAnnouncementNameFor: aViewModelModelWithCodeDefinition metamodel).
			#negativeStatusAnnouncementClass -> (self viewModelDeselectedAnnouncementNameFor: aViewModelModelWithCodeDefinition metamodel).
		};
		generate
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateSelectableChildAccessorsFor: aViewModelModeWithCodeDefinition [
	| aViewModelModel aSelectableDefinition |

	aViewModelModel := aViewModelModeWithCodeDefinition metamodel.

	aViewModelModel hasParent
		ifFalse: [ ^ self ].

	aViewModelModel parent isForMany
		ifFalse: [ ^ self ].

	aSelectableDefinition := self generateSelectableChildAccessorsDefinitionFor: aViewModelModeWithCodeDefinition.

	aViewModelModeWithCodeDefinition metamodel
		mergeBehaviorDefinition: aSelectableDefinition instanceSideDefinition
		into: aViewModelModeWithCodeDefinition definition
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateSelectionSetHookMethodTo: aViewModelModelWithCodeDefinition [
	| aMethodDefinition methodSourceCode aArgumentName |

	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement parent specific selection methods' ].

	aMethodDefinition := self propertySetHookMethodOf: aViewModelModelWithCodeDefinition.

	aArgumentName := aMethodDefinition arguments first.

	methodSourceCode := String streamContents: [ :aStream |
		aStream
			nextPutAll: aMethodDefinition sourceCode; cr;
			cr.
		
		aViewModelModelWithCodeDefinition parents do: [ :eachParentViewModelModelWithDefinition |
			| aSetterMethod |

			aSetterMethod := self propertySetterMethodOf: eachParentViewModelModelWithDefinition.
			aSetterMethod ifNotNil: [
				aStream nextPutAll: (
'	self {parentTester}
		ifTrue: [ self {parentGetter} {propertySetter} ].'
			format: { 
				#parentTester -> (aViewModelModelWithCodeDefinition parentViewModelTesterMethodFor: eachParentViewModelModelWithDefinition) selector.
				#parentGetter -> (aViewModelModelWithCodeDefinition parentViewModelGetterMethodFor: eachParentViewModelModelWithDefinition) selector.
				#propertySetter -> aSetterMethod selector
			} asDictionary).
				aStream cr ] ].

		aStream
			tab; nextPutAll: aArgumentName; space; nextPutAll: (self propertySetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition forOneModel) ].

	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: methodSourceCode
		protocol: aMethodDefinition protocol
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateSelectionUnsetHookMethodTo: aViewModelModelWithCodeDefinition [
	| aMethodDefinition methodSourceCode aArgumentName |

	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement parent specific selection methods' ].

	aMethodDefinition := self propertyUnsetHookMethodOf: aViewModelModelWithCodeDefinition.

	aArgumentName := aMethodDefinition arguments first.

	methodSourceCode := String streamContents: [ :aStream |
		aStream
			nextPutAll: aMethodDefinition sourceCode; cr;
			cr;
			tab;
				nextPutAll: aArgumentName; space;
				nextPutAll: (self propertyUnsetOthersSelectorOfOne: aViewModelModelWithCodeDefinition forOneModel);
				nextPut: $.; cr;
			tab;
				nextPutAll: aArgumentName; space;
				nextPutAll: (self propertyUnsetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition forOneModel) ].

	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: methodSourceCode
		protocol: aMethodDefinition protocol
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateViewModelDeselectedAnnouncementFor: aViewModelModel [
	| aDefinition |
	
	self
		assert: [ aViewModelModel isForOne ]
		description: [ 'Only view model for one can announce deselected event' ].
	
	aDefinition := GtClassDefinition forNew.
	aDefinition name: (self viewModelDeselectedAnnouncementNameFor: aViewModelModel).
	aDefinition superclass name: #Announcement.
	aDefinition category package name: aViewModelModel package.
	aDefinition category tag name: aViewModelModel fullTagForAnnouncements.
	aDefinition slots addSlotNamed: aViewModelModel name, 'ViewModel'.
	aDefinition methods
		addMethod: ('{name}ViewModel
	^ {name}ViewModel' format: { #name -> aViewModelModel name } asDictionary)
		protocol: 'accessing'.
	aDefinition methods
		addMethod: ('{name}ViewModel: anObject
	{name}ViewModel := anObject' format: { #name -> aViewModelModel name } asDictionary)
		protocol: 'accessing'.

	^ aDefinition
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateViewModelSelectedAnnouncementFor: aViewModelModel [
	| aDefinition |
	
	self
		assert: [ aViewModelModel isForOne ]
		description: [ 'Only view model for one can announce selected event' ].
	
	aDefinition := GtClassDefinition forNew.
	aDefinition name: (self viewModelSelectedAnnouncementNameFor: aViewModelModel).
	aDefinition superclass name: #Announcement.
	aDefinition category package name: aViewModelModel package.
	aDefinition category tag name: aViewModelModel fullTagForAnnouncements.
	aDefinition slots addSlotNamed: aViewModelModel name, 'ViewModel'.
	aDefinition methods
		addMethod: ('{name}ViewModel
	^ {name}ViewModel' format: { #name -> aViewModelModel name } asDictionary)
		protocol: 'accessing'.
	aDefinition methods
		addMethod: ('{name}ViewModel: anObject
	{name}ViewModel := anObject' format: { #name -> aViewModelModel name } asDictionary)
		protocol: 'accessing'.

	^ aDefinition
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateWithSelectedViewModelTraitFor: aViewModelModelWithCodeDefinition [
	| aViewModelModel aCodeDefinition |

	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement selection trait' ].
	
	aViewModelModel := aViewModelModelWithCodeDefinition metamodel.
	aCodeDefinition := aViewModelModelWithCodeDefinition definition.	

	^ GtRobocoderWithPropertyTraitGenerator new
		environment: aCodeDefinition environment;
		propertyName: (self propertyNameFor: aViewModelModel);
		propertySetter: 'select', aViewModelModel forOneModel name capitalized ,'ViewModel';
		propertyUnsetter: 'deselect', aViewModelModel forOneModel name capitalized ,'ViewModel';
		propertyType: aViewModelModel forOneModel objectClassName;
		propertyComparator: #=;
		projectPrefix: (aViewModelModel project, aViewModelModel prefix capitalized);
		packageName: aViewModelModel package;
		tagName: aViewModelModel fullTagForTraits;
		generate
]

{ #category : #'api - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> propertyAppliedStatusName [
	^ 'selected'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> propertyNameFor: aViewModelModel [
	| aName |

	aName := aViewModelModel isForMany
		ifTrue: [ aViewModelModel forOneModel name ]
		ifFalse: [ aViewModelModel name ].

	^ 'selected', aName capitalized ,'ViewModel'
]

{ #category : #'api - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> propertyUnappliedStatusName [
	^ 'deselected'
]

{ #category : #'private - class names' }
GtRobocoderMetamodelWithSelectionDerive >> viewModelDeselectedAnnouncementNameFor: aViewModelModel [
	^ '{project}{prefix}{name}{suffix}ViewModelDeselected'
		format: { 
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#name -> aViewModelModel name capitalized.
			#suffix -> aViewModelModel suffix capitalized.
		} asDictionary
]

{ #category : #'private - class names' }
GtRobocoderMetamodelWithSelectionDerive >> viewModelSelectedAnnouncementNameFor: aViewModelModel [
	^ '{project}{prefix}{name}{suffix}ViewModelSelected'
		format: { 
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#name -> aViewModelModel name capitalized.
			#suffix -> aViewModelModel suffix capitalized.
		} asDictionary
]

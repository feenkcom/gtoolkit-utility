Class {
	#name : #GtViewModelWithSelectionDerive,
	#superclass : #GtViewModelDerive,
	#category : #'GToolkit-MVVM-ViewModel-Derives'
}

{ #category : #accessing }
GtViewModelWithSelectionDerive class >> label [
	^ 'selection'
]

{ #category : #'api - generation' }
GtViewModelWithSelectionDerive >> applyOnViewModelModelsWithCodeDefinitions: aGtViewModelModelsWithCodeDefinitions [
	"The generation of the selection behavior requires three passes:
	 - first we generate the template code which is independent for each view model
	 - once the basic code skeleton is generated we glue children to their parents during the second pass
	 - finally, we implement a few placeholder methods in parent to glue them with children"
	
	"first pass to generae independent code"
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |		
		eachViewModelModelWithCodeDefinition isForMany
			ifTrue: [
				| aSelectionTraitDefinition aSelectedViewModelChangedAnnouncement |
	
				aSelectionTraitDefinition := self generateWithSelectedViewModelTraitFor: eachViewModelModelWithCodeDefinition.
				eachViewModelModelWithCodeDefinition definition instanceSideDefinition traits addTrait: aSelectionTraitDefinition.
				
				aSelectedViewModelChangedAnnouncement := self
					generateSelectedViewModelChangedAnnouncementFor: eachViewModelModelWithCodeDefinition viewModelModel.
				
				eachViewModelModelWithCodeDefinition addExtraDefinitions: {
					aSelectionTraitDefinition.
					aSelectedViewModelChangedAnnouncement
				} ].
		eachViewModelModelWithCodeDefinition isForOne
			ifTrue: [
				eachViewModelModelWithCodeDefinition addExtraDefinitions: { 
					self generateViewModelSelectedAnnouncementFor: eachViewModelModelWithCodeDefinition viewModelModel.
					self generateViewModelDeselectedAnnouncementFor: eachViewModelModelWithCodeDefinition viewModelModel.
				} ] ].

	"second pass to glue children with parents"
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |		
		eachViewModelModelWithCodeDefinition isForOne
			ifTrue: [
				self generateSelectableChildAccessorsFor: eachViewModelModelWithCodeDefinition.
				self generateDeselectOtherEntitiesMethodFor: eachViewModelModelWithCodeDefinition.
				self generateHasOtherSelectedEntitiesMethodFor: eachViewModelModelWithCodeDefinition
			] ].
	
	"third pass to glue parents with children"
	aGtViewModelModelsWithCodeDefinitions viewModelModelsWithCodeDefinitionDo: [ :eachViewModelModelWithCodeDefinition |		
		eachViewModelModelWithCodeDefinition isForMany
			ifTrue: [
				self generateSelectedViewModelChangedNotifierMethodFor: eachViewModelModelWithCodeDefinition.
				self generateSelectionSetHookMethodTo: eachViewModelModelWithCodeDefinition.
				self generateSelectionUnsetHookMethodTo: eachViewModelModelWithCodeDefinition
			] ].
	

]

{ #category : #'private - accessors' }
GtViewModelWithSelectionDerive >> deselectedNotifierNameOf: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have child specific selection method' ].

	^ (self
		selectionPropertyMethodOfType: #propertyUnsetNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - generate' }
GtViewModelWithSelectionDerive >> generateDeselectOtherEntitiesMethodFor: aViewModelModelWithCodeDefinition [
	| aViewModelModel aMethodDefinition methodSourceCode |

	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can implement child specific selection methods' ].

	aViewModelModel := aViewModelModelWithCodeDefinition viewModelModel.
	
	aViewModelModel children
		ifEmpty: [ ^ self ].

	aMethodDefinition := self
		selectionPropertyUnsetOthersMethodOf: aViewModelModelWithCodeDefinition.
	
	aMethodDefinition
		ifNil: [ ^ self ].
	
	methodSourceCode := String streamContents: [ :aStream |
		aStream
			nextPutAll: aMethodDefinition sourceCode; cr.
		
		aViewModelModelWithCodeDefinition children do: [ :eachChildViewModelModelWithCodeDefinition |
			aStream
				cr;
				tab;
					nextPutAll: 'self';
					space;
					nextPutAll: (aViewModelModel childViewModelsNameFor: eachChildViewModelModelWithCodeDefinition viewModelModel) uncapitalized;
					space;
					nextPutAll: (self selectionPropertyUnsetterNameOf: eachChildViewModelModelWithCodeDefinition);
					nextPut: $. ] ].

	aMethodDefinition sourceCode: methodSourceCode
]

{ #category : #'private - generate' }
GtViewModelWithSelectionDerive >> generateHasOtherSelectedEntitiesMethodFor: aViewModelModelWithCodeDefinition [
	| aViewModelModel aMethodDefinition methodSourceCode |

	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can implement child specific selection methods' ].

	aViewModelModel := aViewModelModelWithCodeDefinition viewModelModel.
	
	aViewModelModel children
		ifEmpty: [ ^ self ].

	aMethodDefinition := self
		selectionPropertyMethodOfType: #propertyTestOthers:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition.

	aMethodDefinition
		ifNil: [ ^ self ].
		
	methodSourceCode := String streamContents: [ :aStream |
		| theChildrenViewModelModelsWithCodeDefinition |
		
		theChildrenViewModelModelsWithCodeDefinition := aViewModelModelWithCodeDefinition children.
		
		aStream
			nextPutAll: (aMethodDefinition sourceCode copyReplaceAll: '^ false' with: '').
		
		aStream nextPutAll: '^ '.
		theChildrenViewModelModelsWithCodeDefinition doWithIndex: [ :eachChildViewModelModelWithCodeDefinition :eachIndex |
			eachIndex > 1
				ifTrue: [
					aStream
						space;
						nextPutAll: 'or: [';
						space ].
			
			aStream
				nextPutAll: 'self';
				space;
				nextPutAll: (aViewModelModel childViewModelsNameFor: eachChildViewModelModelWithCodeDefinition viewModelModel) uncapitalized;
				space;
				nextPutAll: (self selectionPropertyTesterNameOf: eachChildViewModelModelWithCodeDefinition) ].
		
		((theChildrenViewModelModelsWithCodeDefinition size - 1) max: 0) timesRepeat: [ aStream space; nextPut: $] ] ].

	aMethodDefinition sourceCode: methodSourceCode
]

{ #category : #'private - generate' }
GtViewModelWithSelectionDerive >> generateSelectableChildAccessorsDefinitionFor: aViewModelModelWithCodeDefinition [
	^ GtClassGenerator new
		templateClass: TGtViewModelPropertyForChildTemplate;
		className: 'VirtualClass';
		packageName: 'VirualPackage';
		templateMap: { 
			#__property__ -> 'selection'.
			#__Status__ -> 'Selected'.
			#__status__ -> 'selected'.
			#__Status_not__ -> 'Deselected'.
			#__Set__ -> 'Select'.
			#__set__ -> 'select'.
			#__Unset__ -> 'deselect'.
			#__unset__ -> 'deselect'.
			#__object__ -> aViewModelModelWithCodeDefinition name.
			#__Object__ -> aViewModelModelWithCodeDefinition name capitalized.
			#__has_parent_property__ -> (self selectionPropertyTesterNameOf: aViewModelModelWithCodeDefinition parent).
			#__parent_object_getter__ -> aViewModelModelWithCodeDefinition parentViewModelSelectorName.
			#__parent_property_getter__ -> (self selectionPropertyGetterNameOf: aViewModelModelWithCodeDefinition parent).
			#__parent_property_setter__ -> (self selectionPropertySetterNameOf: aViewModelModelWithCodeDefinition parent).
			#__Status_announcement__ -> (self viewModelSelectedAnnouncementNameFor: aViewModelModelWithCodeDefinition viewModelModel).
			#__Status_not_announcement__ -> (self viewModelDeselectedAnnouncementNameFor: aViewModelModelWithCodeDefinition viewModelModel).
			#__property_name__ -> (self selectionPropertyNameFor: aViewModelModelWithCodeDefinition parent viewModelModel)
		};
		generateBehaviorDefinition
]

{ #category : #'private - generate' }
GtViewModelWithSelectionDerive >> generateSelectableChildAccessorsFor: aViewModelModeWithCodeDefinition [
	| aViewModelModel aSelectableDefinition |

	aViewModelModel := aViewModelModeWithCodeDefinition viewModelModel.

	aViewModelModel hasParent
		ifFalse: [ ^ self ].

	aViewModelModel parent isForMany
		ifFalse: [ ^ self ].

	aSelectableDefinition := self generateSelectableChildAccessorsDefinitionFor: aViewModelModeWithCodeDefinition.

	aViewModelModeWithCodeDefinition viewModelModel
		mergeBehaviorDefinition: aSelectableDefinition instanceSideDefinition
		into: aViewModelModeWithCodeDefinition definition
]

{ #category : #'private - generate' }
GtViewModelWithSelectionDerive >> generateSelectedViewModelChangedAnnouncementFor: aViewModelModel [
	| aDefinition |
	
	self
		assert: [ aViewModelModel isForMany ]
		description: [ 'Only view model for many can announce selected view model changed event' ].
	
	aDefinition := GtClassDefinition forNew.
	aDefinition name: (self selectedViewModelChangedAnnouncementNameFor: aViewModelModel).
	aDefinition superclass name: #Announcement.
	aDefinition category package name: aViewModelModel package.
	
	^ aDefinition
]

{ #category : #'private - generate' }
GtViewModelWithSelectionDerive >> generateSelectedViewModelChangedNotifierMethodFor: aViewModelModelWithCodeDefinition [
	| aMethodDefinition methodSourceCode |
	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement parent specific selection methods' ].

	aMethodDefinition := self
		selectionPropertyChangeNotifierMethodOf: aViewModelModelWithCodeDefinition.
			
	methodSourceCode := aMethodDefinition sourceCode, String cr, String cr, String tab, 
		'self announce: ', (self selectedViewModelChangedAnnouncementNameFor: aViewModelModelWithCodeDefinition viewModelModel),' new'.

	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: methodSourceCode
		protocol: aMethodDefinition protocol
]

{ #category : #'private - generate' }
GtViewModelWithSelectionDerive >> generateSelectionSetHookMethodTo: aViewModelModelWithCodeDefinition [
	| aMethodDefinition methodSourceCode aArgumentName |

	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement parent specific selection methods' ].

	aMethodDefinition := self selectionPropertySetHookMethodOf: aViewModelModelWithCodeDefinition.

	aArgumentName := aMethodDefinition arguments first.

	methodSourceCode := String streamContents: [ :aStream |
		aStream
			nextPutAll: aMethodDefinition sourceCode; cr;
			cr.

		aViewModelModelWithCodeDefinition hasParent
			ifTrue: [
				| aSetterMethod |
				
				aSetterMethod := self selectionPropertySetterMethodOf: aViewModelModelWithCodeDefinition parent.
				aSetterMethod ifNotNil: [
					aStream
						tab;
						nextPutAll: 'self';
						space;
						nextPutAll: aViewModelModelWithCodeDefinition parentViewModelSelectorName;
						space;
						nextPutAll: aSetterMethod selector;
						nextPut: $.;
						cr ] ].

		aStream
			tab; nextPutAll: aArgumentName; space; nextPutAll: (self selectedNotifierNameOf: aViewModelModelWithCodeDefinition forOneModel) ].

	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: methodSourceCode
		protocol: aMethodDefinition protocol
]

{ #category : #'private - generate' }
GtViewModelWithSelectionDerive >> generateSelectionUnsetHookMethodTo: aViewModelModelWithCodeDefinition [
	| aMethodDefinition methodSourceCode aArgumentName |

	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement parent specific selection methods' ].

	aMethodDefinition := self selectionPropertyUnsetHookMethodOf: aViewModelModelWithCodeDefinition.

	aArgumentName := aMethodDefinition arguments first.

	methodSourceCode := String streamContents: [ :aStream |
		aStream
			nextPutAll: aMethodDefinition sourceCode; cr;
			cr;
			tab;
				nextPutAll: aArgumentName; space;
				nextPutAll: (self selectionPropertyUnsetOthersNameOf: aViewModelModelWithCodeDefinition forOneModel);
				nextPut: $.; cr;
			tab;
				nextPutAll: aArgumentName; space;
				nextPutAll: (self deselectedNotifierNameOf: aViewModelModelWithCodeDefinition forOneModel) ].

	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: methodSourceCode
		protocol: aMethodDefinition protocol
]

{ #category : #'private - generate' }
GtViewModelWithSelectionDerive >> generateViewModelDeselectedAnnouncementFor: aViewModelModel [
	| aDefinition |
	
	self
		assert: [ aViewModelModel isForOne ]
		description: [ 'Only view model for one can announce deselected event' ].
	
	aDefinition := GtClassDefinition forNew.
	aDefinition name: (self viewModelDeselectedAnnouncementNameFor: aViewModelModel).
	aDefinition superclass name: #Announcement.
	aDefinition category package name: aViewModelModel package.
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
GtViewModelWithSelectionDerive >> generateViewModelSelectedAnnouncementFor: aViewModelModel [
	| aDefinition |
	
	self
		assert: [ aViewModelModel isForOne ]
		description: [ 'Only view model for one can announce selected event' ].
	
	aDefinition := GtClassDefinition forNew.
	aDefinition name: (self viewModelSelectedAnnouncementNameFor: aViewModelModel).
	aDefinition superclass name: #Announcement.
	aDefinition category package name: aViewModelModel package.
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
GtViewModelWithSelectionDerive >> generateWithSelectedViewModelTraitFor: aViewModelModelWithCodeDefinition [
	| aViewModelModel aCodeDefinition |

	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement selection trait' ].
	
	aViewModelModel := aViewModelModelWithCodeDefinition viewModelModel.
	aCodeDefinition := aViewModelModelWithCodeDefinition definition.	

	^ GtWithPropertyTraitGenerator new
		environment: aCodeDefinition environment;
		propertyName: (self selectionPropertyNameFor: aViewModelModel);
		propertySetter: 'select', aViewModelModel forOneModel name capitalized ,'ViewModel';
		propertyUnsetter: 'deselect', aViewModelModel forOneModel name capitalized ,'ViewModel';
		propertyType: aViewModelModel forOneModel viewModelClassName;
		propertyComparator: #=;
		projectPrefix: (aViewModelModel project, aViewModelModel prefix capitalized);
		packageName: aViewModelModel package;
		generateBehaviorDefinition
]

{ #category : #'private - accessors' }
GtViewModelWithSelectionDerive >> selectedNotifierNameOf: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have child specific selection method' ].

	^ (self
		selectionPropertyMethodOfType: #propertySetNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - class names' }
GtViewModelWithSelectionDerive >> selectedViewModelChangedAnnouncementNameFor: aViewModelModel [
	^ '{project}{prefix}Selected{name}{suffix}ViewModelChanged'
		format: { 
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#name -> aViewModelModel forOneModel name capitalized.
			#suffix -> aViewModelModel suffix capitalized.
		} asDictionary
]

{ #category : #'private - methods' }
GtViewModelWithSelectionDerive >> selectionPropertyChangeNotifierMethodOf: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can have selection change notifier method' ].

	^ self
		selectionPropertyMethodOfType: #propertyChangeNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - accessors' }
GtViewModelWithSelectionDerive >> selectionPropertyGetterNameOf: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can have selection tester method' ].

	^ (self
		selectionPropertyMethodOfType: #propertyGetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition) selector
]

{ #category : #private }
GtViewModelWithSelectionDerive >> selectionPropertyMethodOfType: aMethodType inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition [
	^ aViewModelModelWithCodeDefinition viewModelModel
		propertyMethodFor: (self selectionPropertyNameFor: aViewModelModelWithCodeDefinition viewModelModel)
		ofType: aMethodType
		inViewModelBehavior: aViewModelModelWithCodeDefinition definition
]

{ #category : #'private - accessors' }
GtViewModelWithSelectionDerive >> selectionPropertyNameFor: aViewModelModel [
	| aName |

	aName := aViewModelModel isForMany
		ifTrue: [ aViewModelModel forOneModel name ]
		ifFalse: [ aViewModelModel name ].

	^ 'selected', aName capitalized ,'ViewModel'
]

{ #category : #'private - methods' }
GtViewModelWithSelectionDerive >> selectionPropertySetHookMethodOf: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can have selection set hook method' ].

	^ self
		selectionPropertyMethodOfType: #propertySetHook:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - methods' }
GtViewModelWithSelectionDerive >> selectionPropertySetterMethodOf: aViewModelModelWithCodeDefinition [

	"Both for many and for one view models can be used to select an entity"
	^ (self
		selectionPropertyMethodOfType: #propertySetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - accessors' }
GtViewModelWithSelectionDerive >> selectionPropertySetterNameOf: aViewModelModelWithCodeDefinition [

	"Both for many and for one view models can be used to select an entity"
	^ (self selectionPropertySetterMethodOf: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - accessors' }
GtViewModelWithSelectionDerive >> selectionPropertyTesterNameOf: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can have selection tester method' ].

	^ (self
		selectionPropertyMethodOfType: #propertyTester:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - methods' }
GtViewModelWithSelectionDerive >> selectionPropertyUnsetHookMethodOf: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can have selection set hook method' ].

	^ self
		selectionPropertyMethodOfType: #propertyUnsetHook:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - methods' }
GtViewModelWithSelectionDerive >> selectionPropertyUnsetOthersMethodOf: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have deselect others method' ].

	^ self
		selectionPropertyMethodOfType: #propertyUnsetOthers:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - accessors' }
GtViewModelWithSelectionDerive >> selectionPropertyUnsetOthersNameOf: aViewModelModelWithCodeDefinition [
	^ (self selectionPropertyUnsetOthersMethodOf: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - accessors' }
GtViewModelWithSelectionDerive >> selectionPropertyUnsetterNameOf: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can have selection tester method' ].

	^ (self
		selectionPropertyMethodOfType: #propertyUnsetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - class names' }
GtViewModelWithSelectionDerive >> viewModelDeselectedAnnouncementNameFor: aViewModelModel [
	^ '{project}{prefix}{name}{suffix}ViewModelDeselected'
		format: { 
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#name -> aViewModelModel name capitalized.
			#suffix -> aViewModelModel suffix capitalized.
		} asDictionary
]

{ #category : #'private - class names' }
GtViewModelWithSelectionDerive >> viewModelSelectedAnnouncementNameFor: aViewModelModel [
	^ '{project}{prefix}{name}{suffix}ViewModelSelected'
		format: { 
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#name -> aViewModelModel name capitalized.
			#suffix -> aViewModelModel suffix capitalized.
		} asDictionary
]

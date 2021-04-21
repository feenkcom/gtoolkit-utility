Class {
	#name : #GtRobocoderForOneMetamodel,
	#superclass : #GtRobocoderMetamodel,
	#instVars : [
		'children'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #adding }
GtRobocoderForOneMetamodel >> addChild: aGtNavigationViewModelModel [
	(self hasChild: aGtNavigationViewModelModel)
		ifTrue: [ ^ self ].

	children add: aGtNavigationViewModelModel.
	
	aGtNavigationViewModelModel isForMany
		ifTrue: [ aGtNavigationViewModelModel addParent: self ]
		ifFalse: [ aGtNavigationViewModelModel parent: self ]
]

{ #category : #'api - accessing' }
GtRobocoderForOneMetamodel >> childViewModelsName [
	^ self generateChildObjectGetterSelectorFor: self
]

{ #category : #accessing }
GtRobocoderForOneMetamodel >> children [
	^ children
]

{ #category : #accessing }
GtRobocoderForOneMetamodel >> children: anObject [
	children := anObject
]

{ #category : #'api - generation' }
GtRobocoderForOneMetamodel >> generateChildViewModelsAccessorFor: aViewModelDefinition [
	children do: [ :eachChildModel |
		| theChildrenAccessorsDefinition theChildrenAccessor |

		theChildrenAccessor := properties
			at: eachChildModel name
			ifAbsent: [ eachChildModel name ].

		theChildrenAccessorsDefinition := GtRobocoderTraitGenerator new
			templateTrait: TGtRobocoderMetamodelChildrenForOneTemplate;
			mappings: { 
				#__Parent_view_model_class__ -> self objectClassName.
				#childObject -> (self generateChildObjectGetterSelectorFor: eachChildModel) uncapitalized.
				#modelGetter -> self modelGetterSelector uncapitalized.
				#childGetter -> theChildrenAccessor uncapitalized.
				#childViewModelClass -> eachChildModel objectClassName capitalized.
				#childParentObjectSetter -> (eachChildModel generateParentObjectGetterSelectorFor: self) uncapitalized.
				#childSetter -> eachChildModel modelSetterSelector uncapitalized
			};
			generate.

		self
			mergeBehaviorDefinition: theChildrenAccessorsDefinition
			into: aViewModelDefinition ]
]

{ #category : #testing }
GtRobocoderForOneMetamodel >> hasChild: aChild [
	(children includes: aChild)
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #testing }
GtRobocoderForOneMetamodel >> hasParent [
	^ parent notNil
]

{ #category : #testing }
GtRobocoderForOneMetamodel >> hasParents [
	^ self hasParent
]

{ #category : #initialization }
GtRobocoderForOneMetamodel >> initialize [
	super initialize.
	
	children := OrderedCollection new
]

{ #category : #testing }
GtRobocoderForOneMetamodel >> isForOne [
	^ true
]

{ #category : #accessing }
GtRobocoderForOneMetamodel >> parent [
	^ parent
]

{ #category : #accessing }
GtRobocoderForOneMetamodel >> parent: anObject [
	parent := anObject
]

{ #category : #'api - accessing' }
GtRobocoderForOneMetamodel >> parentViewModelSelectorName [
	self
		assert: [ self hasParent ]
		description: [ 'Can not create parent selector if there is no parent' ].

	^ self generateParentObjectGetterSelectorFor: self parent
]

{ #category : #'api - accessing' }
GtRobocoderForOneMetamodel >> parents [
	^ { self parent }
]

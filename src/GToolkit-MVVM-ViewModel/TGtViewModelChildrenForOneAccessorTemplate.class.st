"
!! Accessing a view model for ==__children__== domain model
${class:__Parent_view_model_class__}$ is a view model for a ==__model__== domain model which in turn contains ==__children__== domain model. To accomodate that child domain model, a corresponding ${class:__Child_view_model_class__}$ is created and assigned as the child view model of ${class:__Parent_view_model_class__}$.
That child view model is instantiated lazily by ${method:__Parent_view_model_class__>>#create__Child_view_models__}$ and can be accessed with the help of ${method:__Parent_view_model_class__>>#__child_view_models__}$.
"
Class {
	#name : #TGtViewModelChildrenForOneAccessorTemplate,
	#superclass : #Object,
	#instVars : [
		'__child_view_models__'
	],
	#classVars : [
		'__Child_view_model_class__'
	],
	#category : #'GToolkit-MVVM-ViewModel-Templates'
}

{ #category : #'api - accessing' }
TGtViewModelChildrenForOneAccessorTemplate >> __child_view_models__ [
	"Return a composite view model (${class:__Child_view_model_class__}$) created for a collection of children from the domain model.
	Note: The view model is lazily instantiated."
	<return: #__Child_view_model_class__>

	^  __child_view_models__ ifNil: [ __child_view_models__ := self create__Child_view_models__ ]
]

{ #category : #'api - accessing' }
TGtViewModelChildrenForOneAccessorTemplate >> childViewModelsTemplate [
	<gtMethodTemplate>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{childViewModel}}
	"Return a composite view model (${class:{{childViewModelClass}}}$) created for a collection of children from the domain model.
	Note: The view model is lazily instantiated."
	<return: #{{childViewModelClass}}>

	^ {{childViewModel}} ifNil: [ {{childViewModel}} := self {{''create'', childViewModel capitalized}} ]';
		protocol: 'api - accessing';
		storageMethod: thisContext method
]

{ #category : #'private - instance creation' }
TGtViewModelChildrenForOneAccessorTemplate >> createChildViewModelsTemplate [
	<gtMethodTemplate>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{''create'', childViewModel capitalized}}
	"Create a composite view model for a collection of children and return the result"
	<return: #{{childViewModelClass}}>
	| childrenViewModel |

	childrenViewModel := {{childViewModelClass}} new.
	{{childParentViewModelSetter
		ifNotNil: [ :aSelector | ''childrenViewModel {{aSelector}}: self.'' ]
		ifNil: [ '''' ]}}
	childrenViewModel {{childModelSetter}}: self {{modelGetter}} {{childModelGetter}}.
	^ childrenViewModel';
		protocol: 'private - instance creation';
		storageMethod: thisContext method
]

{ #category : #'private - instance creation' }
TGtViewModelChildrenForOneAccessorTemplate >> create__Child_view_models__ [
	"Create a composite view model for a collection of children and return the result"
	<return: #__Child_view_model_class__>
	| childrenViewModel |

	childrenViewModel := __Child_view_model_class__ new.
	childrenViewModel __child_parent_view_model_setter__ self.
	childrenViewModel __child_model_setter__ self __model__ __children__.
	^ childrenViewModel
]

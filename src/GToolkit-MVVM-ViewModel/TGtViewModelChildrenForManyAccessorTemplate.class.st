"
!! Accessing child view models
A view model built for a domain model that represents a collection of some entities creates a view model (${class:__Child_view_model_class__}$) for each domain entity. To do so it accesses the children of the ${method:__View_model_class_name__>>#__model__}$ by sending it ==__children__== message. Users can access the child view models via ${method:__View_model_class_name__>>#__child_view_models__}$. In addition to the parent -> child view model navigation, each child view model knows its parent view model via ${method:__Child_view_model_class__>>#__child_parent_view_model_setter__}$
"
Class {
	#name : #TGtViewModelChildrenForManyAccessorTemplate,
	#superclass : #Object,
	#instVars : [
		'__child_view_models__'
	],
	#classVars : [
		'__Child_view_model_class__'
	],
	#category : #'GToolkit-MVVM-ViewModel-Templates'
}

{ #category : #templates }
TGtViewModelChildrenForManyAccessorTemplate >> childViewModelsTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{childViewModels}}
	"Return a collection of view models (${class:{{childViewModelsClass}}}$) created for each child from the domain model.
	Note: The view models are lazily instantiated."
	<return: #Collection of: #{{childViewModelsClass}}>

	^  {{childViewModels}} ifNil: [ {{childViewModels}} := self {{''create'', childViewModels capitalized}} ]';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtViewModelChildrenForManyAccessorTemplate >> createChildViewModelsTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtPharoTemplateMethod new
		sourceCode: '{{''create'', childViewModels capitalized}}
	"For each child from the domain model create a view model and return a resulting collection"
	<return: #Collection of: #{{childViewModelsClass}}>

	^ self {{modelGetter}} {{childModelsGetter}} collect: [ :eachModel |
		| eachViewModel |
		eachViewModel := {{childViewModelsClass}} new.
		{{childParentViewModelSetter
			ifNotNil: [ :aSelector | ''eachViewModel {{aSelector}}: self.'' ]
			ifNil: [ '''' ]}}
		eachViewModel {{childModelSetter}}: eachModel ] as: Array';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtViewModelChildrenForManyAccessorTemplate >> traitTemplate [
	<gtBehaviorTemplate>
	
	^ GtPharoTemplateTrait new
		instanceSide:
'Trait named: #{{name}}
	 uses: {}
	 slots: { #__view_model__ }
	 package: ''{{package}}''';
		storageMethod: self
]

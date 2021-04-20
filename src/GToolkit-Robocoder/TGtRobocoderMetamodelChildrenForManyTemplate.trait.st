"
!! Accessing child view models
A view model built for a domain model that represents a collection of some entities creates a view model (${class:__Child_view_model_class__}$) for each domain entity. To do so it accesses the children of the ${method:__View_model_class_name__>>#__model__}$ by sending it ==__children__== message. Users can access the child view models via ${method:__View_model_class_name__>>#__child_view_models__}$. In addition to the parent -> child view model navigation, each child view model knows its parent view model via ${method:__Child_view_model_class__>>#__child_parent_view_model_setter__}$
"
Trait {
	#name : #TGtRobocoderMetamodelChildrenForManyTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyTemplate >> childObjectsTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{childObjects}}
	"Return a collection of objects (${class:{{childObjectsClass}}}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #{{childObjectsClass}}>

	^  {{childObjects}} ifNil: [ {{childObjects}} := self create{{childObjects capitalized}} ]';
		protocol: 'api - accessing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyTemplate >> createChildObjectsTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'create{{childObjects capitalized}}
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #{{childObjectsClass}}>

	^ self {{modelGetter}} {{childModelsGetter}} collect: [ :eachModel |
		| eachChild |
		eachChild := {{childObjectsClass}} new.
		{{childParentObjectSetter
			ifNotNil: [ :aSelector | ''eachChild {{aSelector}}: self.'' ]
			ifNil: [ '''' ]}}
		eachChild {{childModelSetter}}: eachModel ] as: Array';
		protocol: 'private - instance creation';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: ((Array new: 1) at: 1 put: (GtSlotDefinition new name: #'{{childObjects}}'; type: #InstanceVariableSlot); yourself)); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

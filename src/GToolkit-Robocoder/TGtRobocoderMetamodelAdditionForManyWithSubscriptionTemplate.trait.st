Trait {
	#name : #TGtRobocoderMetamodelAdditionForManyWithSubscriptionTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyWithSubscriptionTemplate >> onAddedEventHanderTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'on{{childName capitalized}}Added: a{{childAnnouncementClass}}
	"Is sent when a new {{childName capitalized}} is added to the model of the receiver due to
	the handled ${class:{{childAnnouncementClass}}}$ announcement."
	<modelEventHandler: #{{childName}}>
	| aNewChildObject |

	aNewChildObject := self {{childObjectCreator gtAsReader}}: a{{childAnnouncementClass}} {{childAnnouncementGetter}}.
	self {{childObjectGetter}} add: aNewChildObject.
	self on{{objectName capitalized}}Added: aNewChildObject';
		protocol: 'private - event handling';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyWithSubscriptionTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: #()); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

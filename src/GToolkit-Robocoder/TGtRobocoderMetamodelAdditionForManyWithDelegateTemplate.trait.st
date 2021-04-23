Trait {
	#name : #TGtRobocoderMetamodelAdditionForManyWithDelegateTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyWithDelegateTemplate >> addDelegateTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{addSelector gtAsReader}}: a{{childName capitalized}}
	"Request the model to add a given child object.
	I do nothing and simply delegate the addition. If the operation will trigger
	an announcement and I react to it, it will trigger an update"

	self {{modelGetter}} {{addSelector gtAsReader}}: a{{childName capitalized}}';
		protocol: 'api - adding';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyWithDelegateTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: #()); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

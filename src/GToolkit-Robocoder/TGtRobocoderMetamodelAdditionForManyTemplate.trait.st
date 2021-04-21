Trait {
	#name : #TGtRobocoderMetamodelAdditionForManyTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyTemplate >> addObjectTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'add{{objectName capitalized}}: a{{objectName capitalized}}
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #{{childName}}>

	(self {{objectFinder gtAsReader}}: a{{objectName capitalized}})
		ifTrue: [ ^ self ].

	self {{childrenGetter}} add: a{{objectName capitalized}}.
	self on{{objectName capitalized}}Added: a{{objectName capitalized}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyTemplate >> notifyObjectAddedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'notify{{objectName capitalized}}Added: a{{objectName capitalized}}
	"Notifies that a given child object was added to the receiver"';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyTemplate >> objectAddedHookTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'on{{objectName capitalized}}Added: a{{objectName capitalized}}
	"Is sent after a given child object was added to the receiver"

	self notify{{objectName capitalized}}Added: a{{objectName capitalized}}.';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyTemplate >> templateTrait [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: #()); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

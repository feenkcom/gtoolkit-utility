Trait {
	#name : #TGtRobocoderMetamodelRemovalForManyTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> notifyObjectRemovedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'notify{{objectName capitalized}}Removed: a{{objectName capitalized}}
	"Notifies that a given child object was removed from the receiver"';
		protocol: 'private - notifying';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> objectRemovedHookTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'on{{objectName capitalized}}Removed: a{{objectName capitalized}}
	"Is sent after a given child object was removed from the receiver"

	self notify{{objectName capitalized}}Removed: a{{objectName capitalized}}.';
		protocol: 'api - removing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> removeObjectTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'remove{{objectName capitalized}}: a{{objectName capitalized}}
	"Removed a given child object from the receiver and notify subscribers about it.
	Do nothing if an object is not one of my children."
	<objectAdder: #{{childName}}>

	(self {{objectFinder gtAsReader}}: a{{objectName capitalized}})
		ifFalse: [ ^ self ].

	self {{childrenGetter}} remove: a{{objectName capitalized}}.
	self on{{objectName capitalized}}Removed: a{{objectName capitalized}}';
		protocol: 'api - removing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: #()); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

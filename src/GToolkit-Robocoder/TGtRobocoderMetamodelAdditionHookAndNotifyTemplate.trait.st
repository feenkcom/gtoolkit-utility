"
Add me to metamodels that require a hook when a child object is added
"
Trait {
	#name : #TGtRobocoderMetamodelAdditionHookAndNotifyTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelAdditionHookAndNotifyTemplate >> notifyObjectAddedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'notify{{objectName capitalized}}Added: a{{objectName capitalized}}
	"Notifies that a given child object was added to the receiver"
	
	{{announce ifNotNil: [ :aSelector |
	''self {{aSelector gtAsReader}}: ({{announcementClass}} new
		{{announcementSetter gtAsReader}}: a{{objectName capitalized}}) ''] }}';
		protocol: 'private - notifying';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionHookAndNotifyTemplate >> objectAddedHookTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'on{{objectName capitalized}}Added: a{{objectName capitalized}}
	"Is sent after a given child object was added to the receiver"

	self notify{{objectName capitalized}}Added: a{{objectName capitalized}}.';
		protocol: 'api - adding';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionHookAndNotifyTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: #()); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

Trait {
	#name : #TGtRobocoderMetamodelAdditionForManyTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyTemplate >> addDelegateTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{addDelegateSelector gtAsReader}}: a{{childModelName capitalized}}
	"Request the model to add a given child object.
	I do nothing and simply delegate the addition to the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	self {{modelGetter}} {{addDelegateSelector gtAsReader}}: a{{childModelName capitalized}}';
		protocol: 'api - adding';
		condition: '{ addDelegateSelector . modelGetter } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyTemplate >> addObjectTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'add{{childObjectName capitalized}}: a{{childObjectName capitalized}}
	"Add a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #{{childName}}>

	(self {{childObjectFinder gtAsReader}}: a{{childObjectName capitalized}})
		ifTrue: [ ^ self ].

	self {{childObjectGetter}} add: a{{childObjectName capitalized}}.
	self on{{childObjectName capitalized}}Added: a{{childObjectName capitalized}}';
		protocol: 'api - adding';
		condition: 'addDelegateSelector isNil and: [ { childObjectFinder . childObjectGetter } allSatisfy: #notNil ]';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyTemplate >> notifyObjectAddedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'notify{{childObjectName capitalized}}Added: a{{childObjectName capitalized}}
	"Notifies that a given child object was added to the receiver"
	
	{{announce ifNotNil: [ :aSelector |
	''self {{aSelector gtAsReader}}: ({{announcementClass}} new
		{{announcementSetter gtAsReader}}: a{{childObjectName capitalized}}) ''] }}';
		protocol: 'private - notifying';
		condition: '{ announce . announcementClass . announcementSetter } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyTemplate >> objectAddedHookTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'on{{childObjectName capitalized}}Added: a{{childObjectName capitalized}}
	"Is sent after a given child object was added to the receiver"

	self notify{{childObjectName capitalized}}Added: a{{childObjectName capitalized}}.';
		protocol: 'api - adding';
		condition: '{ announce . announcementClass . announcementSetter } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyTemplate >> onAddedEventHanderTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'on{{childModelName capitalized}}Added: a{{childAnnouncementClass}}
	"Is sent when a new {{childName capitalized}} is added to the model of the receiver due to
	the handled ${class:{{childAnnouncementClass}}}$ announcement."
	<modelEventHandler: #{{childName}} event: #{{childAnnouncementClass}}>
	| aNewChildObject |

	aNewChildObject := self {{childObjectCreator gtAsReader}}: a{{childAnnouncementClass}} {{childAnnouncementGetter}}.
	self {{childObjectGetter}} add: aNewChildObject.
	self on{{childObjectName capitalized}}Added: aNewChildObject';
		protocol: 'private - event handling';
		condition: '{ childAnnouncementClass . childAnnouncementGetter . childObjectGetter . childObjectCreator } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelAdditionForManyTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: #()); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

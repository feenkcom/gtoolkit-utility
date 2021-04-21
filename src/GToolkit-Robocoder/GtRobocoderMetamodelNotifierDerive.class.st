Class {
	#name : #GtRobocoderMetamodelNotifierDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelNotifierDerive class >> label [
	^ 'notifier'
]

{ #category : #templates }
GtRobocoderMetamodelNotifierDerive >> announceTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'announce: anAnnouncement
	{{announcer}} ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].

	"Dispatch anAnnouncement to the parent objects if they are assigned"
	{{parents collect: [ :each |
	''self {{each at: #tester}}
		ifTrue: [ self {{each at: #getter}} announce: anAnnouncement ].''
	] separatedBy: [ String cr, String tab ]}}';
		storageMethod: thisContext method
]

{ #category : #'api - generation' }
GtRobocoderMetamodelNotifierDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		self generateAnnounceMethodFor: eachMetamodelWithCodeDefinition ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelNotifierDerive >> generateAnnounceMethodFor: aMetamodelWithCodeDefinition [
	| anAnnounceMethod theParents  anAnnounceMethodSourceCode |

	aMetamodelWithCodeDefinition hasParents
		ifFalse: [ ^ self ].

	anAnnounceMethod := aMetamodelWithCodeDefinition definition instanceSideDefinition methods
		methodNamed: #announce:
		ifFound: #yourself
		ifNone: [ ^ self ].
	
	anAnnounceMethod
		ifNil: [ ^ self ].
		
	theParents := Array streamContents: [ :aStream |
		aMetamodelWithCodeDefinition parents do: [ :eachParentMetamodelWithCodeDefinition |
			| parentGetter parentTester |
			
			parentGetter := GtRobocoderMetamodelParentDerive
				parentObjectGetterSelectorIn: aMetamodelWithCodeDefinition
				parentMetamodel: eachParentMetamodelWithCodeDefinition.
				
			parentTester := GtRobocoderMetamodelParentDerive
				parentObjectTesterSelectorIn: aMetamodelWithCodeDefinition
				parentMetamodel: eachParentMetamodelWithCodeDefinition.
				
			(parentGetter notNil and: [ parentTester notNil ])
				ifTrue: [
					aStream nextPut: { #tester -> parentTester . #getter ->  parentGetter} asDictionary ] ] ].

	theParents
		ifEmpty: [ ^ self ].

	anAnnounceMethodSourceCode := GtRobocoderTemplateMethodCoder new
			forMethod: self class >> #announceTemplate;
			mappings: {
				#announcer -> GtRobocoderMetamodelAnnouncerDerive generateAnnouncerTrait slots all first name.
				#parents -> theParents };
			translate.

	aMetamodelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: anAnnounceMethodSourceCode
		protocol: anAnnounceMethod protocol
]

Class {
	#name : #GtRobocoderMetamodelWithSimplePropertyDerive,
	#superclass : #GtRobocoderMetamodelWithPropertyDerive,
	#instVars : [
		'name',
		'getter',
		'setter',
		'unsetter',
		'type',
		'comparator'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive class >> label [
	^ 'property'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelWithSimplePropertyDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		| aDefinition |
		aDefinition := GtRobocoderWithPropertyTraitGenerator new
			environment: eachMetamodelWithCodeDefinition environment;
			propertyName: self name;
			propertyGetter: self getter;
			propertySetter: self setter;
			propertyUnsetter: self unsetter;
			propertyType: self type;
			propertyComparator: self comparator;
			projectPrefix: (eachMetamodelWithCodeDefinition prefix, eachMetamodelWithCodeDefinition project capitalized);
			packageName: eachMetamodelWithCodeDefinition package;
			tagName: eachMetamodelWithCodeDefinition metamodel fullTagForTraits;
			generate.
			
		eachMetamodelWithCodeDefinition mergeBehaviorDefinition: aDefinition ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> comparator [
	^ comparator
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> comparator: anObject [
	comparator := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> getter [
	^ getter ifNil: [ self name ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> getter: anObject [
	getter := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> name: anObject [
	name := anObject
]

{ #category : #'private - accessing' }
GtRobocoderMetamodelWithSimplePropertyDerive >> propertyNameFor: aViewModelModel [
	^ self name
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> setter [
	^ setter ifNil: [ self name ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> setter: anObject [
	setter := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> type [
	^ type ifNil: [ #Object ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> type: anObject [
	type := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> unsetter [
	^ unsetter ifNil: [ 'unset', self name capitalized ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> unsetter: anObject [
	unsetter := anObject
]

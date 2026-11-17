"
I say which {{gtClass:GtMemorySpaceAttribution}} is used for one part of an object, for example the object itself, or the objects in the slots without their own rule. My label describes the part.

My subclasses are for the parts that are looked up while estimating: {{gtClass:GtMemorySpaceSlotRule}} for a slot, and {{gtClass:GtMemorySpaceKeyRule}} for the key of a dictionary. Definitions ({{gtClass:GtMemorySpaceDefinition}}) also use me to describe the attribution of each kind of root.

The rules of an attribution can be seen in its Rules view.
"
Class {
	#name : #GtMemorySpaceRule,
	#superclass : #Object,
	#instVars : [
		'label',
		'attribution'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceRule class >> label: aString attribution: anAttribution [
	^ self new setLabel: aString attribution: anAttribution
]

{ #category : #accessing }
GtMemorySpaceRule >> attribution [
	"The attribution used for the part of the object"

	^ attribution
]

{ #category : #'gt - extensions' }
GtMemorySpaceRule >> gtViewRulesFor: aView [
	<gtView>
	self rules ifEmpty: [ ^ aView empty ].

	^ aView forward
		title: 'Rules';
		priority: 10;
		object: [ attribution ];
		view: #gtViewRulesFor:
]

{ #category : #accessing }
GtMemorySpaceRule >> label [
	"A description of the part of the object"

	^ label
]

{ #category : #printing }
GtMemorySpaceRule >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: (label ifNil: [ '' ]);
		nextPutAll: ': ';
		nextPutAll: self summary;
		nextPut: $)
]

{ #category : #accessing }
GtMemorySpaceRule >> rules [
	"The rules of my attribution, for the parts of the part"

	^ attribution ifNil: [ #() ] ifNotNil: [ attribution rules ]
]

{ #category : #initialization }
GtMemorySpaceRule >> setLabel: aString attribution: anAttribution [
	label := aString.
	attribution := anAttribution
]

{ #category : #accessing }
GtMemorySpaceRule >> summary [
	^ attribution ifNil: [ 'no attribution' ] ifNotNil: [ attribution summary ]
]

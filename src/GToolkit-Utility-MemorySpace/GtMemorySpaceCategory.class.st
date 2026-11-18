"
I am a category of a memory space estimation: a part of the memory to which objects are attributed (see {{gtClass:GtMemorySpaceAttribution}}).

I have a key, used to refer to me in a {{gtClass:GtMemorySpaceDefinition}}, a name, and a description of what I contain.
"
Class {
	#name : #GtMemorySpaceCategory,
	#superclass : #Object,
	#instVars : [
		'key',
		'name',
		'description'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceCategory class >> key: aKey name: aName description: aDescription [
	^ self new
		key: aKey;
		name: aName;
		description: aDescription;
		yourself
]

{ #category : #accessing }
GtMemorySpaceCategory class >> nameOf: aCategory [
	"The name to display for a category. 
	Categories are usually instances of me, but any object, like a symbol, can be used as a category."

	^ (aCategory isKindOf: self)
		ifTrue: [ aCategory name ]
		ifFalse: [ aCategory asString ]
]

{ #category : #accessing }
GtMemorySpaceCategory >> description [
	^ description
]

{ #category : #accessing }
GtMemorySpaceCategory >> description: aDescription [
	description := aDescription
]

{ #category : #accessing }
GtMemorySpaceCategory >> key [
	^ key
]

{ #category : #accessing }
GtMemorySpaceCategory >> key: aKey [
	key := aKey
]

{ #category : #accessing }
GtMemorySpaceCategory >> name [
	^ name
]

{ #category : #accessing }
GtMemorySpaceCategory >> name: aName [
	name := aName
]

{ #category : #printing }
GtMemorySpaceCategory >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: name;
		nextPut: $)
]

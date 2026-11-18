"
I say which {{gtClass:GtMemorySpaceAttribution}} is used for the value of one key, in a {{gtClass:GtMemorySpaceDictionaryAttribution}}.
"
Class {
	#name : #GtMemorySpaceKeyRule,
	#superclass : #GtMemorySpaceRule,
	#instVars : [
		'key'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceKeyRule class >> key: aKey attribution: anAttribution [
	^ (self label: 'key ' , aKey printString attribution: anAttribution)
		setKey: aKey
]

{ #category : #accessing }
GtMemorySpaceKeyRule >> key [
	^ key
]

{ #category : #initialization }
GtMemorySpaceKeyRule >> setKey: aKey [
	key := aKey
]

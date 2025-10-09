"
This models the type of pragma instances.

It essentially knows the keyword that defines the Pragma, and can obtain all occurences of that Pragma.

!!Example

[[[
	PragmaType all
]]]
"
Class {
	#name : #GtPragmaType,
	#superclass : #Object,
	#instVars : [
		'keyword',
		'pragmas'
	],
	#category : #'GToolkit-Utility-Basic-Pragma'
}

{ #category : #accessing }
GtPragmaType class >> all [
	| pragmaTypes |
	pragmaTypes := OrderedCollection new.
	Pragma pragmaCache
		keysAndValuesDo: [ :key :value | 
			pragmaTypes
				add: (self new
						keyword: key;
						pragmas: value asOrderedCollection;
						yourself) ].
	^ pragmaTypes
]

{ #category : #ui }
GtPragmaType >> gtUsersFor: aView [
	<gtView>
	^ aView list
		  title: 'Users';
		  priority: 10;
		  items: [ self users sorted: [ :a :b | a selector < b selector ] ]
]

{ #category : #accessing }
GtPragmaType >> keyword [
	^ keyword
]

{ #category : #accessing }
GtPragmaType >> keyword: anObject [
	keyword := anObject
]

{ #category : #accessing }
GtPragmaType >> pragmas [
	^ pragmas
		ifNil: [ pragmas := (Pragma allNamed: self keyword) asOrderedCollection ]
]

{ #category : #accessing }
GtPragmaType >> pragmas: aCollection [
	pragmas := aCollection
]

{ #category : #printing }
GtPragmaType >> printOn: stream [
	stream nextPutAll: self keyword
]

{ #category : #accessing }
GtPragmaType >> users [
	^ (self keyword senders collect: [ :each | each compiledMethod ]) \ (self pragmas collect: [ :each | each method ])
]

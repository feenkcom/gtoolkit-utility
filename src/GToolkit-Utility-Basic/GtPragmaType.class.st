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
	#category : #'GToolkit-Utility-Basic'
}

{ #category : #accessing }
GtPragmaType class >> all [
	| pragmas |
	pragmas := OrderedCollection new.
	Object withAllSubclassesDo: [ :each | 
		each pragmasDo: [ :p | pragmas add: p ] ].
	^ (pragmas groupedBy: #selector) associations collect: [ :association | 
		  self new
			  keyword: association key;
			  pragmas: association value ]
]

{ #category : #ui }
GtPragmaType >> gtUsersFor: aView [
	<gtView>
	^ aView list
		  title: 'Users';
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
	^ pragmas ifNil: [
		pragmas := OrderedCollection new.
		SystemNavigation new allBehaviorsDo: [ :each |
			Pragma withPragmasIn: each do: [ :p |
				p selector = self selector ifTrue: [ 
					pragmas add: p ] ] ].
		pragmas ]
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

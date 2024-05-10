Class {
	#name : #GtRBNodeQuery,
	#superclass : #Object,
	#traits : 'TGtGroup',
	#classTraits : 'TGtGroup classTrait',
	#instVars : [
		'nodes'
	],
	#category : #'GToolkit-Utility-RB'
}

{ #category : #'instance creation' }
GtRBNodeQuery class >> nodes: aCollection [
	^ self new
		nodes: aCollection;
		yourself
]

{ #category : #querying }
GtRBNodeQuery >> / aNameOrClass [
	| name result |
	result := self class new.
	name := self nameFor: aNameOrClass.
	self
		do: [ :node | 
			node children
				do: [ :each | (self does: name match: each class name) ifTrue: [ result addNode: each ] ] ].
	^ result
]

{ #category : #querying }
GtRBNodeQuery >> // aNameOrClass [
	| name result |
	result := self class new.
	name := self nameFor: aNameOrClass.
	self
		do: [ :node | 
			node children
				do: [ :child | 
					child
						nodesDo: [ :each | (self does: name match: each class name) ifTrue: [ result addNode: each ] ] ] ].
	^ result
]

{ #category : #querying }
GtRBNodeQuery >> \ anObject [
	| result name |
	result := self class new.
	name := self nameFor: anObject.
	self
		do: [ :node | 
			name isInteger
				ifTrue: [ | current |
					current := node.
					name timesRepeat: [ current notNil ifTrue: [ current := current parent ] ].
					current notNil ifTrue: [ result addNode: current ] ]
				ifFalse: [ (self does: name match: node parent class name)
						ifTrue: [ result addNode: node parent ] ] ].
	^ result
]

{ #category : #querying }
GtRBNodeQuery >> \\ aName [
	| result name |
	result := self class new.
	name := self nameFor: aName.
	self
		do: [ :node | 
			| current found |
			current := node.
			found := false.
			[ current notNil
				ifTrue: [ found := self does: name match: current class name ].
			found or: [ current isNil ] ] whileFalse: [ current := current parent ].
			found ifTrue: [ result addNode: current ] ].
	^ result
]

{ #category : #accessing }
GtRBNodeQuery >> addNode: aNode [
	self items add: aNode
]

{ #category : #testing }
GtRBNodeQuery >> does: aName match: aString [
	^ aName isSymbol
		ifTrue: [ aName = aString ]
		ifFalse: [ aName isEmpty
				or: [ (aString findString: aName startingAt: 1 caseSensitive: false) > 0 ] ]
]

{ #category : #accessing }
GtRBNodeQuery >> gtNodesFor: aView [
	<gtView>
	^ aView columnedList
		priority: 40;
		title: 'Nodes';
		items: [ self asOrderedCollection
				asSortedCollection: [ :a :b | a start < b start or: [ a start = b start and: [ a stop > b stop ] ] ] ];
		column: 'Node' text: [ :each | each ];
		column: 'Position'
			text: [ :each | each start printString , '-' , each stop printString ]
]

{ #category : #accessing }
GtRBNodeQuery >> items [
	^ nodes ifNil: [ nodes := IdentitySet new ]
]

{ #category : #querying }
GtRBNodeQuery >> nameFor: aNameOrClass [
	^ aNameOrClass isBehavior
		ifTrue: [ aNameOrClass name ]
		ifFalse: [ aNameOrClass ]
]

{ #category : #accessing }
GtRBNodeQuery >> nodes: aCollection [
	nodes := aCollection
]

{ #category : #accessing }
GtRBNodeQuery >> select: aBlock [
	^ self class nodes: (self items select: aBlock)
]

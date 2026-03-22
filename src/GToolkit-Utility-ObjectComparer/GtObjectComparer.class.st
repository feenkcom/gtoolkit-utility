"
I compare two objects by inspecting their instance slots and I expose the differences as structured entries and a dedicated diff view.
"
Class {
	#name : #GtObjectComparer,
	#superclass : #Object,
	#instVars : [
		'parent',
		'values',
		'label'
	],
	#category : #'GToolkit-Utility-ObjectComparer-Core'
}

{ #category : #'instance creation' }
GtObjectComparer class >> compareAll: aCollection [
	^ self new values: 
		(aCollection
				collect: [ :each | 
					GtObjectComparerObjectValue new
						object: each ])
]

{ #category : #accessing }
GtObjectComparer >> childComparers [
	| slotNames |
	slotNames := ((values select: [ :o | o hasValue ])
			flatCollectAsSet: [ :each | each value class allInstVarNames ])
			asSortedCollection.
	^ slotNames
		collect: [ :eachSlotName | 
			| slotValues |
			slotValues := values
					collect: [ :eachValue | 
						(eachValue class ~= GtObjectComparerNoValue
							and: [ eachValue value class allInstVarNames includes: eachSlotName ])
							ifTrue: [ GtObjectComparerSlotValue new
									object: eachValue object;
									slotName: eachSlotName;
									value: (eachValue value instVarNamed: eachSlotName) ]
							ifFalse: [ GtObjectComparerNoValue new object: eachValue object ] ].
			GtObjectComparer new
				parent: self;
				values: slotValues;
				label: eachSlotName;
				yourself ]
]

{ #category : #ui }
GtObjectComparer >> gtComparersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Comparers';
		items: [ self childComparers ];
		column: 'Label' text: [ :each | each label ] width: 150;
		column: 'Values' text: [ :each | each values collect: #value ]
]

{ #category : #ui }
GtObjectComparer >> gtDisplayOn: stream [
	stream
		nextPutAll: 'Comparer: ';
		nextPutAll: self label;
		space.
	values gtDisplayOn: stream
]

{ #category : #ui }
GtObjectComparer >> gtParallelListFor: aView [
	<gtView>
	| tree |
	tree := aView columnedTree
			title: 'List';
			priority: 10;
			items: [ {self} ];
			children: [ :each | each childComparers ];
			column: 'Slot' text: [ :each | each label ].
	values do: [ :aValue | 
			tree
				column: aValue gtDisplayString
				do: [ :aColumn | 
					aColumn
						text: [ :each | each stringValueOfObject: aValue ];
						background: [ :cellValue :eachRow | 
							eachRow hasDifferences
								ifTrue: [ BrGlamorousColors failureBackgroundColor muchLighter ]
								ifFalse: [ Color transparent ] ] ] ].
	^ tree
]

{ #category : #ui }
GtObjectComparer >> gtValuesFor: aView [
	<gtView>
	values ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Values';
		items: [ values ];
		column: 'Value' text: [ :each | each value ];
		column: 'Object' text: [ :each | each object ]
]

{ #category : #testing }
GtObjectComparer >> hasDifferences [
	^ (values notEmpty and: [ values anySatisfy: [ :each | each value ~= values first value ] ])
]

{ #category : #testing }
GtObjectComparer >> hasParent [
	^ parent notNil
]

{ #category : #accessing }
GtObjectComparer >> label [
	^ label ifNil: [ 'object' ]
]

{ #category : #accessing }
GtObjectComparer >> label: aString [
	label := aString
]

{ #category : #accessing }
GtObjectComparer >> parent [
	^ parent
]

{ #category : #accessing }
GtObjectComparer >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
GtObjectComparer >> stringValueOfObject: anObject [
	| aValue index |
	index := self topMostParent values indexOf: anObject.
	aValue := values at: index.
	^ aValue value
]

{ #category : #private }
GtObjectComparer >> topMostParent [
	^ self hasParent 
		ifTrue: [ self parent topMostParent ] 
		ifFalse: [ self ]
]

{ #category : #accessing }
GtObjectComparer >> values [
	^ values ifNil: [ #() ]
]

{ #category : #accessing }
GtObjectComparer >> values: aCollection [
	values := aCollection asArray
]

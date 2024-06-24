Class {
	#name : #GtCounter,
	#superclass : #Object,
	#instVars : [
		'counts'
	],
	#category : #'GToolkit-Utility-Algorithms-Counter'
}

{ #category : #accessing }
GtCounter >> counts [
	^ counts
]

{ #category : #accessing }
GtCounter >> decrement: aKey [
	counts at: aKey put: (counts at: aKey ifAbsent: [ 1 ]) - 1
]

{ #category : #accessing }
GtCounter >> gtCountsFor: aView [
	<gtView>
	^ aView forward
		title: 'Counts';
		priority: 1;
		object: [ counts ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtCounter >> increment: aKey [
	counts at: aKey put: (counts at: aKey ifAbsent: [ 0 ]) + 1
]

{ #category : #accessing }
GtCounter >> initialize [
	super initialize.
	
	counts := Dictionary new.
]

{ #category : #accessing }
GtCounter >> keys [
	^ counts keys
]

{ #category : #accessing }
GtCounter >> mostFrequent [
	| max result |
	max := 0.
	result := nil.
	counts
		keysAndValuesDo: [ :aKey :aCount | 
			aCount > max
				ifTrue: [ max := aCount.
					result := aKey ] ].
	^ result
]

{ #category : #accessing }
GtCounter >> size [
	^ counts size
]

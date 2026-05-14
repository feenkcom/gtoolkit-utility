Class {
	#name : #GtQpsStackEntry,
	#superclass : #Object,
	#instVars : [
		'classname',
		'selector'
	],
	#category : #'GToolkit-Utility-SystemPerformance-Model'
}

{ #category : #accessing }
GtQpsStackEntry >> classname [
	^classname
]

{ #category : #accessing }
GtQpsStackEntry >> classname: anObject [
	classname := anObject
]

{ #category : #ui }
GtQpsStackEntry >> gtSourceCodeFor: aView [
	<gtView>

	^ aView forward
		title: 'Source';
		priority: 20;
		object: self method;
		view: #gtSourceCodeFor:
]

{ #category : #accessing }
GtQpsStackEntry >> method [

	^ (self class environment classOrTraitNamed: classname) lookupSelector: selector
]

{ #category : #printing }
GtQpsStackEntry >> printOn: aStream [

	(classname isNil and: [ selector isNil ]) ifTrue:
		[ ^ super printOn: aStream ].
	
	
	aStream
		<< classname asString;
		<< '>>';
		<< selector asString.
]

{ #category : #accessing }
GtQpsStackEntry >> selector [
	^selector
]

{ #category : #accessing }
GtQpsStackEntry >> selector: anObject [
	selector := anObject
]

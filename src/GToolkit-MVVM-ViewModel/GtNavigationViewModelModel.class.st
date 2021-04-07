Class {
	#name : #GtNavigationViewModelModel,
	#superclass : #Object,
	#instVars : [
		'name',
		'model',
		'children'
	],
	#category : #'GToolkit-MVVM-ViewModel-Generator'
}

{ #category : #adding }
GtNavigationViewModelModel >> addChild: aGtNavigationViewModelModel [
	(self hasChild: aGtNavigationViewModelModel)
		ifTrue: [ ^ self ].

	children add: aGtNavigationViewModelModel
]

{ #category : #accessing }
GtNavigationViewModelModel >> children [
	^ children
]

{ #category : #accessing }
GtNavigationViewModelModel >> children: anObject [
	children := anObject
]

{ #category : #'gt-extension' }
GtNavigationViewModelModel >> gtTreeFor: aView [
	<gtView>

	^ aView tree
		title: 'Children';
		priority: 1;
		items: [ { self } ];
		children: [ :anItem | anItem children ];
		expandAll
]

{ #category : #testing }
GtNavigationViewModelModel >> hasChild: aChild [
	(children includes: aChild)
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #initialization }
GtNavigationViewModelModel >> initialize [
	super initialize.
	
	children := OrderedCollection new
]

{ #category : #testing }
GtNavigationViewModelModel >> isForMany [
	^ self isForOne not
]

{ #category : #testing }
GtNavigationViewModelModel >> isForOne [
	^ false
]

{ #category : #accessing }
GtNavigationViewModelModel >> model [
	^ model
]

{ #category : #accessing }
GtNavigationViewModelModel >> model: anObject [
	model := anObject asSymbol
]

{ #category : #accessing }
GtNavigationViewModelModel >> name [
	^ name
]

{ #category : #accessing }
GtNavigationViewModelModel >> name: anObject [
	name := anObject
]

{ #category : #printing }
GtNavigationViewModelModel >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."
	
	self isForOne
		ifTrue: [ aStream nextPutAll: 'ForOne' ]
		ifFalse: [ aStream nextPutAll: 'ForMany' ].
	
	aStream
		nextPutAll: ' model: ';
		print: model.
	aStream
		nextPutAll: ' name: ';
		print: name
]

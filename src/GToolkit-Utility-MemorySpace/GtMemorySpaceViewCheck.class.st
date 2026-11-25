"
I check that one view of an object can be computed without errors.

I build the view, follow forward views, expand trees a few levels, and compute all rows and cells through the declarative specification of the view, which computes them synchronously. Errors are collected instead of signalled: errors when building the view or its items, and the cells whose computation failed.
"
Class {
	#name : #GtMemorySpaceViewCheck,
	#superclass : #Object,
	#instVars : [
		'object',
		'selector',
		'title',
		'kind',
		'rowsCount',
		'errors'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceViewCheck class >> object: anObject selector: aSelector [
	^ self new
		setObject: anObject selector: aSelector;
		check;
		yourself
]

{ #category : #private }
GtMemorySpaceViewCheck >> addError: anException [
	errors add: anException description
]

{ #category : #private }
GtMemorySpaceViewCheck >> addErrorsIn: aComputedItem [
	"Add the errors of the cells of rows computed by a declarative view; 
	rows are dictionaries (with String keys) and arrays"

	aComputedItem isDictionary
		ifTrue: [ (aComputedItem at: 'valueTypeName' ifAbsent: [ nil ]) = 'errorValue'
				ifTrue: [ errors add: (aComputedItem at: 'itemText' ifAbsent: [ 'error' ]) asString ].
			aComputedItem do: [ :each | self addErrorsIn: each ].
			^ self ].
	(aComputedItem isCollection and: [ aComputedItem isString not ])
		ifTrue: [ aComputedItem do: [ :each | self addErrorsIn: each ] ]
]

{ #category : #checking }
GtMemorySpaceViewCheck >> check [
	| aView aSpecification |
	errors := OrderedCollection new.
	rowsCount := 0.
	aView := [ object perform: selector with: GtPhlowEmptyView new ]
			on: Error
			do: [ :anError | ^ self addError: anError ].
	title := aView title asString.
	[ aView isKindOf: GtPhlowForwarderView ]
		whileTrue: [ aView := aView computeForwardedView ].
	(aView isKindOf: GtPhlowViewWithError)
		ifTrue: [ ^ self addError: aView exception ].
	(aView isKindOf: GtPhlowEmptyView)
		ifTrue: [ kind := #empty.
			^ self ].
	(aView respondsTo: #expandUpTo:)
		ifTrue: [ aView expandUpTo: self expansionLevels ].

	aSpecification := [ aView asGtDeclarativeView ]
			on: Error
			do: [ :anError | ^ self addError: anError ].
	kind := aSpecification class name.
	(aSpecification respondsTo: #retrieveTotalItemsCount) ifFalse: [ ^ self ].
	[ rowsCount := aSpecification retrieveTotalItemsCount.
	self addErrorsIn: (aSpecification retrieveItems: rowsCount fromIndex: 1) ]
		on: Error
		do: [ :anError | self addError: anError ]
]

{ #category : #accessing }
GtMemorySpaceViewCheck >> errors [
	^ errors
]

{ #category : #private }
GtMemorySpaceViewCheck >> expansionLevels [
	"Trees are expanded, so that their children are also computed"

	^ 3
]

{ #category : #testing }
GtMemorySpaceViewCheck >> hasErrors [
	^ errors notEmpty
]

{ #category : #testing }
GtMemorySpaceViewCheck >> isEmptyView [
	^ kind = #empty
]

{ #category : #accessing }
GtMemorySpaceViewCheck >> kind [
	"The kind of computed view, for example #empty or the class of its declarative specification"

	^ kind
]

{ #category : #accessing }
GtMemorySpaceViewCheck >> object [
	^ object
]

{ #category : #printing }
GtMemorySpaceViewCheck >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: selector;
		nextPutAll: ': '.
	self hasErrors
		ifTrue: [ aStream
				print: errors size;
				nextPutAll: ' errors' ]
		ifFalse: [ aStream
				print: rowsCount;
				nextPutAll: ' rows' ].
	aStream nextPut: $)
]

{ #category : #accessing }
GtMemorySpaceViewCheck >> rowsCount [
	"The number of top level rows"

	^ rowsCount
]

{ #category : #accessing }
GtMemorySpaceViewCheck >> selector [
	^ selector
]

{ #category : #initialization }
GtMemorySpaceViewCheck >> setObject: anObject selector: aSelector [
	object := anObject.
	selector := aSelector
]

{ #category : #accessing }
GtMemorySpaceViewCheck >> title [
	^ title ifNil: [ selector asString ]
]

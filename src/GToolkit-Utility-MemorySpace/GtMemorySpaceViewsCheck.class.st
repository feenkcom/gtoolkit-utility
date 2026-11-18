"
I check that the views of an object can be computed without errors, so that examples can catch broken reports. I check the views defined by the class of the object and its superclasses below Object, each with a {{gtClass:GtMemorySpaceViewCheck}}.

Use #forObject: and then #viewChecksWithErrors or #errorsDescription.
"
Class {
	#name : #GtMemorySpaceViewsCheck,
	#superclass : #Object,
	#instVars : [
		'object',
		'viewChecks'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceViewsCheck class >> forObject: anObject [
	^ self new
		setObject: anObject;
		check;
		yourself
]

{ #category : #checking }
GtMemorySpaceViewsCheck >> check [
	viewChecks := self viewSelectors asArray
			collect: [ :aSelector | GtMemorySpaceViewCheck object: object selector: aSelector ]
]

{ #category : #accessing }
GtMemorySpaceViewsCheck >> errorsDescription [
	"A description of the errors, for failing assertions"

	^ String
		streamContents: [ :aStream | 
			aStream
				nextPutAll: 'Views with errors of ';
				print: object class.
			self viewChecksWithErrors
				do: [ :aViewCheck | 
					aStream
						nextPutAll: '; ';
						print: aViewCheck selector;
						nextPutAll: ': ';
						nextPutAll: aViewCheck errors first ] ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceViewsCheck >> gtViewChecksFor: aView [
	<gtView>
	viewChecks ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Views';
		priority: 10;
		items: [ viewChecks ];
		column: 'View'
			text: [ :each | each title ]
			width: 150;
		column: 'Selector'
			text: [ :each | each selector ]
			width: 220;
		column: 'Kind'
			text: [ :each | each kind ifNil: [ '' ] ]
			width: 260;
		column: 'Rows'
			text: [ :each | each rowsCount ]
			width: 50;
		column: 'Errors'
			text: [ :each | each hasErrors ifTrue: [ each errors first ] ifFalse: [ '' ] ]
]

{ #category : #testing }
GtMemorySpaceViewsCheck >> hasErrors [
	^ viewChecks anySatisfy: [ :each | each hasErrors ]
]

{ #category : #accessing }
GtMemorySpaceViewsCheck >> object [
	^ object
]

{ #category : #printing }
GtMemorySpaceViewsCheck >> printOn: aStream [
	super printOn: aStream.
	viewChecks ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		print: viewChecks size;
		nextPutAll: ' views, ';
		print: self viewChecksWithErrors size;
		nextPutAll: ' with errors)'
]

{ #category : #initialization }
GtMemorySpaceViewsCheck >> setObject: anObject [
	object := anObject
]

{ #category : #accessing }
GtMemorySpaceViewsCheck >> viewCheckFor: aSelector [
	^ viewChecks detect: [ :each | each selector = aSelector ] ifNone: [ nil ]
]

{ #category : #accessing }
GtMemorySpaceViewsCheck >> viewChecks [
	^ viewChecks
]

{ #category : #accessing }
GtMemorySpaceViewsCheck >> viewChecksWithErrors [
	^ viewChecks select: [ :each | each hasErrors ]
]

{ #category : #accessing }
GtMemorySpaceViewsCheck >> viewSelectors [
	"The views defined by the class of the object and its superclasses below Object"

	| selectors generalClasses |
	selectors := OrderedCollection new.
	generalClasses := Object withAllSuperclasses , {Object}.
	object class withAllSuperclasses
		do: [ :aClass | 
			(generalClasses includes: aClass)
				ifFalse: [ aClass methods
						do: [ :aMethod | 
							((aMethod hasPragmaNamed: #gtView) and: [ aMethod numArgs = 1 ])
								ifTrue: [ selectors addIfNotPresent: aMethod selector ] ] ] ].
	^ selectors
]

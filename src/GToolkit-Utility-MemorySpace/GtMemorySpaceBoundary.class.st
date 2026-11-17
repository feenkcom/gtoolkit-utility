"
I define which objects belong to the memory space estimated by a {{gtClass:GtMemorySpaceEstimator}}.

The estimator stops at instances of my stop classes (and their subclasses): it does not count them, and does not follow their references. Immediate objects, nil, booleans and classes are never counted.

I also hold tags ({{gtClass:GtMemorySpaceTag}}), for example to track the size of all strings: the estimator then reports the size of tagged objects separately in the {{gtClass:GtMemorySpaceEstimate}}. An object has at most one tag, the first tag that matches its class. Tags are added with #addTag:, or with the shortcuts #tag:instancesOf: and #tag:classesMatching:.

All decisions are made per class, so the estimator can cache them; this keeps the traversal fast.

Use #default for a boundary that stops at code entities (classes, methods, variables, symbols) and processes, which are shared by all objects.
"
Class {
	#name : #GtMemorySpaceBoundary,
	#superclass : #Object,
	#instVars : [
		'stopClasses',
		'tags'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceBoundary class >> default [
	"A boundary that stops at code entities and processes, which are shared by all objects"

	^ self new
		stopAtCodeEntities;
		stopAtProcesses;
		yourself
]

{ #category : #configuration }
GtMemorySpaceBoundary >> addTag: aTag [
	"Track the size of the objects with aTag (see GtMemorySpaceTag). 
	An object has at most one tag: the first added tag that matches its class."

	tags add: aTag
]

{ #category : #copying }
GtMemorySpaceBoundary >> copyStoppingAtInstancesOf: aCollectionOfClasses [
	"A copy of me that also stops at the instances of these classes"

	^ self copy
		stopAtInstancesOf: aCollectionOfClasses;
		yourself
]

{ #category : #'gt - extensions' }
GtMemorySpaceBoundary >> gtViewStopClassesFor: aView [
	<gtView>
	^ aView list
		title: 'Stop classes';
		priority: 10;
		items: [ stopClasses ];
		itemText: [ :each | each name ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceBoundary >> gtViewTagsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Tags';
		priority: 20;
		items: [ tags ];
		column: 'Tag'
			text: [ :each | each name ]
			width: 120;
		column: 'Classes' text: [ :each | each description ]
]

{ #category : #initialization }
GtMemorySpaceBoundary >> initialize [
	super initialize.
	stopClasses := OrderedCollection new.
	tags := OrderedCollection new
]

{ #category : #copying }
GtMemorySpaceBoundary >> postCopy [
	super postCopy.
	stopClasses := stopClasses copy.
	tags := tags copy
]

{ #category : #testing }
GtMemorySpaceBoundary >> shouldStopAtClass: aClass [
	(aClass isImmediateClass or: [ aClass isMeta ]) ifTrue: [ ^ true ].
	(aClass == UndefinedObject or: [ aClass == True or: [ aClass == False ] ])
		ifTrue: [ ^ true ].
	^ stopClasses anySatisfy: [ :each | aClass includesBehavior: each ]
]

{ #category : #configuration }
GtMemorySpaceBoundary >> stopAtCodeEntities [
	"Classes, methods, variables and symbols are shared by all objects"

	self
		stopAtInstancesOf: {Behavior.
				CompiledCode.
				LiteralVariable.
				Symbol}
]

{ #category : #configuration }
GtMemorySpaceBoundary >> stopAtInstancesOf: aCollectionOfClasses [
	"Do not count instances of these classes and of their subclasses, and do not follow their references"

	stopClasses addAll: aCollectionOfClasses
]

{ #category : #configuration }
GtMemorySpaceBoundary >> stopAtProcesses [
	self
		stopAtInstancesOf: {Process.
				Context}
]

{ #category : #accessing }
GtMemorySpaceBoundary >> stopClasses [
	^ stopClasses
]

{ #category : #configuration }
GtMemorySpaceBoundary >> tag: aName classesMatching: aBlock [
	"Track the size of instances of the classes for which aBlock answers true under aName.
	aBlock is evaluated once per class."

	self addTag: (GtMemorySpaceTag named: aName classesMatching: aBlock)
]

{ #category : #configuration }
GtMemorySpaceBoundary >> tag: aName instancesOf: aCollectionOfClasses [
	"Track the size of instances of these classes and of their subclasses under aName"

	self addTag: (GtMemorySpaceTag named: aName instancesOf: aCollectionOfClasses)
]

{ #category : #accessing }
GtMemorySpaceBoundary >> tagForClass: aClass [
	"Answer the tag of instances of aClass, or nil. The first matching tag wins."

	^ tags detect: [ :each | each matchesClass: aClass ] ifNone: [ nil ]
]

{ #category : #accessing }
GtMemorySpaceBoundary >> tagNames [
	^ tags collect: [ :each | each name ]
]

{ #category : #accessing }
GtMemorySpaceBoundary >> tags [
	^ tags
]

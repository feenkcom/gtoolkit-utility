"
I declare how the memory space of a subject is estimated: its categories ({{gtClass:GtMemorySpaceCategory}}), its roots with their attributions ({{gtClass:GtMemorySpaceAttribution}}), and the boundary ({{gtClass:GtMemorySpaceBoundary}}) where walks stop.

I am only a declaration, and can be inspected before estimating anything. A {{gtClass:GtMemorySpaceEstimation}} runs me on a subject.

Subclasses declare their categories (see #category:named:description:), their attributions, their roots (see #rootsOf:do:) and their boundary (see #newBoundary).
"
Class {
	#name : #GtMemorySpaceDefinition,
	#superclass : #Object,
	#instVars : [
		'categories'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceDefinition >> categories [
	"All declared categories, in the order of their declaration"

	^ categories values
]

{ #category : #accessing }
GtMemorySpaceDefinition >> category: aKey [
	"A declared category"

	^ categories at: aKey
]

{ #category : #declaring }
GtMemorySpaceDefinition >> category: aKey named: aName description: aDescription [
	"Declare a category, referred to later with #category:"

	categories
		at: aKey
		put: (GtMemorySpaceCategory
				key: aKey
				name: aName
				description: aDescription)
]

{ #category : #estimating }
GtMemorySpaceDefinition >> estimate: aSubject [
	"Estimate the memory space of aSubject"

	^ (GtMemorySpaceEstimation definition: self subject: aSubject)
		run;
		yourself
]

{ #category : #estimating }
GtMemorySpaceDefinition >> estimateRootsOf: aSubject with: anEstimator into: anEstimate [
	"Estimate the roots of aSubject with their attributions. 
	Subclasses can also record the memory added by each root."

	self
		rootsOf: aSubject
		do: [ :aRoot :anAttribution | 
			anAttribution
				estimate: aRoot
				with: anEstimator
				into: anEstimate ]
]

{ #category : #accessing }
GtMemorySpaceDefinition >> expectedObjectsFor: aSubject [
	"A rough estimate of the number of objects of aSubject, to presize the set of visited objects. 
	0 means no estimate."

	^ 0
]

{ #category : #'gt - extensions' }
GtMemorySpaceDefinition >> gtViewAttributionsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Attributions';
		priority: 20;
		items: [ self rules ];
		children: [ :each | each rules ];
		column: 'Part'
			text: [ :each | each label ]
			width: 250;
		column: 'Attribution' text: [ :each | each summary ];
		send: [ :each | each attribution ]
]

{ #category : #'gt - extensions' }
GtMemorySpaceDefinition >> gtViewBoundaryFor: aView [
	<gtView>
	^ aView forward
		title: 'Boundary';
		priority: 30;
		object: [ self newBoundary ];
		view: #gtViewStopClassesFor:
]

{ #category : #'gt - extensions' }
GtMemorySpaceDefinition >> gtViewBoundaryTagsFor: aView [
	<gtView>
	^ aView forward
		title: 'Tags';
		priority: 35;
		object: [ self newBoundary ];
		view: #gtViewTagsFor:
]

{ #category : #'gt - extensions' }
GtMemorySpaceDefinition >> gtViewCategoriesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Categories';
		priority: 10;
		items: [ self categories ];
		column: 'Category'
			text: [ :each | each name ]
			width: 200;
		column: 'Description' text: [ :each | each description ]
]

{ #category : #initialization }
GtMemorySpaceDefinition >> initialize [
	super initialize.
	categories := OrderedDictionary new
]

{ #category : #accessing }
GtMemorySpaceDefinition >> newBoundary [
	"Where the walks stop, and which objects are tagged"

	^ GtMemorySpaceBoundary default
]

{ #category : #accessing }
GtMemorySpaceDefinition >> rootsOf: aSubject do: aBlock [
	"Evaluate aBlock with each root of aSubject and the attribution of that root"

	self subclassResponsibility
]

{ #category : #accessing }
GtMemorySpaceDefinition >> rules [
	"The rules for each kind of root (GtMemorySpaceRule), for views"

	^ self subclassResponsibility
]

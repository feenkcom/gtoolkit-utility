"
I am a definition made of ordered groups of roots ({{gtClass:GtMemorySpaceRootGroup}}), configured without writing a class, for example in a snippet:

```
(GtMemorySpaceRootsDefinition new
	roots: 'GT Book' are: [ { aDatabase } ];
	rootGroup: GtMemorySpaceRootGroup classSideState;
	rootGroup: GtMemorySpaceRootGroup globals;
	stopAtInstancesOf: { BlSpace };
	tag: #string instancesOf: { ByteString. WideString };
	yourself) estimate
```

I describe where memory is held, not how objects are built, so I keep working when object models change. Categories are created when first needed, for example one per package.

The estimate records the memory added by every root ({{gtClass:GtMemorySpaceRootEstimate}}), so the largest roots and groups can be seen after estimating.
"
Class {
	#name : #GtMemorySpaceRootsDefinition,
	#superclass : #GtMemorySpaceDefinition,
	#instVars : [
		'rootGroups',
		'boundary',
		'expectedObjectsCount'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceRootsDefinition >> boundary [
	^ boundary
]

{ #category : #declaring }
GtMemorySpaceRootsDefinition >> boundary: aBoundary [
	"Use aBoundary instead of the default one, which stops at code entities and processes"

	boundary := aBoundary
]

{ #category : #declaring }
GtMemorySpaceRootsDefinition >> categoryNamed: aName [
	"The category with the name, created when first needed"

	| aKey |
	aKey := aName asSymbol.
	^ (categories at: aKey ifAbsent: [ nil ])
		ifNil: [ categories
				at: aKey
				put: (GtMemorySpaceCategory
						key: aKey
						name: aName asString
						description: '') ]
]

{ #category : #copying }
GtMemorySpaceRootsDefinition >> copyStoppingAtInstancesOf: aCollectionOfClasses [
	"A copy of me, with the same groups and categories, whose walks also stop at instances of these classes"

	^ self copy
		boundary: (boundary copyStoppingAtInstancesOf: aCollectionOfClasses);
		yourself
]

{ #category : #estimating }
GtMemorySpaceRootsDefinition >> estimate [
	"Estimate my roots"

	^ self estimate: nil
]

{ #category : #estimating }
GtMemorySpaceRootsDefinition >> estimateRootsOf: aSubject with: anEstimator into: anEstimate [
	"Estimate the groups in order, each with its boundary, and record the memory added by each root"

	rootGroups
		do: [ :aGroup | 
			| aGroupBoundary |
			aGroupBoundary := aGroup boundaryWithin: boundary.
			anEstimator boundary == aGroupBoundary
				ifFalse: [ anEstimator boundary: aGroupBoundary ].
			aGroup
				rootsDo: [ :aRoot | 
					| bytesBefore objectsBefore addedBytes |
					bytesBefore := anEstimate totalBytes.
					objectsBefore := anEstimate totalObjectsCount.
					aGroup
						estimateRoot: aRoot
						in: self
						with: anEstimator
						into: anEstimate.
					addedBytes := anEstimate totalBytes - bytesBefore.
					addedBytes > 0
						ifTrue: [ anEstimate
								addRootEstimate: (GtMemorySpaceRootEstimate
										root: aRoot
										group: aGroup
										category: (aGroup categoryFor: aRoot in: self)
										bytes: addedBytes
										objectsCount: anEstimate totalObjectsCount - objectsBefore) ] ] ]
]

{ #category : #declaring }
GtMemorySpaceRootsDefinition >> expectedObjects: aNumber [
	"Presize the set of visited objects for large walks"

	expectedObjectsCount := aNumber
]

{ #category : #accessing }
GtMemorySpaceRootsDefinition >> expectedObjectsFor: aSubject [
	^ expectedObjectsCount
]

{ #category : #'gt - extensions' }
GtMemorySpaceRootsDefinition >> gtViewRootGroupsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Root groups';
		priority: 10;
		items: [ rootGroups asArray ];
		column: 'Group'
			text: [ :each | each label ]
			width: 200;
		column: 'Attribution' text: [ :each | each summary ]
]

{ #category : #initialization }
GtMemorySpaceRootsDefinition >> initialize [
	super initialize.
	rootGroups := OrderedCollection new.
	boundary := GtMemorySpaceBoundary default.
	expectedObjectsCount := 0
]

{ #category : #accessing }
GtMemorySpaceRootsDefinition >> newBoundary [
	^ boundary
]

{ #category : #declaring }
GtMemorySpaceRootsDefinition >> rootGroup: aRootGroup [
	"Add a group of roots. It is estimated after the groups added before it."

	aRootGroup category
		ifNil: [ aRootGroup category: (self categoryNamed: aRootGroup label) ].
	rootGroups add: aRootGroup.
	^ aRootGroup
]

{ #category : #accessing }
GtMemorySpaceRootsDefinition >> rootGroups [
	^ rootGroups
]

{ #category : #declaring }
GtMemorySpaceRootsDefinition >> roots: aLabel are: aBlockOrCollection [
	"Add a group of roots, attributed to a category with the same name.
	aBlockOrCollection answers GtMemorySpaceRoot objects or plain objects."

	^ self
		rootGroup: (GtMemorySpaceRootGroup label: aLabel roots: aBlockOrCollection)
]

{ #category : #accessing }
GtMemorySpaceRootsDefinition >> rootsOf: aSubject do: aBlock [
	"My roots do not depend on a subject"

	rootGroups
		do: [ :aGroup | 
			aGroup
				rootsDo: [ :aRoot | aBlock value: aRoot object value: (aGroup attributionFor: aRoot in: self) ] ]
]

{ #category : #accessing }
GtMemorySpaceRootsDefinition >> rules [
	^ rootGroups asArray collect: [ :each | each rule ]
]

{ #category : #declaring }
GtMemorySpaceRootsDefinition >> stopAtInstancesOf: aCollectionOfClasses [
	boundary stopAtInstancesOf: aCollectionOfClasses
]

{ #category : #declaring }
GtMemorySpaceRootsDefinition >> tag: aTagName classesMatching: aBlock [
	boundary tag: aTagName classesMatching: aBlock
]

{ #category : #declaring }
GtMemorySpaceRootsDefinition >> tag: aTagName instancesOf: aCollectionOfClasses [
	boundary tag: aTagName instancesOf: aCollectionOfClasses
]

{ #category : #declaring }
GtMemorySpaceRootsDefinition >> tagEachOf: aCollectionOfClasses [
	"Tag the instances of each class with the name of the class, 
	for example to see who holds the instances of the largest classes of a space tally"

	aCollectionOfClasses
		do: [ :aClass | boundary tag: aClass name instancesOf: {aClass} ]
]

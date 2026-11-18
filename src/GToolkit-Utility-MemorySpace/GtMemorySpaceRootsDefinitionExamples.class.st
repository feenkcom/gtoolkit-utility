"
I show how a {{gtClass:GtMemorySpaceRootsDefinition}} estimates groups of roots ({{gtClass:GtMemorySpaceRootGroup}}), in order, and records what each root adds.

My class variable and class-side instance variable are used to show the roots of the class-side state of classes.
"
Class {
	#name : #GtMemorySpaceRootsDefinitionExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#classVars : [
		'ExampleClassVariable'
	],
	#classInstVars : [
		'exampleClassSideValue'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceRootsDefinitionExamples class >> exampleClassSideValue: anObject [
	exampleClassSideValue := anObject
]

{ #category : #accessing }
GtMemorySpaceRootsDefinitionExamples class >> exampleClassVariable: anObject [
	ExampleClassVariable := anObject
]

{ #category : #private }
GtMemorySpaceRootsDefinitionExamples >> assertViewsOf: anObject [
	"Assert that all views of anObject can be computed without errors"

	| aCheck |
	aCheck := GtMemorySpaceViewsCheck forObject: anObject.
	self assert: aCheck hasErrors not description: [ aCheck errorsDescription ].
	^ aCheck
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> classSideStateRoots [
	"The class-side state of classes: class variables and class-side instance variables, 
	attributed to the package of the class. Slots of the kernel, like those added by traits, are not state."

	<gtExample>
	<return: #Array>
	| first second roots |
	first := 'class variable value' copy.
	second := 'class-side value' copy.
	self class
		exampleClassVariable: first;
		exampleClassSideValue: second.
	[ roots := (GtMemorySpaceRootGroup classSideStateOf: {self class}) roots ]
		ensure: [ self class
				exampleClassVariable: nil;
				exampleClassSideValue: nil ].

	self
		assert: (roots collect: [ :each | each label ]) asSet
		equals: {self class name , ' class var ExampleClassVariable'.
				self class name , ' class-side exampleClassSideValue'} asSet.
	self
		assert: (roots collect: [ :each | each object ]) asIdentitySet
		equals: {first.
				second} asIdentitySet.
	self
		assert: (roots collect: [ :each | each categoryName ]) asSet
		equals: {self class package name} asSet.
	^ roots
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> definitionWithRootGroups [
	"A definition made of groups of roots, declared without writing a class.
	Each group gets a category with its name."

	<gtExample>
	<return: #GtMemorySpaceRootsDefinition>
	| shared definition |
	shared := 'shared' copy.
	definition := GtMemorySpaceRootsDefinition new.
	definition
		roots: 'First' are: {Array with: shared};
		roots: 'Second' are: [ {Array with: shared with: 'own' copy} ].

	self
		assert: (definition rootGroups collect: [ :each | each label ]) asArray
		equals: #('First' 'Second').
	self
		assert: (definition categories collect: [ :each | each name ]) asArray
		equals: #('First' 'Second').
	self assert: definition rules size equals: 2.
	self assert: definition rootGroups first roots size equals: 1.
	self assertViewsOf: definition.
	^ definition
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> estimateOfRootGroups [
	"Groups are estimated in order: an object reachable from both groups is counted in the first.
	The estimate records what each root adds."

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| shared own first second definition estimate groups |
	shared := 'shared' copy.
	own := 'own' copy.
	first := Array with: shared.
	second := Array with: shared with: own.
	definition := GtMemorySpaceRootsDefinition new
			roots: 'First' are: {first};
			roots: 'Second' are: [ {second} ];
			yourself.

	estimate := definition estimate estimate.

	self
		assert: (estimate bytesOf: (definition categoryNamed: 'First'))
		equals: first sizeInMemory + shared sizeInMemory.
	self
		assert: (estimate bytesOf: (definition categoryNamed: 'Second'))
		equals: second sizeInMemory + own sizeInMemory.
	self assert: estimate rootEstimates size equals: 2.
	self
		assert: (estimate rootEstimates inject: 0 into: [ :aSum :each | aSum + each bytes ])
		equals: estimate totalBytes.
	self assert: estimate rootEstimates first root object identicalTo: first.
	self assert: estimate rootEstimates first objectsCount equals: 2.

	groups := estimate rootGroupEstimates.
	self
		assert: (groups collect: [ :each | each label ]) asArray
		equals: #('First' 'Second').
	self assert: groups second bytes equals: second sizeInMemory + own sizeInMemory.
	self assertViewsOf: estimate.
	^ estimate
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> globalsRoots [
	"The globals that are not classes"

	<gtExample>
	<return: #Array>
	| roots |
	roots := GtMemorySpaceRootGroup globals roots.

	self assert: roots notEmpty.
	self assert: (roots noneSatisfy: [ :each | each object isBehavior ]).
	self assert: (roots anySatisfy: [ :each | each label = 'global Smalltalk' ]).
	^ roots
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> groupWithItsOwnStopClasses [
	"A group can stop at more classes than the definition. 
	What it does not count is counted by the groups that follow."

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| shared text first second definition estimate |
	shared := Point x: 1 y: 2.
	text := 'text' copy.
	first := Array with: shared with: text.
	second := Array with: shared.
	definition := GtMemorySpaceRootsDefinition new.
	(definition roots: 'First' are: {first}) stopAtInstancesOf: {Point}.
	definition roots: 'Second' are: {second}.

	estimate := definition estimate estimate.

	self
		assert: (estimate bytesOf: (definition categoryNamed: 'First'))
		equals: first sizeInMemory + text sizeInMemory.
	self
		assert: (estimate bytesOf: (definition categoryNamed: 'Second'))
		equals: second sizeInMemory + shared sizeInMemory.
	self assert: (definition rootGroups first summary includesSubstring: 'Point').
	self deny: (definition boundary shouldStopAtClass: Point).
	self assertViewsOf: definition.
	^ estimate
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> retentionOfInstances [
	"The memory reached through the instances of a class, split into what only they keep alive (retained) 
	and what other objects also reach (shared), with the roots that share it.
	All instances in the image are measured: instances kept by earlier runs of this example, 
	which the roots do not reach, are retained too."

	<gtExample>
	<return: #GtMemorySpaceRetention>
	| kept shared contents holder root other definition retention ownSize classRetention sharing |
	kept := 'kept only through the holder' copy.
	shared := 'also held by the root' copy.
	contents := Array with: kept with: shared.
	holder := GtMemorySpaceRetentionExampleHolder new contents: contents.
	root := Array with: holder with: shared.
	other := Array with: 'not shared' copy.
	definition := GtMemorySpaceRootsDefinition new
			roots: 'Roots'
				are: {root.
						other};
			yourself.

	retention := GtMemorySpaceRetention
			estimation: definition estimate
			stoppingAtInstancesOf: {GtMemorySpaceRetentionExampleHolder}.

	ownSize := holder sizeInMemory + contents sizeInMemory + kept sizeInMemory.
	self assert: retention sharedBytes equals: shared sizeInMemory.
	self assert: retention retainedBytes >= ownSize.
	self
		assert: retention reachedBytes
		equals: retention retainedBytes + shared sizeInMemory.
	self assert: retention instancesCount >= 1.
	self assert: retention instancesBytes >= holder sizeInMemory.	"only the first root shares memory with the holders"
	sharing := retention sharingRootEstimates.
	self assert: sharing size equals: 1.
	self assert: sharing first root object identicalTo: root.
	self assert: sharing first bytes equals: shared sizeInMemory.

	classRetention := retention classRetentions first.
	self
		assert: classRetention retainedClass
		equals: GtMemorySpaceRetentionExampleHolder.
	self assert: classRetention retainedBytes equals: retention retainedBytes.
	self assertViewsOf: retention.
	self assertViewsOf: classRetention.
	^ retention
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> rootEstimatesAreAdded [
	"Adding estimates also adds their root estimates"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| first second combined |
	first := self estimateOfRootGroups.
	second := self estimateOfRootGroups.
	combined := GtMemorySpaceEstimate new
			addEstimate: first;
			addEstimate: second;
			yourself.

	self assert: combined rootEstimates size equals: 4.
	self assert: combined totalBytes equals: first totalBytes + second totalBytes.
	^ combined
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> rootGroupWithAttribution [
	"A group can split each root with an attribution, instead of using a single category"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| key value association definition estimate |
	key := 'key' copy.
	value := 'value' copy.
	association := key -> value.
	definition := GtMemorySpaceRootsDefinition new.
	(definition roots: 'Associations' are: {association})
		attribution: (GtMemorySpaceSlotsAttribution new
				objectCategory: (definition categoryNamed: 'Associations');
				slot: #value to: (definition categoryNamed: 'Values');
				yourself).

	estimate := definition estimate estimate.

	self
		assert: (estimate bytesOf: (definition categoryNamed: 'Associations'))
		equals: association sizeInMemory + key sizeInMemory.
	self
		assert: (estimate bytesOf: (definition categoryNamed: 'Values'))
		equals: value sizeInMemory.
	self assert: estimate rootEstimates first category isNil.
	self
		assert: estimate rootEstimates first categoryName
		equals: 'several categories'.
	self assertViewsOf: estimate.
	^ estimate
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> rootsNamingTheirCategory [
	"Roots can name their category; categories are created when first needed"

	<gtExample>
	<return: #GtMemorySpaceEstimation>
	| alpha beta definition estimation |
	alpha := 'alpha' copy.
	beta := 'beta' copy.
	definition := GtMemorySpaceRootsDefinition new
			roots: 'Named'
				are: {GtMemorySpaceRoot
							label: 'alpha root'
							object: alpha
							categoryName: 'Alpha'.
						GtMemorySpaceRoot
							label: 'beta root'
							object: beta
							categoryName: 'Beta'};
			yourself.

	estimation := definition estimate.

	self
		assert: (estimation estimate bytesOf: (definition categoryNamed: 'Alpha'))
		equals: alpha sizeInMemory.
	self
		assert: (estimation estimate bytesOf: (definition categoryNamed: 'Beta'))
		equals: beta sizeInMemory.
	self
		assert: (estimation estimate bytesOf: (definition categoryNamed: 'Named'))
		equals: 0.
	self
		assert: (estimation estimate rootEstimates collect: [ :each | each categoryName ])
				asArray
		equals: #('Alpha' 'Beta').
	self
		assert: (estimation estimate rootEstimates collect: [ :each | each label ]) asArray
		equals: #('alpha root' 'beta root').
	self assertViewsOf: estimation.
	^ estimation
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> taggingClasses [
	"Tagging classes, for example the largest classes of a space tally, shows who holds their instances"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| text definition estimate |
	text := 'text' copy.
	definition := GtMemorySpaceRootsDefinition new
			roots: 'Texts' are: {Array with: text};
			roots: 'Points' are: {Array with: (Point x: 1 y: 2)};
			tagEachOf: {ByteString.
					Point};
			yourself.

	estimate := definition estimate estimate.

	self assert: (estimate bytesOfTag: #ByteString) equals: text sizeInMemory.
	self
		assert: ((estimate tagEstimateFor: #ByteString)
				bytesOfCategory: (definition categoryNamed: 'Texts'))
		equals: text sizeInMemory.
	self
		assert: ((estimate tagEstimateFor: #Point)
				bytesOfCategory: (definition categoryNamed: 'Points')) > 0.
	self assertViewsOf: estimate.
	^ estimate
]

{ #category : #examples }
GtMemorySpaceRootsDefinitionExamples >> viewsOfRootObjectsWork [
	"The views of roots, groups and their estimates can be computed, also when empty"

	<gtExample>
	<return: #Array>
	| estimate objects |
	estimate := self estimateOfRootGroups.
	objects := OrderedCollection new.
	objects
		addAll: estimate rootEstimates;
		addAll: estimate rootGroupEstimates;
		addAll: (estimate rootEstimates collect: [ :each | each root ]);
		addAll: (estimate rootEstimates collect: [ :each | each group ]);
		add: GtMemorySpaceRootsDefinition new;
		add: GtMemorySpaceRootGroup new;
		add: GtMemorySpaceRoot new;
		add: GtMemorySpaceRootEstimate new;
		add: GtMemorySpaceRootGroupEstimate new.
	^ objects asArray collect: [ :each | self assertViewsOf: each ]
]

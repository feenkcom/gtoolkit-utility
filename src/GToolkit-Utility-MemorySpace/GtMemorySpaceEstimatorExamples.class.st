"
Examples for {{gtClass:GtMemorySpaceEstimator}}, checking how objects are counted: shared objects, equal objects, cycles, weak references, ephemerons, boundaries, tags and categories.
"
Class {
	#name : #GtMemorySpaceEstimatorExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'examples - views' }
GtMemorySpaceEstimatorExamples >> assertViewsOf: anObject [
	"Assert that all views of anObject can be computed without errors"

	| aCheck |
	aCheck := GtMemorySpaceViewsCheck forObject: anObject.
	self assert: aCheck hasErrors not description: [ aCheck errorsDescription ].
	^ aCheck
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> boundaryWithTags [
	"Tags can be given as classes, as a condition on classes, or as tag objects. 
	The first matching tag wins."

	<gtExample>
	<return: #GtMemorySpaceBoundary>
	| boundary |
	boundary := GtMemorySpaceBoundary default
			tag: #string
				instancesOf: {ByteString.
						WideString};
			tag: #collection
				classesMatching: [ :aClass | aClass includesBehavior: Collection ];
			addTag: (GtMemorySpaceTag named: #point instancesOf: {Point});
			yourself.

	self assert: boundary tagNames asArray equals: #(#string #collection #point).
	self assert: (boundary tagForClass: ByteString) name equals: #string.
	self assert: (boundary tagForClass: ByteSymbol) name equals: #collection.
	self assert: (boundary tagForClass: OrderedCollection) name equals: #collection.
	self assert: (boundary tagForClass: Point) name equals: #point.
	self assert: (boundary tagForClass: Fraction) equals: nil.
	self
		assert: (boundary tagForClass: ByteString) class
		equals: GtMemorySpaceClassesTag.
	self
		assert: (boundary tagForClass: Array) class
		equals: GtMemorySpaceConditionTag.
	^ boundary
]

{ #category : #'examples - views' }
GtMemorySpaceEstimatorExamples >> brokenCellsViewFor: aView [
	"A view whose cells fail, used to check that view checks find errors. Not a <gtView>."

	^ aView columnedList
		title: 'Broken cells';
		items: [ #(1 2) ];
		column: 'Value' text: [ :each | each notAMessageOfIntegers ]
]

{ #category : #'examples - views' }
GtMemorySpaceEstimatorExamples >> brokenForwardViewFor: aView [
	"A view forwarding to an object that cannot be computed. Not a <gtView>."

	^ aView forward
		title: 'Broken forward';
		object: [ nil notAMessageOfNil ];
		view: #gtPrintFor:
]

{ #category : #'examples - views' }
GtMemorySpaceEstimatorExamples >> brokenItemsViewFor: aView [
	"A view whose items fail, used to check that view checks find errors. Not a <gtView>."

	^ aView columnedList
		title: 'Broken items';
		items: [ nil notAMessageOfNil ];
		column: 'Value' text: [ :each | each ]
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> categoryAttributionCountsAllReachableObjects [
	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| root estimate |
	root := Array with: 'one' copy with: 'two' copy.
	estimate := GtMemorySpaceEstimate new.

	(GtMemorySpaceAttribution toCategory: #root)
		estimate: root
		with: GtMemorySpaceEstimator new
		into: estimate.

	self
		assert: (estimate bytesOf: #root)
		equals: root sizeInMemory + root first sizeInMemory + root second sizeInMemory.
	^ estimate
]

{ #category : #'examples - estimates' }
GtMemorySpaceEstimatorExamples >> categoryEstimatesHoldBytesObjectsAndTags [
	"An estimate has one category estimate per category"

	<gtExample>
	<return: #GtMemorySpaceCategoryEstimate>
	| text root estimate categoryEstimate |
	text := 'text' copy.
	root := Array with: text with: 1 / 2.
	estimate := GtMemorySpaceEstimate forCategories: #(#root #unused).

	GtMemorySpaceEstimator new
		boundary: (GtMemorySpaceBoundary default
				tag: #string instancesOf: {String};
				yourself);
		estimate: root
			inCategory: #root
			into: estimate.

	categoryEstimate := estimate categoryEstimateFor: #root.
	self assert: categoryEstimate category equals: #root.
	self
		assert: categoryEstimate bytes
		equals: root sizeInMemory + text sizeInMemory + (1 / 2) sizeInMemory.
	self assert: categoryEstimate objectsCount equals: 3.
	self assert: (categoryEstimate bytesOfTag: #string) equals: text sizeInMemory.
	self assert: categoryEstimate tagNames asArray equals: #(#string).

	self assert: estimate categories asArray equals: #(#root #unused).
	self assert: (estimate categoryEstimateFor: #unused) bytes equals: 0.
	self
		assert: estimate sortedCategoryEstimates first
		identicalTo: categoryEstimate.
	^ categoryEstimate
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> classTraversalsAreDecidedOncePerClass [
	"How instances of a class are traversed is decided once per class"

	<gtExample>
	<return: #GtMemorySpaceEstimator>
	| estimator ephemeron weakArray array point |
	estimator := GtMemorySpaceEstimator new
			boundary: (GtMemorySpaceBoundary default
					stopAtInstancesOf: {Point};
					tag: #string instancesOf: {String};
					yourself);
			yourself.	"Ephemerons: all fixed slots are followed, except the key"
	ephemeron := estimator traversalForClass: WeakKeyAssociation.
	self assert: ephemeron isCounted.
	self assert: ephemeron slotNames first equals: #key.
	self
		assert: ephemeron followedSlotNames asArray
		equals: ephemeron slotNames allButFirst asArray.
	self assert: ephemeron followsIndexedSlots not.

	weakArray := estimator traversalForClass: WeakArray.
	self assert: weakArray followsIndexedSlots not.

	array := estimator traversalForClass: Array.
	self assert: array followsIndexedSlots.
	self assert: array tag equals: nil.

	self assert: (estimator traversalForClass: ByteString) tag name equals: #string.

	point := estimator traversalForClass: Point.
	self assert: point isCounted not.

	self assert: (estimator traversalForClass: Array) identicalTo: array.
	self assert: estimator classTraversals size equals: 5.
	^ estimator
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> classTraversalsAreGroupedByTag [
	"Class traversals are grouped by tag, then classes counted without a tag, then classes not counted"

	<gtExample>
	<return: #OrderedCollection>
	| estimator groups |
	estimator := GtMemorySpaceEstimator new
			boundary: (GtMemorySpaceBoundary default
					stopAtInstancesOf: {Point};
					tag: #string instancesOf: {String};
					tag: #unused instancesOf: {Fraction};
					yourself);
			yourself.
	estimator
		estimate: (Array
				with: 'text' copy
				with: 3 @ 4
				with: OrderedCollection new)
		inCategory: #root
		into: GtMemorySpaceEstimate new.

	groups := estimator classTraversalsByTag.
	self
		assert: (groups collect: [ :each | each name ]) asArray
		equals: #('string' 'not tagged' 'not counted').
	self assert: groups first tag name equals: #string.
	self assert: groups first classes asArray equals: {ByteString}.
	self
		assert: (groups second classes collect: [ :each | each name ]) asArray
		equals: #(#Array #OrderedCollection).
	self assert: (groups third classes includes: Point).
	self assert: estimator countedClassTraversals classesCount equals: 3.
	^ groups
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> codeEntitiesAreNotCounted [
	"The default boundary stops at classes, methods, variables and symbols"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| root estimate |
	root := Array
			with: Object
			with: #aSymbol
			with: Object >> #printString
			with: (Smalltalk globals associationAt: #Transcript).
	estimate := GtMemorySpaceEstimate new.

	GtMemorySpaceEstimator new
		estimate: root
		inCategory: #root
		into: estimate.

	self assert: (estimate bytesOf: #root) equals: root sizeInMemory.
	self assert: (estimate objectsCountOf: #root) equals: 1.
	^ estimate
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> cyclesAreCountedOnce [
	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| collection estimate |
	collection := OrderedCollection new.
	collection add: collection.
	estimate := GtMemorySpaceEstimate new.

	GtMemorySpaceEstimator new
		estimate: collection
		inCategory: #root
		into: estimate.

	self
		assert: (estimate bytesOf: #root)
		equals: collection sizeInMemory + (collection instVarNamed: #array) sizeInMemory.
	self assert: (estimate objectsCountOf: #root) equals: 2.
	^ estimate
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> dictionaryAttributionEstimatesOtherDictionariesAsAWhole [
	"Only plain dictionaries are split by keys; other dictionaries go entirely to the object category"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| dictionary attribution estimate estimator |
	dictionary := OrderedDictionary new.
	dictionary at: #links put: 'link' copy.
	attribution := GtMemorySpaceDictionaryAttribution new
			objectCategory: #options;
			key: #links to: #links;
			yourself.
	self deny: (attribution canSplit: dictionary).
	self assert: (attribution canSplit: Dictionary new).
	self assert: (attribution canSplit: IdentityDictionary new).
	self deny: (attribution canSplit: MethodDictionary new).
	self deny: (attribution canSplit: WeakKeyDictionary new).
	estimate := GtMemorySpaceEstimate new.
	estimator := GtMemorySpaceEstimator new.

	attribution
		estimate: dictionary
		with: estimator
		into: estimate.

	self assert: (estimate bytesOf: #links) equals: 0.
	self assert: (estimate bytesOf: #options) > (dictionary at: #links) sizeInMemory.
	self assert: (estimator isVisited: (dictionary at: #links)).
	^ estimate
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> dictionaryAttributionHasRules [
	"Each key with its own attribution has a rule"

	<gtExample>
	<return: #GtMemorySpaceDictionaryAttribution>
	| attribution rule |
	attribution := GtMemorySpaceDictionaryAttribution new
			objectCategory: #options;
			key: #links to: #links;
			yourself.

	rule := attribution ruleForKey: #links.
	self assert: rule key equals: #links.
	self assert: rule label equals: 'key #links'.
	self assert: (attribution ruleForKey: #other) isNil.
	self
		assert: (attribution rules collect: [ :each | each label ]) asArray
		equals: #('the dictionary itself' 'key #links' 'other keys').
	^ attribution
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> dictionaryAttributionSplitsADictionaryByKeys [
	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| dictionary attribution estimate expectedStructure |
	dictionary := Dictionary new.
	dictionary at: #first put: 'first value' copy.
	dictionary at: #second put: 'second value' copy.
	attribution := GtMemorySpaceDictionaryAttribution new
			objectCategory: #dictionary;
			key: #first to: #first;
			yourself.
	estimate := GtMemorySpaceEstimate new.

	attribution
		estimate: dictionary
		with: GtMemorySpaceEstimator new
		into: estimate.

	expectedStructure := dictionary sizeInMemory
			+ (dictionary instVarNamed: #array) sizeInMemory
			+ (dictionary associations
					inject: 0
					into: [ :sum :each | sum + each sizeInMemory ]).
	self
		assert: (estimate bytesOf: #dictionary)
		equals: expectedStructure + (dictionary at: #second) sizeInMemory.
	self
		assert: (estimate bytesOf: #first)
		equals: (dictionary at: #first) sizeInMemory.
	^ estimate
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> emptyEstimate [
	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| estimate |
	estimate := GtMemorySpaceEstimate new.

	self assert: estimate totalBytes equals: 0.
	self assert: estimate totalObjectsCount equals: 0.
	self assert: (estimate bytesOf: #root) equals: 0.
	^ estimate
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> ephemeronKeysAreNotFollowed [
	"Ephemerons do not keep their key alive, but they keep their value alive"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| key value ephemeron estimate |
	key := 'key' copy.
	value := 'value' copy.
	ephemeron := WeakKeyAssociation key: key value: value.
	self assert: ephemeron class isEphemeronClass.
	estimate := GtMemorySpaceEstimate new.

	GtMemorySpaceEstimator new
		estimate: ephemeron
		inCategory: #root
		into: estimate.

	self
		assert: (estimate bytesOf: #root)
		equals: ephemeron sizeInMemory + value sizeInMemory.
	self assert: ephemeron key identicalTo: key.
	^ estimate
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> equalObjectsAreCountedSeparately [
	"Objects are compared by identity, not by equality"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| first second root estimate |
	first := 'equal' copy.
	second := 'equal' copy.
	root := Array with: first with: second.
	estimate := GtMemorySpaceEstimate new.

	GtMemorySpaceEstimator new
		estimate: root
		inCategory: #root
		into: estimate.

	self
		assert: (estimate bytesOf: #root)
		equals: root sizeInMemory + first sizeInMemory + second sizeInMemory.
	self assert: (estimate objectsCountOf: #root) equals: 3.
	^ estimate
]

{ #category : #'examples - estimates' }
GtMemorySpaceEstimatorExamples >> estimatesCanBeAdded [
	"Adding estimates adds their bytes, objects and tags, category by category"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| first second combined |
	first := GtMemorySpaceEstimate new.
	first
		addBytes: 100
		objectsCount: 2
		toCategory: #a.
	first
		addBytes: 40
		ofTag: #string
		toCategory: #a.
	second := GtMemorySpaceEstimate new.
	second
		addBytes: 50
		objectsCount: 1
		toCategory: #a.
	second
		addBytes: 30
		objectsCount: 3
		toCategory: #b.
	second
		addBytes: 10
		ofTag: #string
		toCategory: #a.

	combined := GtMemorySpaceEstimate new
			addEstimate: first;
			addEstimate: second;
			yourself.

	self assert: (combined bytesOf: #a) equals: 150.
	self assert: (combined objectsCountOf: #a) equals: 3.
	self assert: (combined bytesOf: #b) equals: 30.
	self assert: (combined bytesOf: #a tag: #string) equals: 50.
	self assert: combined totalBytes equals: 180.
	self assert: combined totalObjectsCount equals: 6.
	^ combined
]

{ #category : #'examples - definitions' }
GtMemorySpaceEstimatorExamples >> estimationBeforeRunning [
	"An estimation that did not run has no results, and its views are empty"

	<gtExample>
	<return: #GtMemorySpaceEstimation>
	| estimation |
	estimation := GtMemorySpaceEstimation new.

	self deny: estimation hasRun.
	self assertViewsOf: estimation.
	^ estimation
]

{ #category : #'examples - definitions' }
GtMemorySpaceEstimatorExamples >> estimationOfExampleDefinition [
	"All declared categories appear in the estimate, also those to which nothing is attributed"

	<gtExample>
	<return: #GtMemorySpaceEstimation>
	| definition associations shared estimation |
	definition := self exampleDefinition.
	shared := 'shared' copy.
	associations := {#one -> shared.
			#two -> shared.
			'three' copy -> 'value' copy}.

	estimation := definition estimate: associations.

	self
		assert: (estimation estimate bytesOf: (definition category: #associations))
		equals: (associations inject: 0 into: [ :sum :each | sum + each sizeInMemory ]).
	self
		assert: (estimation estimate bytesOf: (definition category: #keys))
		equals: associations third key sizeInMemory.
	self
		assert: (estimation estimate bytesOf: (definition category: #values))
		equals: shared sizeInMemory + associations third value sizeInMemory.
	self
		assert: (estimation estimate categories includes: (definition category: #unused)).
	self
		assert: (estimation estimate bytesOf: (definition category: #unused))
		equals: 0.
	self assert: estimation objectsCount equals: 6.
	^ estimation
]

{ #category : #'examples - estimator' }
GtMemorySpaceEstimatorExamples >> estimatorReleasesVisitedObjects [
	"After releasing the visited objects, the estimator still knows how many objects it counted"

	<gtExample>
	<return: #GtMemorySpaceEstimator>
	| estimator estimate root |
	root := Array with: 'one' copy with: 'two' copy.
	estimator := GtMemorySpaceEstimator new.
	estimator expectedObjects: 100.
	estimate := GtMemorySpaceEstimate new.

	estimator
		estimate: root
		inCategory: #root
		into: estimate.
	self assert: estimator objectsCount equals: 3.
	self assert: (estimator isVisited: root).	"Presizing after a walk does not forget the visited objects"
	estimator expectedObjects: 1000.
	self assert: estimator objectsCount equals: 3.

	estimator releaseVisitedObjects.
	self assert: estimator objectsCount equals: 3.
	estimator expectedObjects: 1000.
	self assert: estimator objectsCount equals: 3.
	^ estimator
]

{ #category : #'examples - definitions' }
GtMemorySpaceEstimatorExamples >> exampleDefinition [
	"A definition can be inspected before estimating anything"

	<gtExample>
	<return: #GtMemorySpaceExampleDefinition>
	| definition |
	definition := GtMemorySpaceExampleDefinition new.

	self
		assert: (definition categories collect: [ :each | each key ]) asArray
		equals: #(#associations #keys #values #unused).
	self assert: (definition category: #keys) name equals: 'Keys'.
	self
		assert: (definition rules first attribution categories collect: [ :each | each key ])
				asArray
		equals: #(#associations #keys #values).
	^ definition
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> ignoredAttributionCountsNothing [
	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| estimate |
	estimate := GtMemorySpaceEstimate new.

	GtMemorySpaceAttribution ignored
		estimate: (Array with: 'one' copy)
		with: GtMemorySpaceEstimator new
		into: estimate.

	self assert: estimate totalBytes equals: 0.
	self assert: GtMemorySpaceAttribution ignored categories isEmpty.
	^ estimate
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> objectsAreCountedOnceAcrossWalks [
	"An object reached by several walks is counted in the category of the first one"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| shared first second estimator estimate |
	shared := 'shared' copy.
	first := Array with: shared.
	second := Array with: shared.
	estimate := GtMemorySpaceEstimate new.
	estimator := GtMemorySpaceEstimator new.

	estimator
		estimate: first
		inCategory: #first
		into: estimate.
	estimator
		estimate: second
		inCategory: #second
		into: estimate.

	self
		assert: (estimate bytesOf: #first)
		equals: first sizeInMemory + shared sizeInMemory.
	self assert: (estimate bytesOf: #second) equals: second sizeInMemory.
	self assert: estimator objectsCount equals: 3.
	^ estimate
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> sharedObjectsAreCountedOnce [
	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| shared root estimate |
	shared := 'shared' copy.
	root := Array with: shared with: shared.
	estimate := GtMemorySpaceEstimate new.

	GtMemorySpaceEstimator new
		estimate: root
		inCategory: #root
		into: estimate.

	self
		assert: (estimate bytesOf: #root)
		equals: root sizeInMemory + shared sizeInMemory.
	self assert: (estimate objectsCountOf: #root) equals: 2.
	^ estimate
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> slotsAttributionAttributesIndexedSlotsToOtherSlots [
	"The objects in indexed slots use the attribution for other slots"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| first second array attribution estimate |
	first := 'first' copy.
	second := 'second' copy.
	array := Array with: first with: second.
	attribution := GtMemorySpaceSlotsAttribution new
			objectCategory: #array;
			otherSlotsTo: #elements;
			yourself.
	estimate := GtMemorySpaceEstimate new.

	attribution
		estimate: array
		with: GtMemorySpaceEstimator new
		into: estimate.

	self assert: (estimate bytesOf: #array) equals: array sizeInMemory.
	self
		assert: (estimate bytesOf: #elements)
		equals: first sizeInMemory + second sizeInMemory.
	^ estimate
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> slotsAttributionCountsTheObjectEvenIfStopped [
	"The boundary applies to objects reached by a walk, not to the object given to an attribution.
	This allows counting roots, like pages of a database, while stopping walks at other roots."

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| inner outer estimate |
	inner := Point x: 1 / 2 y: 3.
	outer := Point x: inner y: 4.
	estimate := GtMemorySpaceEstimate new.

	(GtMemorySpaceSlotsAttribution new
		objectCategory: #outer;
		slot: #x to: #x;
		yourself)
		estimate: outer
		with: (GtMemorySpaceEstimator new
				boundary: (GtMemorySpaceBoundary default
						stopAtInstancesOf: {Point};
						yourself);
				yourself)
		into: estimate.

	self assert: (estimate bytesOf: #outer) equals: outer sizeInMemory.
	self assert: (estimate bytesOf: #x) equals: 0.
	self assert: estimate totalObjectsCount equals: 1.
	^ estimate
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> slotsAttributionDefaultsToTheLatestObjectCategory [
	"The default attribution of other slots follows the object category, 
	even if the rules were asked for before the object category was declared"

	<gtExample>
	<return: #GtMemorySpaceSlotsAttribution>
	| attribution |
	attribution := GtMemorySpaceSlotsAttribution new.
	attribution rules.
	attribution objectCategory: #object.

	self assert: attribution otherSlotsAttribution category equals: #object.
	self assert: attribution rules first attribution category equals: #object.
	self assert: attribution categories asArray equals: #(#object).
	^ attribution
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> slotsAttributionDoesNotFollowEphemeronKeys [
	"Like the walk of the estimator, a slots attribution does not follow the key of an ephemeron"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| key value ephemeron attribution estimate |
	key := 'key' copy.
	value := 'value' copy.
	ephemeron := WeakKeyAssociation key: key value: value.
	self assert: ephemeron class isEphemeronClass.
	attribution := GtMemorySpaceSlotsAttribution new
			objectCategory: #ephemeron;
			slot: #key to: #keys;
			slot: #value to: #values;
			yourself.
	estimate := GtMemorySpaceEstimate new.

	attribution
		estimate: ephemeron
		with: GtMemorySpaceEstimator new
		into: estimate.

	self assert: (estimate bytesOf: #ephemeron) equals: ephemeron sizeInMemory.
	self assert: (estimate bytesOf: #keys) equals: 0.
	self assert: (estimate bytesOf: #values) equals: value sizeInMemory.
	^ estimate
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> slotsAttributionHasRules [
	"Each slot with its own attribution has a rule. 
	The rules of an attribution also describe the object itself and the other slots."

	<gtExample>
	<return: #GtMemorySpaceSlotsAttribution>
	| attribution rule |
	attribution := GtMemorySpaceSlotsAttribution new
			objectCategory: #association;
			slot: #key to: #keys;
			ignoreSlots: #(#value);
			yourself.

	rule := attribution ruleForSlot: #key.
	self assert: rule slotName equals: #key.
	self assert: rule label equals: 'slot key'.
	self assert: (rule attribution isKindOf: GtMemorySpaceCategoryAttribution).
	self assert: (attribution ruleForSlot: #other) isNil.
	self
		assert: (attribution slotRules collect: [ :each | each slotName ]) asArray
		equals: #(#key #value).

	self
		assert: (attribution rules collect: [ :each | each label ]) asArray
		equals: #('the object itself' 'slot key' 'slot value' 'other slots').
	self assert: attribution rules second identicalTo: rule.
	^ attribution
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> slotsAttributionIgnoresAndDefaultsSlots [
	"Ignored slots are not counted; slots without an attribution go to the other slots category"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| association attribution estimate |
	association := 'key' copy -> 'value' copy.
	attribution := GtMemorySpaceSlotsAttribution new
			objectCategory: #association;
			ignoreSlots: #(value);
			otherSlotsTo: #other;
			yourself.
	estimate := GtMemorySpaceEstimate new.

	attribution
		estimate: association
		with: GtMemorySpaceEstimator new
		into: estimate.

	self assert: (estimate bytesOf: #association) equals: association sizeInMemory.
	self assert: (estimate bytesOf: #other) equals: association key sizeInMemory.
	self
		assert: estimate totalBytes
		equals: association sizeInMemory + association key sizeInMemory.
	^ estimate
]

{ #category : #'examples - attributions' }
GtMemorySpaceEstimatorExamples >> slotsAttributionSplitsAnObjectBySlots [
	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| key value association attribution estimate |
	key := 'key' copy.
	value := 'value' copy.
	association := key -> value.
	attribution := GtMemorySpaceSlotsAttribution new
			objectCategory: #association;
			slot: #key to: #key;
			slot: #value to: #value;
			yourself.
	estimate := GtMemorySpaceEstimate new.

	attribution
		estimate: association
		with: GtMemorySpaceEstimator new
		into: estimate.

	self assert: (estimate bytesOf: #association) equals: association sizeInMemory.
	self assert: (estimate bytesOf: #key) equals: key sizeInMemory.
	self assert: (estimate bytesOf: #value) equals: value sizeInMemory.
	self assert: attribution categories asArray equals: #(#association #key #value).
	^ estimate
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> stopClassesAreNotCounted [
	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| point root estimate |
	point := (3 / 4) @ 5.
	root := Array with: point.
	estimate := GtMemorySpaceEstimate new.

	GtMemorySpaceEstimator new
		boundary: (GtMemorySpaceBoundary default
				stopAtInstancesOf: {Point};
				yourself);
		estimate: root
			inCategory: #root
			into: estimate.

	self assert: (estimate bytesOf: #root) equals: root sizeInMemory.
	^ estimate
]

{ #category : #'examples - estimates' }
GtMemorySpaceEstimatorExamples >> tagEstimatesHoldBytesPerCategory [
	"A tag estimate holds the bytes of the objects with the tag, in total and per category.
	The estimates of a tag within a category are shared by the category estimate and the tag estimate.
	Tag estimates are computed from the category estimates on each request."

	<gtExample>
	<return: #GtMemorySpaceTagEstimate>
	| estimate tagEstimate stringsInAst |
	estimate := GtMemorySpaceEstimate new.
	estimate
		addBytes: 100
		objectsCount: 2
		toCategory: #text.
	estimate
		addBytes: 40
		ofTag: #string
		toCategory: #text.
	estimate
		addBytes: 200
		objectsCount: 5
		toCategory: #ast.
	estimate
		addBytes: 60
		ofTag: #string
		toCategory: #ast.
	estimate
		addBytes: 80
		ofTag: #node
		toCategory: #ast.

	self assert: estimate tags asArray equals: #(#string #node).
	tagEstimate := estimate tagEstimateFor: #string.
	self assert: tagEstimate bytes equals: 100.
	self assert: (tagEstimate bytesOfCategory: #text) equals: 40.
	self assert: (tagEstimate bytesOfCategory: #ast) equals: 60.
	self assert: (tagEstimate bytesOfCategory: #other) equals: 0.
	self assert: estimate sortedTagEstimates first tagName equals: #string.
	self assert: (estimate bytesOfTag: #string) equals: tagEstimate bytes.

	stringsInAst := (estimate categoryEstimateFor: #ast) tagEstimateFor: #string.
	self assert: stringsInAst bytes equals: 60.
	self
		assert: tagEstimate sortedCategoryTagEstimates first
		identicalTo: stringsInAst.
	^ tagEstimate
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> taggedObjectsAreTracked [
	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| first second root estimate |
	first := 'one' copy.
	second := 'two' copy.
	root := Array
			with: first
			with: second
			with: 1 / 2.
	estimate := GtMemorySpaceEstimate new.

	GtMemorySpaceEstimator new
		boundary: (GtMemorySpaceBoundary default
				tag: #string instancesOf: {String};
				yourself);
		estimate: root
			inCategory: #root
			into: estimate.

	self
		assert: (estimate bytesOf: #root tag: #string)
		equals: first sizeInMemory + second sizeInMemory.
	self
		assert: (estimate bytesOfTag: #string)
		equals: first sizeInMemory + second sizeInMemory.
	self
		assert: (estimate bytesOf: #root)
		equals: root sizeInMemory + first sizeInMemory + second sizeInMemory
				+ (1 / 2) sizeInMemory.
	^ estimate
]

{ #category : #'examples - views' }
GtMemorySpaceEstimatorExamples >> viewChecksFindErrors [
	"View checks compute views like the inspector would, and collect their errors"

	<gtExample>
	<return: #Array>
	| cells items forward |
	cells := GtMemorySpaceViewCheck object: self selector: #brokenCellsViewFor:.
	items := GtMemorySpaceViewCheck object: self selector: #brokenItemsViewFor:.
	forward := GtMemorySpaceViewCheck object: self selector: #brokenForwardViewFor:.

	self assert: cells hasErrors.
	self assert: cells rowsCount equals: 2.
	self assert: cells errors size equals: 2.
	self assert: (cells errors first includesSubstring: 'notAMessageOfIntegers').
	self assert: items hasErrors.
	self assert: forward hasErrors.
	^ {cells.
		items.
		forward}
]

{ #category : #'examples - views' }
GtMemorySpaceEstimatorExamples >> viewChecksOfAWorkingObject [
	"The views of an object are the ones defined by its class and superclasses below Object"

	<gtExample>
	<return: #GtMemorySpaceViewsCheck>
	| check |
	check := self assertViewsOf: self estimationOfExampleDefinition estimate.

	self
		assert: (check viewChecks collect: [ :each | each selector ]) asSet
		equals: #(#gtViewCategoriesFor: #gtViewTagsFor:) asSet.
	self assert: (check viewCheckFor: #gtViewCategoriesFor:) rowsCount equals: 4.
	^ check
]

{ #category : #'examples - views' }
GtMemorySpaceEstimatorExamples >> viewsOfEmptyObjectsWork [
	"Views also work for objects that were not computed or declared yet"

	<gtExample>
	<return: #Array>
	^ {GtMemorySpaceEstimation new.
		GtMemorySpaceEstimator new.
		GtMemorySpaceEstimate new.
		GtMemorySpaceCategoryEstimate new.
		GtMemorySpaceTagEstimate new.
		GtMemorySpaceBoundary new.
		GtMemorySpaceClassesTag new.
		GtMemorySpaceClassTraversalGroup new.
		GtMemorySpaceSlotsAttribution new.
		GtMemorySpaceDictionaryAttribution new.
		GtMemorySpaceRule new.
		GtMemorySpaceViewsCheck new} collect: [ :each | self assertViewsOf: each ]
]

{ #category : #'examples - views' }
GtMemorySpaceEstimatorExamples >> viewsOfEstimationObjectsWork [
	"All views of the objects of an estimation can be computed"

	<gtExample>
	<return: #Array>
	| estimation estimate definition objects |
	estimation := self estimationOfExampleDefinition.
	estimate := estimation estimate.
	definition := estimation definition.
	objects := OrderedCollection new.
	objects
		add: estimation;
		add: estimation estimator;
		add: estimate;
		addAll: estimate categoryEstimates;
		addAll: estimation estimator classTraversals;
		addAll: estimation estimator classTraversalsByTag;
		add: definition;
		addAll: definition rules;
		addAll: (definition rules collect: [ :each | each attribution ]);
		addAll: definition rules first attribution rules;
		add: definition newBoundary.
	^ objects asArray collect: [ :each | self assertViewsOf: each ]
]

{ #category : #'examples - views' }
GtMemorySpaceEstimatorExamples >> viewsOfTagsAndTagEstimatesWork [
	"Views of boundaries with tags, and of tag estimates, can be computed"

	<gtExample>
	<return: #Array>
	| boundary tagEstimate objects |
	boundary := self boundaryWithTags.
	tagEstimate := self tagEstimatesHoldBytesPerCategory.
	objects := OrderedCollection new.
	objects
		add: boundary;
		addAll: boundary tags;
		add: tagEstimate;
		addAll: tagEstimate categoryTagEstimates.
	^ objects asArray collect: [ :each | self assertViewsOf: each ]
]

{ #category : #examples }
GtMemorySpaceEstimatorExamples >> weakReferencesAreNotFollowed [
	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| referenced weak estimate |
	referenced := 'referenced' copy.
	weak := WeakArray with: referenced.
	estimate := GtMemorySpaceEstimate new.

	GtMemorySpaceEstimator new
		estimate: weak
		inCategory: #root
		into: estimate.

	self assert: (estimate bytesOf: #root) equals: weak sizeInMemory.
	self assert: weak first identicalTo: referenced.
	^ estimate
]

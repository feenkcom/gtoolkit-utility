"
I tag objects in a memory space estimation, to track their size separately from the categories in which they are counted (see {{gtClass:GtMemorySpaceBoundary}} and {{gtClass:GtMemorySpaceEstimate}}).

I decide per class which objects I tag (see #matchesClass:), so the estimator can cache the decision. An object has at most one tag: the first tag of the boundary that matches its class.

Use #named:instancesOf: or #named:classesMatching: to create tags.
"
Class {
	#name : #GtMemorySpaceTag,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #'instance creation' }
GtMemorySpaceTag class >> named: aName classesMatching: aBlock [
	"A tag for instances of the classes for which aBlock answers true"

	^ GtMemorySpaceConditionTag new
		name: aName;
		condition: aBlock;
		yourself
]

{ #category : #'instance creation' }
GtMemorySpaceTag class >> named: aName instancesOf: aCollectionOfClasses [
	"A tag for instances of these classes and of their subclasses"

	^ GtMemorySpaceClassesTag new
		name: aName;
		classes: aCollectionOfClasses;
		yourself
]

{ #category : #accessing }
GtMemorySpaceTag >> description [
	"A description of the classes with this tag"

	^ self subclassResponsibility
]

{ #category : #testing }
GtMemorySpaceTag >> matchesClass: aClass [
	"Answer whether instances of aClass have this tag"

	^ self subclassResponsibility
]

{ #category : #accessing }
GtMemorySpaceTag >> name [
	^ name
]

{ #category : #accessing }
GtMemorySpaceTag >> name: aName [
	name := aName
]

{ #category : #printing }
GtMemorySpaceTag >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: name;
		nextPutAll: ': ';
		nextPutAll: self description;
		nextPut: $)
]

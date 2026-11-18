"
I tag the instances of some classes and of their subclasses.
"
Class {
	#name : #GtMemorySpaceClassesTag,
	#superclass : #GtMemorySpaceTag,
	#instVars : [
		'classes'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceClassesTag >> classes [
	^ classes ifNil: [ #() ]
]

{ #category : #accessing }
GtMemorySpaceClassesTag >> classes: aCollectionOfClasses [
	classes := aCollectionOfClasses asArray
]

{ #category : #accessing }
GtMemorySpaceClassesTag >> description [
	^ 'instances of ' , (', ' join: (classes collect: [ :each | each name ]))
]

{ #category : #'gt - extensions' }
GtMemorySpaceClassesTag >> gtViewClassesFor: aView [
	<gtView>
	^ aView list
		title: 'Classes';
		priority: 10;
		items: [ self classes ];
		itemText: [ :each | each name ]
]

{ #category : #testing }
GtMemorySpaceClassesTag >> matchesClass: aClass [
	^ classes anySatisfy: [ :each | aClass includesBehavior: each ]
]

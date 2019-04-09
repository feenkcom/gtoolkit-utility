"
I am an abstract class for all sequential taskers that keep a collection of tasks.

${class:GtTaskerOrderedNonRepetitive}$ can be instantiated by calling ${method:GtTasker class>>#orderedNonRepetitive}$.
"
Class {
	#name : #GtTasker,
	#superclass : #GtProtoTasker,
	#instVars : [
		'collection',
		'mutex'
	],
	#category : #'GToolkit-Utility-Tasker'
}

{ #category : #factory }
GtTasker class >> orderedNonRepetitive [
	^ GtTaskerOrderedNonRepetitive new
]

{ #category : #'gt-extension' }
GtTasker >> addTask: aTask [
	"Add task to a collection if appropriate.
	Mutex should be used."
	self subclassResponsibility
]

{ #category : #converting }
GtTasker >> asPostponingTasker [
	^ GtPostponingTasker new tasker: self
]

{ #category : #asserting }
GtTasker >> assertTask: aTask [ 
	self 
		assert: [ aTask isNotNil ]
		description: [ 'Task in collection must be non-nil' ].
]

{ #category : #accessing }
GtTasker >> collection [
	<return: #Collection>
	^ collection
]

{ #category : #action }
GtTasker >> flush [
	"Execute existing collection."
	| anOldCollection |
	mutex critical: [ 
		anOldCollection := self collection.
		collection := self newDefaultCollection ].
	"While executing, new collection can be filled"
	anOldCollection do: [ :eachTask | eachTask execute ].
]

{ #category : #'gt-extension' }
GtTasker >> gtItemsFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ (self collection gtItemsFor: aView)
		title: 'Tasks'
]

{ #category : #initialization }
GtTasker >> initialize [
	super initialize.
	mutex := Mutex new.
	collection := self newDefaultCollection.
]

{ #category : #'instance creation' }
GtTasker >> newDefaultCollection [
	<return: #Collection>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtTasker >> size [
	^ self collection ifNotNil: #size ifNil: 0
]

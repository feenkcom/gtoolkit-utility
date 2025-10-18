Class {
	#name : #GtBareRecordedClass,
	#superclass : #Object,
	#instVars : [
		'targetClassName',
		'isMeta'
	],
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #'instance creation' }
GtBareRecordedClass class >> forClass: aClass [ 
	^ self new 
		initializeForClass: aClass 
]

{ #category : #comparing }
GtBareRecordedClass >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ targetClassName = anObject targetClassName and: [
		isMeta = anObject isMeta ]
]

{ #category : #comparing }
GtBareRecordedClass >> hash [
	^ self targetClassName hash 
		bitXor: self isMeta hash
]

{ #category : #initialization }
GtBareRecordedClass >> initializeForClass: aClass [ 
	targetClassName := aClass instanceSide name.
	isMeta := aClass isMeta
]

{ #category : #accessing }
GtBareRecordedClass >> isMeta [

	^ isMeta
]

{ #category : #accessing }
GtBareRecordedClass >> isMeta: aBoolean [

	isMeta := aBoolean
]

{ #category : #printing }
GtBareRecordedClass >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [ 
		aStream << self targetClassNameDescription ]
]

{ #category : #accessing }
GtBareRecordedClass >> targetClassName [
	^ targetClassName
]

{ #category : #accessing }
GtBareRecordedClass >> targetClassName: aClassName [
	targetClassName := aClassName
]

{ #category : #printing }
GtBareRecordedClass >> targetClassNameDescription [
	^ self isMeta
		ifTrue: [ self targetClassName asString ]
		ifFalse: [ self targetClassName asString, ' class' ]
]

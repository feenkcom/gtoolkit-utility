"
Answer the cached value, which is updated whenever the image session changes ({{gtMethod:SmalltalkImage>>session}}).

`getter` is a BlockClosure that takes no arguments and is called whenever the cached value should be set or updated.

The `session` can be modified to facilitate testing.
"
Class {
	#name : #GtSessionCache,
	#superclass : #Object,
	#instVars : [
		'session',
		'value',
		'getter'
	],
	#category : #'GToolkit-Utility-Basic-Cache'
}

{ #category : #'instance creation' }
GtSessionCache class >> getter: aBlock [

	^ self new getter: aBlock
]

{ #category : #accessing }
GtSessionCache >> getter [
	^ getter
]

{ #category : #accessing }
GtSessionCache >> getter: aBlockClosure [

	getter := aBlockClosure
]

{ #category : #'private - accessing' }
GtSessionCache >> session [
	<return: #GtWorkingSession>

	^ session
]

{ #category : #'private - accessing' }
GtSessionCache >> session: aGtWorkingSession [

	session := aGtWorkingSession
]

{ #category : #accessing }
GtSessionCache >> value [

	Smalltalk image session == session ifFalse:
		[ value := getter value ].
	
	^ value
]

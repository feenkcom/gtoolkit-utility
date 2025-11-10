Class {
	#name : #AsyncProcessStackOverflowCheckerFuture,
	#superclass : #Object,
	#traits : 'TAsyncFuture',
	#classTraits : 'TAsyncFuture classTrait',
	#instVars : [
		'future',
		'depth'
	],
	#category : #'GToolkit-Utility-StackOverflowFuture'
}

{ #category : #'instance creation' }
AsyncProcessStackOverflowCheckerFuture class >> future: anAsyncFuture [
	^ self new future: anAsyncFuture
]

{ #category : #'instance creation' }
AsyncProcessStackOverflowCheckerFuture class >> future: anAsyncFuture depth: anInteger [
	^ self new
		future: anAsyncFuture;
		depth: anInteger
]

{ #category : #initialization }
AsyncProcessStackOverflowCheckerFuture >> depth: anInteger [
	depth := anInteger
]

{ #category : #initialization }
AsyncProcessStackOverflowCheckerFuture >> future: anAsyncFuture [
	future := anAsyncFuture
]

{ #category : #'api - future' }
AsyncProcessStackOverflowCheckerFuture >> poll: anAsynchronousContext [
	"I signal GtStackOverflowError in case of an infinite loop."

	<return: #AsyncPoll>
	^ GtProcessStackOverflowChecker currentCheckerClass
		ensureCheckDuring: [ future poll: anAsynchronousContext ]
		depth: (depth ifNil: [ GtStackOverflowChecker defaultStackOverflowLimit ])
]

{ #category : #'api - future copy' }
AsyncProcessStackOverflowCheckerFuture >> postSimilarCopy [
	"Is called by similarCopy. self is a shallow copy, implementors should set the fields as necessary to complete the similar copy"
	
	future := future asyncSimilarCopy
]

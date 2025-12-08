Class {
	#name : #GtPharoDebugLogBlockFrame,
	#superclass : #GtPharoDebugLogFrame,
	#category : #'GToolkit-PharoDebug-Model'
}

{ #category : #'as yet unclassified' }
GtPharoDebugLogBlockFrame >> methodName [

	^ content lines
		detect: [ :each | each includesSubstring: '] in ' ]
		ifFound: [ :line | (line copyFrom: (line indexOfSubCollection: '] in ') + 5 to: line size) ]
		ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
GtPharoDebugLogBlockFrame >> printOn: aStream [

	(content isNil or: [ content isEmpty ]) ifTrue:
		[ ^ super printOn: aStream ].

	aStream 
		<< '[] in ';
		<< (self methodName ifNil: [ '<unknown>' ]).
]

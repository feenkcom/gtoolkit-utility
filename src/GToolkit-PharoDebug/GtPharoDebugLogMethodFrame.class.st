Class {
	#name : #GtPharoDebugLogMethodFrame,
	#superclass : #GtPharoDebugLogFrame,
	#category : #'GToolkit-PharoDebug-Model'
}

{ #category : #'as yet unclassified' }
GtPharoDebugLogMethodFrame >> methodName [

	^ content readStream nextLine
]

{ #category : #printing }
GtPharoDebugLogMethodFrame >> printOn: aStream [

	(content isNil or: [ content isEmpty ]) ifTrue: 
		[ ^ super printOn: aStream ].

	aStream << content lines first
]

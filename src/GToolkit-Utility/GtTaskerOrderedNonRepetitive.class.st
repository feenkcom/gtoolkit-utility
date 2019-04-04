Class {
	#name : #GtTaskerOrderedNonRepetitive,
	#superclass : #GtTasker,
	#category : #'GToolkit-Utility-Tasker'
}

{ #category : #'gt-extension' }
GtTaskerOrderedNonRepetitive >> addTask: aTask [
	self assertTask: aTask.
	mutex critical: [ self collection at: aTask put: aTask ].
]

{ #category : #'gt-extension' }
GtTaskerOrderedNonRepetitive >> gtItemsFor: aView [
	self collection ifNil: [ ^ aView empty ].
	^ (self collection gtKeysFor: aView)
		title: 'Tasks'
]

{ #category : #'instance creation' }
GtTaskerOrderedNonRepetitive >> newDefaultCollection [
	^ OrderedDictionary new
]

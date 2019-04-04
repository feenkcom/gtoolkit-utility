"
I am a tasker that collects ${class:GtTaskerTask}$instances. If a task is igual with an already added task, I remove the previous one and add the new one at the same position. ${class:GtTaskerTask}$ subclasses should therefore implement ===== and ==hash== methods to collaborate correctly with me.

The following example explains is better. ==aTaskOne== and ==aTaskThree== are equivalent, so the tasker keeps only two tasks and the first one is the ==aTaskThree==:
${example:GtTaskerExamples>>#keepOrderInOrderedNonRepetitiveTasker|previewExpanded=true}$


Executing ${method:GtTasker>>#flush}$ will execute all tasks and eliminate them from the collection. See the follosing example: 
${example:GtTaskerExamples>>#flushOrderedNonRepetitiveTasker|previewExpanded=true}$
"
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

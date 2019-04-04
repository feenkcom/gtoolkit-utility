"
I am tasker that automatically execute collected tasks after an certain inactivity. I am not responsible how tasks are collected, it is a responsibility of another tasker that is set as an instance variable using ${method:GtPostponingTasker>>#tasker:}$. 

The inactivity and suspencion time is currently fixed, see ${method:GtPostponingTasker>>#initialize|expanded=true}$. The value is returned by ${method:GtPostponingTasker>>#suspencion}$. It can be easily improved to be configurable if needed.

The following example shows how many tasks are added and executed after the predetermined time of inactivity (the final task list is therefore empty): ${example:GtTaskerExamples>>#addingManySameTasksToPostponingTasker|previewExpanded=true}$
"
Class {
	#name : #GtPostponingTasker,
	#superclass : #GtProtoTasker,
	#instVars : [
		'tasker',
		'minSuspencion',
		'mutex',
		'isActive',
		'process',
		'lastReceivedTaskTime'
	],
	#category : #'GToolkit-Utility-Tasker'
}

{ #category : #adding }
GtPostponingTasker >> addTask: aTask [
	self assertTasker.
	mutex critical: [ 
		self ensureActiveProcess.
		self tasker addTask: aTask.
		self updateTimeOfLastReceivedTask ]
]

{ #category : #asserting }
GtPostponingTasker >> assertTasker [
	self
		assert: [ self tasker isNotNil ]
		description: [ 'Postponing tasker must have a tasker defined' ]
]

{ #category : #private }
GtPostponingTasker >> ensureActiveProcess [
	isActive ifTrue: [ ^ self ].
	isActive := true.
	self startProcess
]

{ #category : #actions }
GtPostponingTasker >> flush [
	"Execute existing collection."
	self assertTasker.
	self tasker flush.
]

{ #category : #accessing }
GtPostponingTasker >> gtItemsFor: aView [
	<gtView>
	self tasker ifNil: [ ^ aView empty ].
	^ self tasker gtItemsFor: aView 
]

{ #category : #initialization }
GtPostponingTasker >> initialize [
	super initialize.
	tasker := nil.
	mutex := Mutex new.
	minSuspencion := 200 milliSeconds.
	lastReceivedTaskTime := DateAndTime now.
	isActive := false.
	process := nil.
]

{ #category : #testing }
GtPostponingTasker >> isTaskActivityCalmedDown [
	<return: #Boolean>
	^ mutex critical: [ (DateAndTime now - lastReceivedTaskTime) > self suspencion ]
]

{ #category : #accessing }
GtPostponingTasker >> size [
	self assertTasker.
	^ self tasker size.
]

{ #category : #private }
GtPostponingTasker >> startProcess [
	process := [ 
		[ self isTaskActivityCalmedDown ] whileFalse: [ self suspencion wait ].
		mutex critical: [ isActive := false. process := nil ].
		self flush.
		]
			forkAt: Processor userBackgroundPriority 
			named: self className, ' process'
]

{ #category : #accessing }
GtPostponingTasker >> suspencion [
	<return: #Duration>
	^ minSuspencion
]

{ #category : #accessing }
GtPostponingTasker >> tasker [
	<return: #GtTasker>
	^ tasker
]

{ #category : #accessing }
GtPostponingTasker >> tasker: aGtTasker [
	self 
		assert: [ aGtTasker isNotNil ] 
		description: [ 'Tasker must be non-nil' ].
	tasker := aGtTasker
]

{ #category : #private }
GtPostponingTasker >> updateTimeOfLastReceivedTask [
	lastReceivedTaskTime := DateAndTime now.
]

"
I am an abstract tasker defining mandatory methods for all taskers. 
Tasker is responsible for collectin ${class:GtTaskerTask}$ tasks and executing them when requested. 

Mandatory methods are: 
- ${method:GtProtoTasker>>#addTask:|expanded=true}$
- ${method:GtProtoTasker>>#flush|expanded=true}$

Interesting taskers to explore are ${class:GtTaskerOrderedNonRepetitive}$ and ${class:GtPostponingTasker}$.
"
Class {
	#name : #GtProtoTasker,
	#superclass : #Object,
	#traits : 'TGtAssert',
	#classTraits : 'TGtAssert classTrait',
	#category : #'GToolkit-Utility-Tasker'
}

{ #category : #adding }
GtProtoTasker >> addTask: aTask [
	"Add task to a collection if appropriate."
	self subclassResponsibility
]

{ #category : #accessing }
GtProtoTasker >> flush [
	"Execute added tasks and eliminate them from a collection."
	self subclassResponsibility
]

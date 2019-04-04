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
	"Execute existing collection."
	self subclassResponsibility
]

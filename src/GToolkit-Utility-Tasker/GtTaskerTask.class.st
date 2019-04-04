Class {
	#name : #GtTaskerTask,
	#superclass : #Object,
	#traits : 'TGtAssert',
	#classTraits : 'TGtAssert classTrait',
	#category : #'GToolkit-Utility-Tasker-Tasker'
}

{ #category : #accessing }
GtTaskerTask class >> valuable: aValuable [
	^ GtTaskerValuableTask new valuable: aValuable
]

{ #category : #execution }
GtTaskerTask >> execute [
	self subclassResponsibility
]

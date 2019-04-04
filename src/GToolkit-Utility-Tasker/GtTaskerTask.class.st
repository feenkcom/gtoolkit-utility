"
I am an abstract class and I define an opperation to perform calling ${method:GtTaskerTask>>#execute}$. 
I am used by ${class:GtTasker}$ which collects me and decides when to execute me.

"
Class {
	#name : #GtTaskerTask,
	#superclass : #Object,
	#traits : 'TGtAssert',
	#classTraits : 'TGtAssert classTrait',
	#category : #'GToolkit-Utility-Tasker'
}

{ #category : #accessing }
GtTaskerTask class >> valuable: aValuable [
	^ GtTaskerValuableTask new valuable: aValuable
]

{ #category : #execution }
GtTaskerTask >> execute [
	self subclassResponsibility
]

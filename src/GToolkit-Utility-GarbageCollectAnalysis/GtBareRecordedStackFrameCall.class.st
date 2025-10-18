Class {
	#name : #GtBareRecordedStackFrameCall,
	#superclass : #Object,
	#instVars : [
		'selector',
		'methodClassRecord',
		'receiverClassRecord',
		'programCounter'
	],
	#category : #'GToolkit-Utility-GarbageCollectAnalysis'
}

{ #category : #'instance creation' }
GtBareRecordedStackFrameCall class >> forContext: aContext [
	^ self new 
		initializeForContext: aContext
]

{ #category : #printing }
GtBareRecordedStackFrameCall >> descriptionOn: aStream [
	self methodDescriptionOn: aStream.
	
	aStream nextPutAll: '; pc: '.
	aStream print: self programCounter.
]

{ #category : #views }
GtBareRecordedStackFrameCall >> gtViewTargetMethodSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		priority: 10;
		object: [ self targetMethodReference ];
		view: #gtSourceFor:
]

{ #category : #testing }
GtBareRecordedStackFrameCall >> hasDifferentReceiverClass [
	^ methodClassRecord ~= receiverClassRecord
]

{ #category : #accessing }
GtBareRecordedStackFrameCall >> initializeForContext: aContext [
	selector := aContext selector.
	methodClassRecord := GtBareRecordedClass forClass: aContext methodClass.
	receiverClassRecord := GtBareRecordedClass forClass: aContext receiver class.
	programCounter := aContext pc.
]

{ #category : #accessing }
GtBareRecordedStackFrameCall >> methodClassRecord [
	^ methodClassRecord
]

{ #category : #accessing }
GtBareRecordedStackFrameCall >> methodClassRecord: aRecordedClass [
	methodClassRecord := aRecordedClass
]

{ #category : #printing }
GtBareRecordedStackFrameCall >> methodDescription [
	^ String streamContents: [ :aStream |
		self methodDescriptionOn: aStream ]
]

{ #category : #printing }
GtBareRecordedStackFrameCall >> methodDescriptionOn: aStream [
	aStream nextPutAll: self receiverClassRecord targetClassName.
	self hasDifferentReceiverClass ifTrue: [
		 aStream nextPut: $(.
				aStream nextPutAll: self methodClassRecord targetClassName.
				aStream nextPut: $) ].
	aStream nextPutAll: '>>'.
	aStream nextPutAll: self selector.
]

{ #category : #printing }
GtBareRecordedStackFrameCall >> printOn: aStream [
	super printOn: aStream.

	aStream parenthesize: [
		self descriptionOn: aStream ]
]

{ #category : #accessing }
GtBareRecordedStackFrameCall >> programCounter [
	^ programCounter
]

{ #category : #accessing }
GtBareRecordedStackFrameCall >> programCounter: aProgramCounter [
	programCounter := aProgramCounter
]

{ #category : #accessing }
GtBareRecordedStackFrameCall >> receiverClassRecord [
	^ receiverClassRecord
]

{ #category : #accessing }
GtBareRecordedStackFrameCall >> receiverClassRecord: aRecordedClass [
	receiverClassRecord := aRecordedClass
]

{ #category : #accessing }
GtBareRecordedStackFrameCall >> selector [
	^ selector
]

{ #category : #accessing }
GtBareRecordedStackFrameCall >> selector: aSelector [
	selector := aSelector
]

{ #category : #accessing }
GtBareRecordedStackFrameCall >> targetMethodReference [
	^ RGMethodDefinition new
		name: self selector;
		parentName: self methodClassRecord targetClassName;
		isMeta: self methodClassRecord isMeta;
		asActive
]

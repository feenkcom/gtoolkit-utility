Class {
	#name : #GtProcessContextReport,
	#superclass : #Object,
	#instVars : [
		'contextDescription'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instace creation' }
GtProcessContextReport class >> fromContext: aContext [
	^self new 
		initializeFromContext: aContext
]

{ #category : #serialization }
GtProcessContextReport class >> leJsonV4Name [
	^ #gtProcessContentReport
]

{ #category : #accessing }
GtProcessContextReport >> contextDescription [
	^ contextDescription
]

{ #category : #accessing }
GtProcessContextReport >> contextDescription: aString [
	contextDescription := aString
]

{ #category : #'gt - extensions' }
GtProcessContextReport >> gtViewDescriptionFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Description';
		priority: 10;
		object: [ contextDescription ];
		view: #gtStringFor:
]

{ #category : #initialization }
GtProcessContextReport >> initializeFromContext: aContext [
	contextDescription := String streamContents: [ :aStream |
		aStream print:  aContext ] 
]

{ #category : #printing }
GtProcessContextReport >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream print: contextDescription]
]

Class {
	#name : #GtMessageTallyReport,
	#superclass : #Object,
	#instVars : [
		'textualContent'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtMessageTallyReport class >> fromMessageTally: aMessageTally [
	^ self new 
		initializeFromMessageTally: aMessageTally
]

{ #category : #serialization }
GtMessageTallyReport class >> leJsonV4Name [
	^ #gtMessageTallyReport
]

{ #category : #'gt - extensions' }
GtMessageTallyReport >> gtViewReportOn: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Content';
		object: [ textualContent ];
		view: #gtStringFor:
]

{ #category : #initialization }
GtMessageTallyReport >> initializeFromMessageTally: aMessageTally [ 
	textualContent := String streamContents: [ :aStream | 
		aMessageTally report: aStream ]
]

{ #category : #accessing }
GtMessageTallyReport >> textualContent [
	^ textualContent
]

{ #category : #accessing }
GtMessageTallyReport >> textualContent: aString [
	textualContent := aString
]

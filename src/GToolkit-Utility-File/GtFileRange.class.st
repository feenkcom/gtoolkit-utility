Class {
	#name : #GtFileRange,
	#superclass : #Object,
	#instVars : [
		'fileReference',
		'startIndex',
		'endIndex'
	],
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
GtFileRange >> endIndex [ 
	"Answer the character offset of the range end in the receiver's file"

	^ self subclassResponsibility
]

{ #category : #accessing }
GtFileRange >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtFileRange >> startIndex [ 
	"Answer the character offset of the range start in the receiver's file"

	^ self subclassResponsibility
]

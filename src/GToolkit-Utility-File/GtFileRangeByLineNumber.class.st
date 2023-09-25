Class {
	#name : #GtFileRangeByLineNumber,
	#superclass : #GtFileRange,
	#instVars : [
		'startLine',
		'startColumn',
		'endLine',
		'endColumn'
	],
	#category : #'GToolkit-Utility-File'
}

{ #category : #'instance creation' }
GtFileRangeByLineNumber class >> file: aFileReference startLine: startLineNumber startColumn: startColumnNumber endLine: endLineNumber endColumn: endColumnNumber [

	^ self new
		initializeFile: aFileReference 
		startLine: startLineNumber 
		startColumn: startColumnNumber 
		endLine: endLineNumber 
		endColumn: endColumnNumber
]

{ #category : #accessing }
GtFileRangeByLineNumber >> endColumn [
	^ endColumn
]

{ #category : #accessing }
GtFileRangeByLineNumber >> endIndex [ 

	^ endIndex ifNil: 
		[ self getOffsets.
		endIndex ]
]

{ #category : #accessing }
GtFileRangeByLineNumber >> endLine [
	^ endLine
]

{ #category : #private }
GtFileRangeByLineNumber >> getOffsets [
	| indexes |

	indexes := fileReference readStreamDo: [ :stream |
		stream gtIndexOfLineNumbers: { 
			startLine. 
			(startLine = endLine and: [ endColumn = 0 ])
				ifTrue: [ endLine+1 ]
				ifFalse: [ endLine ]. } ].
	startIndex := indexes first + startColumn.
	endIndex := indexes second + endColumn.
]

{ #category : #initialization }
GtFileRangeByLineNumber >> initializeFile: aFileReference startLine: startLineNumber startColumn: startColumnNumber endLine: endLineNumber endColumn: endColumnNumber [

	fileReference := aFileReference.
	startLine := startLineNumber.
	endLine := endLineNumber.
	startColumn := startColumnNumber.
	endColumn := endColumnNumber.
]

{ #category : #accessing }
GtFileRangeByLineNumber >> startColumn [
	^ startColumn
]

{ #category : #accessing }
GtFileRangeByLineNumber >> startIndex [ 

	^ startIndex ifNil: 
		[ self getOffsets.
		startIndex ]
]

{ #category : #accessing }
GtFileRangeByLineNumber >> startLine [
	^ startLine
]

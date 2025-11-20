Class {
	#name : #GtPharoDebugLogInspector,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#category : #'GToolkit-PharoDebug-Model'
}

{ #category : #accessing }
GtPharoDebugLogInspector >> file [
	^ file
]

{ #category : #accessing }
GtPharoDebugLogInspector >> file: anObject [
	file := anObject
]

{ #category : #'as yet unclassified' }
GtPharoDebugLogInspector >> gtViewEntriesFor: aView [
	<gtView>

	^ aView list
		title: 'Entries';
		priority: 10;
		items: [ self parseLogEntries ]
]

{ #category : #'as yet unclassified' }
GtPharoDebugLogInspector >> initialize [

	super initialize.
	file := 'PharoDebug.log' asFileReference
]

{ #category : #private }
GtPharoDebugLogInspector >> parseLogEntries [
	| startIndex entries linePosition |

	startIndex := -1.
	entries := OrderedCollection new.
	file readStreamDo: [ :stream |
		[ stream atEnd ] whileFalse:
			[ | line |
			linePosition := stream position.
			line := stream nextLine.
			(line trimBoth = 'THERE_BE_DRAGONS_HERE') ifTrue:
				[ startIndex > 0 ifTrue:
					[ entries add: (GtPharoDebugLogEntry new
						logInspector: self;
						startIndex: startIndex;
						endIndex: linePosition -1) ].
					startIndex := linePosition. ] ] ].
	entries add: (GtPharoDebugLogEntry new
		logInspector: self;
		startIndex: startIndex;
		endIndex: linePosition -1).
	^ entries
]

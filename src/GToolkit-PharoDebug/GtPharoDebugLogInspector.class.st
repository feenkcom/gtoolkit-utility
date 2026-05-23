Class {
	#name : #GtPharoDebugLogInspector,
	#superclass : #Object,
	#instVars : [
		'source'
	],
	#category : #'GToolkit-PharoDebug-Model'
}

{ #category : #views }
GtPharoDebugLogInspector class >> gtViewCurrentLogFor: aView [ 
	<gtView>
	<gtClassView>
	
	^ aView forward 
			title: 'Default ', Smalltalk logFileName;
			priority: 10;
			object: [ self logInspectorForCurrentPharoDebugFile ];
			view: #gtViewEntriesFor:;
			actionButtonIcon: BrGlamorousVectorIcons inspect 
				tooltip: 'Inspect instance' 
				action: [ :aButton | aButton phlow 
					spawnObject: self logInspectorForCurrentPharoDebugFile ]
]

{ #category : #accessing }
GtPharoDebugLogInspector class >> logInspectorForCurrentPharoDebugFile [
	^ self new 
		file: FileLocator imageDirectory  /  Smalltalk logFileName
]

{ #category : #'api - initialization' }
GtPharoDebugLogInspector >> file: aFileReference [
	source := GtPharoDebugLogFileSource new file: aFileReference
]

{ #category : #'gt - extensions' }
GtPharoDebugLogInspector >> gtViewEntriesFor: aView [
	<gtView>

	^ aView list
		title: 'Entries';
		priority: 10;
		items: [ self parseLogEntries ]
]

{ #category : #initialization }
GtPharoDebugLogInspector >> initialize [

	super initialize.
	source := GtPharoDebugLogFileSource new file: 'PharoDebug.log' asFileReference
]

{ #category : #private }
GtPharoDebugLogInspector >> parseLogEntries [
	| startIndex entries linePosition |

	startIndex := -1.
	entries := OrderedCollection new.
	source readStreamDo: [ :stream |
		[ stream atEnd ] whileFalse:
			[ | line |
			linePosition := stream position.
			line := stream nextLine.
			(line trimBoth = 'THERE_BE_DRAGONS_HERE') ifTrue:
				[ startIndex >= 0 ifTrue:
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

{ #category : #accessing }
GtPharoDebugLogInspector >> source [
	<return: #GtPharoDebugLogSource>
	^ source
]

{ #category : #'api - initialization' }
GtPharoDebugLogInspector >> string: aString [
	source := GtPharoDebugLogStringSource new string: aString
]

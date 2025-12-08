Class {
	#name : #GtPharoDebugLogEntry,
	#superclass : #Object,
	#instVars : [
		'logInspector',
		'startIndex',
		'endIndex',
		'timestamp',
		'frames'
	],
	#category : #'GToolkit-PharoDebug-Model'
}

{ #category : #accessing }
GtPharoDebugLogEntry >> contents [
	^ logInspector source readStreamDo: [ :stream | 
			stream position: (startIndex = -1 
				ifTrue: [ 0 ] 
				ifFalse: [ startIndex ]).
			stream next: endIndex - startIndex ]
]

{ #category : #accessing }
GtPharoDebugLogEntry >> description [
	| stream |

	stream := self contents readStream.
	^ ([ stream
			nextLine;
			nextLine ]
				ensure: [ stream close ]) ifEmpty:
					[ '<no description>' ]
]

{ #category : #accessing }
GtPharoDebugLogEntry >> endIndex [
	^ endIndex
]

{ #category : #accessing }
GtPharoDebugLogEntry >> endIndex: anObject [
	endIndex := anObject
]

{ #category : #accessing }
GtPharoDebugLogEntry >> frames [

	^ frames ifNil: [ frames := self parseFrames ]
]

{ #category : #ui }
GtPharoDebugLogEntry >> gtContentsFor: aView [
	<gtView>
	
	^ aView text
		title: 'Contents';
		priority: 10;
		text: [ self contents ]
]

{ #category : #ui }
GtPharoDebugLogEntry >> gtViewFramesFor: aView [
	<gtView>

	^ aView list
		title: 'Frames';
		priority: 20;
		items: [ self frames ]
]

{ #category : #'as yet unclassified' }
GtPharoDebugLogEntry >> initialize [

	super initialize.
	"The timestamp can be nil.  Use self as a not-calculated marker."
	timestamp := self.
]

{ #category : #accessing }
GtPharoDebugLogEntry >> logInspector [
	^ logInspector
]

{ #category : #accessing }
GtPharoDebugLogEntry >> logInspector: anObject [
	logInspector := anObject
]

{ #category : #private }
GtPharoDebugLogEntry >> parseFrames [
	"Make a best-effort attempt to parse the receiver's text in to the appropriate stack frames.
	Frames are delimited by 2 blank lines followed by a line that the first character is not white space."
	| newFrames frameContent contents lines line lineStream inFrame blankCount |

	newFrames := OrderedCollection new.
	contents := self contents.
	frameContent := (String new: contents size) writeStream.
	lines := contents lines.
	contents := nil.
	inFrame := false.
	lineStream := lines readStream.
	line := ''.
	blankCount := 0.
	"The header is terminated by the 'Pharo Image:' line"
	[ line beginsWith: 'Pharo Image: ' ] whileFalse:
		[ line := lineStream next ].
	line := lineStream next.
	"Skip blank lines"
	[ line isEmpty ] whileTrue:
		[ line := lineStream next ].
	[ lineStream atEnd ] whileFalse:
		[ frameContent 
			nextPutAll: line;
			cr.
		line := lineStream next.
		line 
			ifEmpty: [ blankCount := blankCount + 1 ]
			ifNotEmpty: [ blankCount := 0 ].
		blankCount >= 2 ifTrue:
			[ | peek |
			peek := lineStream peek.
			peek ifNotEmpty:
				[ peek first isSeparator ifFalse:
					[ newFrames add: (GtPharoDebugLogFrame content: frameContent contents).
			frameContent reset ] ] ] ].
	^ newFrames.
]

{ #category : #printing }
GtPharoDebugLogEntry >> printOn: aStream [
	| ts |

	(logInspector isNil or: [ logInspector source isNil ]) ifTrue:
		[ ^ super printOn: aStream ].

	ts := self timestamp
		ifNil: [ '<unknown time>' ]
		ifNotNil: [ (ZTimestampFormat fromString: '2001-02-03 16:05:06+00:00') 
									timezone: ZTimezone current; 
									format: timestamp ].
	aStream 
		<< ts;
		<< ': ';
		<< self description
]

{ #category : #accessing }
GtPharoDebugLogEntry >> startIndex [
	^ startIndex
]

{ #category : #accessing }
GtPharoDebugLogEntry >> startIndex: anObject [
	startIndex := anObject
]

{ #category : #accessing }
GtPharoDebugLogEntry >> timestamp [

	^ timestamp == self ifTrue:
			[ | lines ts |
			lines := self contents lines.
			ts := (lines first: (20 min: lines size)) detect: [ :line |
						([ ZTimestamp fromString: line ] on: Error do: []) isNotNil ]
					ifFound: [ :match | ZTimestamp fromString: match ]
					ifNone: [ ZTimestamp epoch ].
			(ts year between: 2025 and: 2100) ifFalse:
				[ ts := nil ].
			timestamp := ts ]
		ifFalse:
			[ timestamp ].
]

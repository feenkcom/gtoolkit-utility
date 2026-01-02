Extension { #name : #DateAndTime }

{ #category : #'*GToolkit-Utility-System' }
DateAndTime >> asIso8601 [
	"Answer the receiver in ISO 8601 format"
	| utc |

	^ String streamContents: [ :stream |
		utc := self asUTC.
		utc printYMDOn: stream.
		stream nextPut: $T.
		utc printHMSOn: stream.
		stream nextPut: $Z ].

]

{ #category : #'*GToolkit-Utility-System' }
DateAndTime >> asLocalStringYMDHMS [
	^ self asLocal asStringYMDHMS
]

{ #category : #'*GToolkit-Utility-System' }
DateAndTime >> asStringYMDHMS [
	^ String streamContents: [ :aStream |
		self printYMDOn: aStream.
		aStream nextPut: Character space.
		self hour printOn: aStream base: 10 length: 2 padded: true.
		aStream nextPut: $:.
		self minute printOn: aStream base: 10 length: 2 padded: true.
		aStream nextPut: $:.
		self second printOn: aStream base: 10 length: 2 padded: true ]
]

{ #category : #'*GToolkit-Utility-System' }
DateAndTime class >> gtIsISO8601: aString [
	"Answer a boolean indicating whether the supplied string matches ISO8601 format"

	^ '(\d+)-(\d+)-(\d+)T(\d+)\:(\d+)\:(\d+)(\.(\d+))?([-+]\d+\:\d+|Z)?' asRegex 
		matches: aString

]

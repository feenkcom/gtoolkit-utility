Extension { #name : #DateAndTime }

{ #category : #'*GToolkit-Utility-System' }
DateAndTime class >> gtIsISO8601: aString [
	"Answer a boolean indicating whether the supplied string matches ISO8601 format"

	^ '(\d+)-(\d+)-(\d+)T(\d+)\:(\d+)\:(\d+)(\.(\d+))?([-+]\d+\:\d+|Z)?' asRegex 
		matches: aString

]

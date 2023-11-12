Extension { #name : #Duration }

{ #category : #'*GToolkit-Utility-System' }
Duration >> gtHumanReadableString [
	self < 0 seconds ifTrue: [ ^ '-', self negated gtHumanReadableString ].
	self < 1 minute ifTrue: [ ^ self seconds asString, 's' ].
	self < 1 hour ifTrue: [ ^ self minutes asString , 'm ', self seconds asString, 's' ].
	self < 1 day ifTrue: [ ^ self hours asString , 'h ', self minutes asString, 'm' ].
	self < 1 year ifTrue: [ ^ self days asString , 'd ', self hours asString, 'h' ].
	^ self printString
]

{ #category : #'*GToolkit-Utility-System' }
Duration >> gtShortPrintOn: aStream [
	"Print the receiver in a compact format, omitting leading 0s."
	"Format as per ANSI 5.8.2.16: [-]D:HH:MM:SS[.S]"
 	| d h m s ms secondsOnly |

	d := self days abs.
	h := self hours abs.
	m := self minutes abs.
	s := self seconds abs truncated.
	secondsOnly := (d + h + m) = 0.
	ms := (self nanoSeconds abs / 1000000) rounded.
	self negative ifTrue: [ aStream nextPut: $- ].
	d > 0 ifTrue:
		[ d printOn: aStream. aStream nextPut: $: ].
	(d > 0 or: [ h > 0 ]) ifTrue:
		[ h < 10 ifTrue: [ aStream nextPut: $0. ].
		h printOn: aStream. aStream nextPut: $: ].
	(d > 0 or: [ h > 0 or: [ m > 0 ]]) ifTrue:
		[ m < 10 ifTrue: [ aStream nextPut: $0. ].
		m printOn: aStream. aStream nextPut: $: ].
	(secondsOnly not and: [ s < 10 ]) ifTrue: [ aStream nextPut: $0. ].
	s printOn: aStream.
	ms = 0 ifFalse:
		[ aStream nextPut: $..
		aStream << (ms printPaddedWith: $0 to: 3) ].
	aStream nextPut: $s.

]

{ #category : #'*GToolkit-Utility-System' }
Duration >> gtShortPrintString [

	^ String streamContents: [ :stream |
		self gtShortPrintOn: stream ]
]

Class {
	#name : #GtRobocoderMetamodelScanner,
	#superclass : #SmaCCScanner,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #'generated-initialization' }
GtRobocoderMetamodelScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(3 'and' 13) #(3 'false' 19) #(3 'items' 16) #(3 'true' 18))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> andId [
	^ 13
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> emptySymbolTokenId [
	^ 51
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> errorTokenId [
	^ 52
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> followsId [
	^ 4
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan1 [
	self step.
	currentCharacter == $#
		ifTrue: [ self step ].
	currentCharacter == $'
		ifTrue: [ ^ self scan2 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(11).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or: [ '\|~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan3 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan2 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(11).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan2 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan3 [
	[ self recordMatch: #(11).
	self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(11).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan4 ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan5 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan4 [
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(11).
			self step.
			currentCharacter == $:
				ifTrue: [ self step.
					currentCharacter == $:
						ifTrue: [ ^ self scan4 ].
					^ self reportLastMatch ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan5 [
	[ self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(11).
			self step.
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan5 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan6 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(12).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan6 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan7 [
	self step.
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scanForToken [
	scope == #literalArray
		ifTrue:
			[ ^ self scanForTokenX1 ].
	scope == #default
		ifTrue: [ self step.
			currentCharacter == $#
				ifTrue: [ ^ self scan1 ].
			currentCharacter == $'
				ifTrue: [ ^ self scan6 ].
			currentCharacter == $(
				ifTrue: [ ^ self recordAndReportMatch: #(7) ].
			currentCharacter == $)
				ifTrue: [ ^ self recordAndReportMatch: #(6) ].
			currentCharacter == $,
				ifTrue: [ ^ self recordAndReportMatch: #(10) ].
			currentCharacter == $.
				ifTrue: [ ^ self recordAndReportMatch: #(8) ].
			currentCharacter == $:
				ifTrue: [ ^ self recordAndReportMatch: #(9) ].
			currentCharacter == $<
				ifTrue: [ ^ self recordAndReportMatch: #(14) ].
			currentCharacter == $=
				ifTrue: [ ^ self scan7 ].
			currentCharacter == $>
				ifTrue: [ ^ self recordAndReportMatch: #(15) ].
			currentCharacter == $@
				ifTrue: [ ^ self recordAndReportMatch: #(17) ].
			currentCharacter == ${
				ifTrue: [ ^ self recordAndReportMatch: #(1) ].
			currentCharacter == $}
				ifTrue: [ ^ self recordAndReportMatch: #(2) ].
			(currentCharacter isSeparator
				or: [ currentCharacter == Character null
						or: [ currentCharacter == Character pageUp ] ])
				ifTrue:
					[ ^ self scanForTokenX2 ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue:
					[ self scanForTokenX3 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $#
		ifTrue: [ ^ self scan1 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan6 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	currentCharacter == $=
		ifTrue: [ ^ self scan7 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue: [ [ self recordMatch: #(5).
			self step.
			currentCharacter isSeparator
				or: [ currentCharacter == Character null
						or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(3).
			self step.
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scanForTokenX2 [
	[ self recordMatch: #(5).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scanForTokenX3 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> tokenActions [
	^ #(nil nil nil nil #whitespace)
]

Class {
	#name : #GtViewModelScanner,
	#superclass : #SmaCCScanner,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #'generated-initialization' }
GtViewModelScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(3 'and' 13) #(3 'items' 16))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GtViewModelScanner >> andId [
	^ 13
]

{ #category : #generated }
GtViewModelScanner >> emptySymbolTokenId [
	^ 45
]

{ #category : #generated }
GtViewModelScanner >> errorTokenId [
	^ 46
]

{ #category : #generated }
GtViewModelScanner >> followsId [
	^ 4
]

{ #category : #generated }
GtViewModelScanner >> scan1 [
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
GtViewModelScanner >> scan2 [
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
GtViewModelScanner >> scan3 [
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
GtViewModelScanner >> scan4 [
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
GtViewModelScanner >> scan5 [
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
GtViewModelScanner >> scan6 [
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
GtViewModelScanner >> scan7 [
	self step.
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtViewModelScanner >> scanForToken [
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
GtViewModelScanner >> scanForTokenX1 [
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
GtViewModelScanner >> scanForTokenX2 [
	[ self recordMatch: #(5).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtViewModelScanner >> scanForTokenX3 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue
]

{ #category : #generated }
GtViewModelScanner >> tokenActions [
	^ #(nil nil nil nil #whitespace)
]

Class {
	#name : #GtNavigationViewModelScanner,
	#superclass : #SmaCCScanner,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #'generated-initialization' }
GtNavigationViewModelScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(3 'and' 12))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GtNavigationViewModelScanner >> andId [
	^ 12
]

{ #category : #generated }
GtNavigationViewModelScanner >> emptySymbolTokenId [
	^ 35
]

{ #category : #generated }
GtNavigationViewModelScanner >> errorTokenId [
	^ 36
]

{ #category : #generated }
GtNavigationViewModelScanner >> followsId [
	^ 4
]

{ #category : #generated }
GtNavigationViewModelScanner >> nameId [
	^ 3
]

{ #category : #generated }
GtNavigationViewModelScanner >> scan1 [
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
GtNavigationViewModelScanner >> scan2 [
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
GtNavigationViewModelScanner >> scan3 [
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
GtNavigationViewModelScanner >> scan4 [
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
GtNavigationViewModelScanner >> scan5 [
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
GtNavigationViewModelScanner >> scan6 [
	self step.
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtNavigationViewModelScanner >> scanForToken [
	scope == #literalArray
		ifTrue:
			[ ^ self scanForTokenX1 ].
	scope == #default
		ifTrue: [ self step.
			currentCharacter == $#
				ifTrue: [ ^ self scan1 ].
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
				ifTrue: [ ^ self recordAndReportMatch: #(13) ].
			currentCharacter == $=
				ifTrue: [ ^ self scan6 ].
			currentCharacter == $>
				ifTrue: [ ^ self recordAndReportMatch: #(14) ].
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
GtNavigationViewModelScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $#
		ifTrue: [ ^ self scan1 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	currentCharacter == $=
		ifTrue: [ ^ self scan6 ].
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
GtNavigationViewModelScanner >> scanForTokenX2 [
	[ self recordMatch: #(5).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtNavigationViewModelScanner >> scanForTokenX3 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue
]

{ #category : #generated }
GtNavigationViewModelScanner >> tokenActions [
	^ #(nil nil nil nil #whitespace)
]

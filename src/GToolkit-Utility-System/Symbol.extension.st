Extension { #name : #Symbol }

{ #category : #'*GToolkit-Utility-System' }
Symbol >> cull: anObject cull: secondArg [
	^ anObject perform: self withEnoughArguments: { secondArg }
]

{ #category : #'*GToolkit-Utility-System' }
Symbol >> cull: anObject cull: secondArg cull: thirdArg [
	^anObject perform: self withEnoughArguments: { secondArg. thirdArg }
]

{ #category : #'*GToolkit-Utility-System' }
Symbol >> cull: anObject cull: secondArg cull: thirdArg cull: fourthArg [
	^anObject perform: self withEnoughArguments: { secondArg. thirdArg. fourthArg }
]

{ #category : #'*GToolkit-Utility-System' }
Symbol >> gtAsReader [
	"The opposite of #asMutator"
	
	^ (String streamContents: [ :aStream |
		(self splitOn: ':') withIndexDo: [ :each : index |
			aStream nextPutAll: (index > 1
				ifTrue: [ each capitalized ]
				ifFalse: [ each ]) ] ]) asSymbol
]

{ #category : #'*GToolkit-Utility-System' }
Symbol >> gtValueWithArgs: anArray [
	anArray size < 1
		ifTrue: [ ^ nil ].
	^ anArray first perform: self
]

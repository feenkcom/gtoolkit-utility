Extension { #name : 'Symbol' }

{ #category : '*GToolkit-Utility-System' }
Symbol >> gtAsReader [
	"The opposite of #asMutator"
	
	^ (String streamContents: [ :aStream |
		(self splitOn: ':') withIndexDo: [ :each : index |
			aStream nextPutAll: (index > 1
				ifTrue: [ each capitalized ]
				ifFalse: [ each ]) ] ]) asSymbol
]

{ #category : '*GToolkit-Utility-System' }
Symbol >> gtValueWithArgs: anArray [
	anArray size < 1
		ifTrue: [ ^ nil ].
	^ anArray first perform: self
]

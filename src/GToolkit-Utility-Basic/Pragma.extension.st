Extension { #name : #Pragma }

{ #category : #'*GToolkit-Utility-Basic' }
Pragma class >> hasNamed: aSymbol from: aSubClass to: aSuperClass [

	"Answer true if a method between aSubClass and aSuperClass (inclusive) has pragma named aSymbol.
	False otherwise."

	aSubClass withAllSuperclassesDo: [ :class | 
		class pragmasDo: [ :pragma | 
			pragma selector = aSymbol ifTrue: [ ^ true ] ].
		aSuperClass = class ifTrue: [ ^ false ] ].

	^ false
]

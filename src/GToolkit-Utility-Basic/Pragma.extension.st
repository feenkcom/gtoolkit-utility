Extension { #name : #Pragma }

{ #category : #'*GToolkit-Utility-Basic' }
Pragma class >> allNamed: aSymbol from: aSubClass toButExcluding: aSuperClass [
	"Answer a collection of all pragmas found in methods of all classes between aSubClass and aSuperClass (exclusive) whose keyword is aSymbol."

	^ Array
		streamContents: [ :stream |
			aSubClass
				withAllSuperclassesDo: [ :class |
					aSuperClass = class
						ifTrue: [ ^ stream contents ].
					class pragmasDo: [ :pragma |
							pragma selector = aSymbol
								ifTrue: [ stream nextPut: pragma ] ] ] ]
]

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

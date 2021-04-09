Class {
	#name : #GtGeneratorUtilities,
	#superclass : #Object,
	#category : #'GToolkit-MVVM-Support'
}

{ #category : #conversion }
GtGeneratorUtilities class >> camelCaseToSentence: aString [
	^ String streamContents: [ :aStream | 
		aString gtPiecesCutWhereCamelCase 
			do: [ :eachPiece | aStream nextPutAll: eachPiece asLowercase ]
			separatedBy: [ aStream nextPut: Character space ] ]
]

{ #category : #conversion }
GtGeneratorUtilities class >> formatString: aString mapping: aDictionaryOfReplacements [
	| aFormattedString |
	
	aFormattedString := aString.
	aDictionaryOfReplacements associationsDo: [ :eachAssociation |
		aFormattedString := aFormattedString copyReplaceAll: eachAssociation key with: eachAssociation value ].
	^ aFormattedString
]

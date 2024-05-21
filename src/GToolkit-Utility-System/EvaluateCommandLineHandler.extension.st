Extension { #name : #EvaluateCommandLineHandler }

{ #category : #'*GToolkit-Utility-System' }
EvaluateCommandLineHandler >> argumentString [
	<gtPharoPatch: #Pharo>
	
	^ (self filterArguments: self arguments) joinUsing: Character space.
]

{ #category : #'*GToolkit-Utility-System' }
EvaluateCommandLineHandler >> filterArguments: aSequenceableCollection [
	| inputStream |

	inputStream := aSequenceableCollection readStream.

	^ Array streamContents: [ :stream |
		[ inputStream atEnd ] whileFalse:
			[ | arg |
			arg := inputStream next.
			(self includeArgument: arg from: inputStream) ifTrue:
				[ stream nextPut: arg ] ] ].
]

{ #category : #'*GToolkit-Utility-System' }
EvaluateCommandLineHandler >> includeArgument: arg from: inputStream [

	(#( '--no-quit' '--save' '-e' '--evaluate') includes: arg) ifTrue: [ ^ false ].

	arg = '--pharoDebugLog' ifTrue:
		[ inputStream atEnd ifFalse: [ inputStream next ].
		^ false ].

	^ true
]

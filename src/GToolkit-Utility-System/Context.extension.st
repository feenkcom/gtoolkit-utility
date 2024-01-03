Extension { #name : #Context }

{ #category : #'*GToolkit-Utility-System' }
Context >> message [
	"Answer the receiver's selector and arguments as a Message"

	^ Message
		selector: self selector 
		arguments: self arguments
]

{ #category : #'*GToolkit-Utility-System' }
Context >> stackString [

	^ String streamContents: [ :stream | 
		self stack do: [ :stackItem | 
			stream
				print: stackItem;
				cr ] ]
]

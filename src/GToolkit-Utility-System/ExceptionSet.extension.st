Extension { #name : #ExceptionSet }

{ #category : #'*GToolkit-Utility-System' }
ExceptionSet class >> withClassNames: classNames [
	"Answer an instance of the receiver with the classes that exist in the image included.
	This allows compatibility between versions of GT where exception classes are added or removed."

	^ classNames inject: self new into: [ :set :each |
		(Smalltalk globals includesKey: each) ifTrue: 
			[ set
				add: (Smalltalk at: each);
				yourself ]
		ifFalse: 
			[ set ] ]
]

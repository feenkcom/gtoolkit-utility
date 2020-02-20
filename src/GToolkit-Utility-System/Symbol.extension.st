Extension { #name : #Symbol }

{ #category : #'*GToolkit-Utility-System' }
Symbol >> gtValueWithArgs: anArray [
	anArray size < 1
		ifTrue: [ ^ nil ].
	^ anArray first perform: self
]

Extension { #name : #Number }

{ #category : #'*GToolkit-Utility-Basic' }
Number >> gtDisplayStringIfNotZero [
	^ self isZero ifTrue: [ '' ] ifFalse: [ self gtDisplayString ]
]

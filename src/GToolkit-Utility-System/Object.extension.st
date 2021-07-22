Extension { #name : #Object }

{ #category : #'*GToolkit-Utility-System' }
Object >> forPharo8: aPharo8Block forPharo9: aPharo9Block [
	SystemVersion current major = 8 ifTrue: [
		^ aPharo8Block value ].
	SystemVersion current major = 9 ifTrue: [
		^ aPharo9Block value ].
	^ AssertionFailure signal: 'Pharo version not recognized'
]

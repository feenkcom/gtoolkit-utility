Extension { #name : #ZnClient }

{ #category : #'*GToolkit-Utility-URL' }
ZnClient >> get: anUrl onSuccess: aSuccessBlock onError: anErrorBlock [
	| result |
	result := self get: anUrl.
	^ self isSuccess 
		ifTrue: [ aSuccessBlock value: result ]
		ifFalse: [ anErrorBlock value ]
]

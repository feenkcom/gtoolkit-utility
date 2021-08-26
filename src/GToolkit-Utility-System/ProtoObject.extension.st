Extension { #name : 'ProtoObject' }

{ #category : '*GToolkit-Utility-System' }
ProtoObject >> gtValue: anObject [
	| args |
	args := anObject asGlamorousArray.
	^ self gtValueWithArgs: args
]

{ #category : '*GToolkit-Utility-System' }
ProtoObject >> gtValueWithArgs: anArray [
	^ self
]

Extension { #name : #Duration }

{ #category : #'*GToolkit-Utility-System' }
Duration >> gtHumanReadableString [
	self < 1 minute ifTrue: [ ^ self seconds asString, 's' ].
	self < 1 hour ifTrue: [ ^ self minutes asString , 'm ', self seconds asString, 's' ].
	self < 1 day ifTrue: [ ^ self hours asString , 'h ', self minutes asString, 'm' ].
	self < 1 year ifTrue: [ ^ self days asString , 'd ', self hours asString, 'h' ].
	^ self printString
]

Extension { #name : 'Number' }

{ #category : '*GToolkit-Utility-System' }
Number >> asStringWithCommas [
	^ (self round: 0) asInteger asStringWithCommas
]

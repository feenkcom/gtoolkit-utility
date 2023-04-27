Extension { #name : #Collection }

{ #category : #'*GToolkit-Utility-System' }
Collection >> select: selectBlock thenFlatCollect: collectBlock [
	"Utility method to improve readability."

	^ (self select: selectBlock) flatCollect: collectBlock
]

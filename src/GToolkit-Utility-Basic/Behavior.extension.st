Extension { #name : #Behavior }

{ #category : #'*GToolkit-Utility-Basic' }
Behavior >> allAbstractMethods [
	| allSelectors |
	allSelectors := (self withAllSuperclasses flatCollect: [ :cls | cls selectors ]) asSet.
	^ allSelectors asArray
		collect: [ :selector | self lookupSelector: selector ]
		thenSelect: [ :method | method isAbstract ]
]

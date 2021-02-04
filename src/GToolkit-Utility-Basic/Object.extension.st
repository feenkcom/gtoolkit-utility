Extension { #name : #Object }

{ #category : #'*GToolkit-Utility-Basic' }
Object >> allAbstractMethods [
	| allClasses allAbstractMethods allAbstractMethodsFromSuperclasses |
	allClasses := (self withDeepCollect: #superclass).
	allAbstractMethods := allClasses flatCollect: 
		[:c| c methods select: [:m | m isAbstract ]].
		"we now have all abstract methods, but some of them may have been implemented in a subclass"
	
	allAbstractMethodsFromSuperclasses := allAbstractMethods select: [:m | 
		((allClasses 
			flatCollect: [:c |c  localSelectors]) 
			"if we only find it once then our subclass needs to implement it"
			select: [:s | s = m selector] ) size = 1].
	^ allAbstractMethodsFromSuperclasses union: (self class methods select: [:m | m isAbstract])
]

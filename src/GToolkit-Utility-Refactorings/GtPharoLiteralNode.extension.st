Extension { #name : #GtPharoLiteralNode }

{ #category : #'*GToolkit-Utility-Refactorings' }
GtPharoLiteralNode >> gtIsBaselinePackageName [
	(self isString or: [ self isSymbol ]) ifFalse: [ ^ false ].
	RPackageOrganizer default packageNamed: self literalValue ifAbsent: [ ^ false ].
	self topParent
		withAllNodesDo: [ :each | 
			(each isErrorNode not
				and: [ (each isSymbol or: [ each isString ])
						and: [ each literalValue = self literalValue ] ])
				ifTrue: [ each parent isMessage
						ifTrue: [ | index |
							index := each parent arguments identityIndexOf: each.
							index > 0
								ifTrue: [ (each parent selectorParts at: index) source = 'baseline:' ifTrue: [ ^ false ] ] ] ] ].
	^ true
]

Extension { #name : 'CompiledMethod' }

{ #category : '*GToolkit-Utility-System' }
CompiledMethod >> gtIsOverridingUpTo: aSuperclass [

	^ (self origin allSuperclassesIncluding: aSuperclass)
		anySatisfy: [ :aClass | aClass includesSelector: self selector ]
]

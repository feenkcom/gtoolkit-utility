Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Utility-System' }
CompiledMethod >> gtIsOverridingUpTo: aSuperclass [

	^ (self origin allSuperclassesIncluding: aSuperclass)
		anySatisfy: [ :aClass | aClass includesSelector: self selector ]
]

{ #category : #'*GToolkit-Utility-System' }
CompiledMethod >> isSourceSearchable [
	"Other projects may change this method to skip methods:
	- that do not have access to their source code, or
	- there are other challenges to access their source code."

	^ true
]

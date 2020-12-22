Extension { #name : #BaselineOf }

{ #category : #'*GToolkit-Utility-BaselineOf' }
BaselineOf >> repository: aRepositoryString for: spec [
	"Preferably load from the on-disk repository if it exists, otherwise clone (or fetch) it"
	| aRepository |

	aRepository := self class environment
		at: spec root className asSymbol
		ifPresent: [ :aBaselineClass | self class repositoryOf: aBaselineClass default: aRepositoryString ]
		ifAbsent: [ aRepositoryString ].

	spec repository: aRepository
]

{ #category : #'*GToolkit-Utility-BaselineOf' }
BaselineOf class >> repositoryOf: aBaselineClass default: aDefaultString [
	^ (IceRepository registeredRepositoryIncludingPackage: aBaselineClass package)
		ifNil: [ aDefaultString ]
		ifNotNil: [ :anIcebergRepository |
		anIcebergRepository
			locationIfPresent: [ :location | anIcebergRepository properties fileFormat id asString, '://', location fullPath fullName, '/', anIcebergRepository subdirectory ]
			ifAbsent: [ anIcebergRepository description ] ]
]

{ #category : #'*GToolkit-Utility-BaselineOf' }
BaselineOf >> thisRepositoryFor: spec [
	"Load from the very same repository as this baseline"
	| thisRepository |

	thisRepository := self class repositoryOf: self class default: nil.

	spec repository: thisRepository
]

Extension { #name : #RPackageOrganizer }

{ #category : #'*GToolkit-Utility-System' }
RPackageOrganizer >> gtSortedPackages [
	"Return all packages in alphabetical ascending order"
	| thePackagesArray |
	
	thePackagesArray := self packageNames
		collect: [ :each | self packageNamed: each ]
		as: Array.
	
	^ SortedCollection new
		sortBlock: [ :a :b | a name < b name ];
		setContents: thePackagesArray;
		yourself
]

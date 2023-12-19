"
I extend {{gtClass:SpaceTally}} with extra information by using for tally items {{gtClass:GtSpaceTallyItem}}.
"
Class {
	#name : #GtSpaceTally,
	#superclass : #SpaceTally,
	#instVars : [
		'label'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #fileout }
GtSpaceTally >> computeSpaceUsageResultsForClassesInstancesAssociations: aCollectionOfClasses [
	results := SpaceTallyResult new: aCollectionOfClasses size.
	aCollectionOfClasses associations
		do: [ :assoc | 
			| instances class |
			instances := assoc value.
			class := assoc key.
			class isMeta
				ifFalse: [ results
						addItem:
							((GtSpaceTallyItem
								analyzedClassName: class name
								codeSize: class spaceUsed
								instanceCount: instances size
								spaceForInstances: (instances sum: [ :each | each sizeInMemory ]))
									analyzedPackageName: class package name) ] ]
]

{ #category : #'gt - extensions' }
GtSpaceTally >> gtViewPackageTalliesFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Tallies (by package)';
		items:  [ self packageTallies 
			sorted: [ :aPackageTally | aPackageTally totalInstSpace ] descending ];
		column: 'Package Name' text: [ :aPackageTally | 
			aPackageTally analyzedPackageName ];
		column: 'Instance count' text: [ :aPackageTally | 
			aPackageTally totalInstCount ];
		column: 'Instances Size' text: [ :aPackageTally | 
			aPackageTally totalInstSpace humanReadableIsqByteSize ]
]

{ #category : #'gt - extensions' }
GtSpaceTally >> gtViewRepositoryTalliesFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Tallies (by repository)';
		items:  [ self repositoryTallies  
			sorted: [ :aRepositoryTally | aRepositoryTally totalInstSpace ] descending ];
		column: 'Package Name' text: [ :aRepositoryTally | 
			aRepositoryTally analyzedRepositoryName ];
		column: 'Instance count' text: [ :aRepositoryTally | 
			aRepositoryTally totalInstCount ];
		column: 'Instances Size' text: [ :aRepositoryTally | 
			aRepositoryTally totalInstSpace humanReadableIsqByteSize ]
]

{ #category : #accessing }
GtSpaceTally >> label [
	^ label
]

{ #category : #accessing }
GtSpaceTally >> label: aLabel [
	label := aLabel
]

{ #category : #accessing }
GtSpaceTally >> packageTallies [ 
	^ (self results items groupedBy: [ :aTally |
			aTally analyzedPackageName ]) associations 
				collect: [ :assoc |
					GtSpaceTallyPackageTally new
						analyzedPackageName: assoc key; 
						addClassTallies: assoc value ]
]

{ #category : #accessing }
GtSpaceTally >> repositoryTallies [ 
	^ (self packageTallies groupedBy: [ :aPackageTally |
			IceRepository registry 
				detect: [ :aRepository | 
					aRepository includesPackageNamed: aPackageTally analyzedPackageName ]
				ifFound: [ :aRepository | aRepository name ]
				ifNone: [ '<Unknown>' ]
			]) associations 
				collect: [ :assoc |
					GtSpaceTallyRepositoryTally new
						analyzedRepositoryName: assoc key; 
						addPackageTallies: assoc value ]
]

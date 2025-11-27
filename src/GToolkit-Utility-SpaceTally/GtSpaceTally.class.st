"
I extend {{gtClass:SpaceTally}} with extra information by using for tally items {{gtClass:GtSpaceTallyItem}}.
"
Class {
	#name : #GtSpaceTally,
	#superclass : #Object,
	#instVars : [
		'label',
		'results'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'gt - extensions' }
GtSpaceTally >> gtViewItemsFor: aView [
	<gtView>
	results ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Tallies';
		object: [ results ];
		view: #gtViewItemsFor:
]

{ #category : #'gt - extensions' }
GtSpaceTally >> gtViewOverviewFor: aView [
	<gtView>
	results ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Overview';
		object: [ results ];
		view: #gtViewOverviewFor:
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

{ #category : #accessing }
GtSpaceTally >> results [
	^ results
]

{ #category : #'class analysis' }
GtSpaceTally >> systemWideSpaceTally [
	"Answer a collection of SpaceTallyItems representing the memory space (in bytes) consumed 	by the code and instances of each class in the system. Note that code sizes do not currently 	report memory consumed by class variables. "
	| items |
	items := (GtObjectMemoryTally systemWideSpaceTally results 
		reject: [ :anObjectsTally |
			anObjectsTally objectsClass isNil ])
		collect: [ :anObjectTally |
			GtSpaceTallyItem
				fromObjectsTally: anObjectTally ].
	^ results := GtSpaceTallyItemsGroup withAll: items
]

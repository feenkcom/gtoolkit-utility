Class {
	#name : #GtSpaceTallyHistory,
	#superclass : #Object,
	#instVars : [
		'tallyVersions',
		'tallyItemVersionsByClassName'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #adding }
GtSpaceTallyHistory >> addSpaceTallyVersion: aSpaceTallyVersion [
	aSpaceTallyVersion index: self spaceTallyVersions size + 1.
	
	self spaceTallyVersions add: aSpaceTallyVersion.
	self updateClassHistoriesFor: aSpaceTallyVersion.
]

{ #category : #'gt - extensions' }
GtSpaceTallyHistory >> gtViewAnalyzedClassesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Analyzed Classes (with changes)';
		items: [ 
			(tallyItemVersionsByClassName values 
				select: [ :aClassHistory | aClassHistory hasChanges ])
				sorted: [ :aClassHistory | 
					aClassHistory tallyItemVersions last spaceForInstances ] descending ];
		column: 'Class Name' text: [ :aClassHistory |
			aClassHistory analyzedClassName ];
		column: 'Count chance' text: [ :aClassHistory |
			aClassHistory instanceCountChange ];
		column: 'Size chance' text: [ :aClassHistory |
			((aClassHistory instanceSizeChange < 0)
				ifTrue: [
					'-', aClassHistory instanceSizeChange negated humanReadableIsqByteSize ]  
				ifFalse: [ 
					aClassHistory instanceSizeChange humanReadableIsqByteSize ])
			
			 ];
		column: 'Latest Count' text: [ :aClassHistory |
			aClassHistory tallyItemVersions last instanceCount ];
		column: 'Latest Size' text: [ :aClassHistory |
			aClassHistory tallyItemVersions last spaceForInstances humanReadableIsqByteSize ]
		
]

{ #category : #'gt - extensions' }
GtSpaceTallyHistory >> gtViewVersionsFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Tally Versions';
		items: [ self spaceTallyVersions ];
		column: 'Index' text: [ :aVersion |
			aVersion index ];
		column: 'Instance Count' text: [ :aVersion |
			aVersion totalInstCount ];
		column: 'Instances Size' text: [ :aVersion |
			aVersion totalInstSpace humanReadableIsqByteSize ];
		column: 'VM Memory Size' text: [ :aVersion |
			aVersion vmMemorySize humanReadableIsqByteSize ]
]

{ #category : #initialization }
GtSpaceTallyHistory >> initialize [ 
	super initialize.
	tallyVersions := OrderedCollection new.
	tallyItemVersionsByClassName := Dictionary new.
]

{ #category : #recording }
GtSpaceTallyHistory >> recordSystemWideData [
	| newVersion |
	
	newVersion := GtSpaceTallyVersion new.
	newVersion recordSystemWideData.
	
	self addSpaceTallyVersion: newVersion
]

{ #category : #accessing }
GtSpaceTallyHistory >> spaceTallyVersions [
	^ tallyVersions 
]

{ #category : #updating }
GtSpaceTallyHistory >> updateClassHistoriesFor: aSpaceTallyVersion [
 aSpaceTallyVersion spaceTallyItemVersions do: [ :aTallyItemVersion |
	| classHistory |
	classHistory := tallyItemVersionsByClassName 
		at: aTallyItemVersion analyzedClassName 
		ifAbsentPut: [ GtSpaceTallyClassHistory new
			analyzedClassName: aTallyItemVersion analyzedClassName ].
	classHistory addTallyItemVersion: aTallyItemVersion ]
]

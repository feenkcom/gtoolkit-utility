"
I extend a {{gtClass:SpaceTallyItem}} with extra information like the package containing the analyzed class.
"
Class {
	#name : #GtSpaceTallyItem,
	#superclass : #Object,
	#instVars : [
		'analyzedPackageName',
		'codeSize',
		'analyzedClassName',
		'instanceCount',
		'spaceForInstances',
		'detailsPerSpace',
		'objectsTally'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtSpaceTallyItem class >> fromObjectsTally: aTally [ 

	^ self new
		initializeFromObjectsTally: aTally
]

{ #category : #accessing }
GtSpaceTallyItem >> amountOfObjects [
	^ amountOfObjects
]

{ #category : #accessing }
GtSpaceTallyItem >> analyzedClassName [
	^ analyzedClassName
]

{ #category : #accessing }
GtSpaceTallyItem >> analyzedPackageName [

	^ analyzedPackageName
]

{ #category : #accessing }
GtSpaceTallyItem >> analyzedPackageName: anObject [

	analyzedPackageName := anObject
]

{ #category : #accessing }
GtSpaceTallyItem >> codeSize [
	^ codeSize
]

{ #category : #accessing }
GtSpaceTallyItem >> codeSize: anObject [
	codeSize := anObject
]

{ #category : #accessing }
GtSpaceTallyItem >> computeReferencePaths: count [
	| startIndex increment |
	3 timesRepeat: [ Smalltalk garbageCollect ].
	startIndex := self instanceCount // count.
	increment := self instanceCount // count.
	^ self analyzedClassName asClass allInstances
		in: [ :aCollection | 
			(startIndex to: aCollection size by: increment)
				collect: [ :anIndex | GtReferencePaths to: (aCollection at: anIndex) ] ]
]

{ #category : #printing }
GtSpaceTallyItem >> descriptionOn: aStream [

	self analyzedClassName ifNotNil: [ 
		aStream print: self analyzedClassName ].
	
	aStream nextPutAll: '('.
	codeSize ifNotNil: [ aStream
		nextPutAll: 'code size: ';
		print: codeSize ].
		
	self instanceCount ifNotNil: [ :anInstanceCount |
		aStream
			nextPutAll: ' instance count: ';
			print: anInstanceCount ].
	self spaceForInstances ifNotNil: [ :anInteger |
		aStream
			nextPutAll: ' space for instances: ';
			print: anInteger ].
			
	aStream nextPutAll: ')'
]

{ #category : #views }
GtSpaceTallyItem >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 5;
		items: [ self gtSummaryAttributes ];
		column: 'Property' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]
]

{ #category : #views }
GtSpaceTallyItem >> gtSpaceDetailsFor: aView [
	<gtView>
	
	detailsPerSpace ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Per space';
		priority: 20;
		items: [ detailsPerSpace ];
		column: 'Space'
		text: [ :each | each printSpaceName ];
		column: 'Byte size'
			text: [ :each | each printObjectsByteSize ];
		column: 'Instances'
			text: [ :each | each printObjectsSize ]
]

{ #category : #views }
GtSpaceTallyItem >> gtSummaryAttributes [
	^{
		'Class' -> self analyzedClassName.
		'Package name' -> self analyzedPackageName.
		'Size of instances' -> self printObjectsByteSize.
		'Number of instances' -> self printObjectsSize .
		'Code size' -> self printCodeSize }
]

{ #category : #accessing }
GtSpaceTallyItem >> initializeFromObjectsTally: anObjectsTally [
	analyzedClassName := anObjectsTally analyzedClassName.
	spaceForInstances := anObjectsTally objectsByteSize. 
	instanceCount := anObjectsTally objectsSize.
	detailsPerSpace := anObjectsTally detailsPerSpace.
	codeSize := anObjectsTally objectsClass spaceUsed. 
	analyzedPackageName := anObjectsTally objectsClass package name 
]

{ #category : #accessing }
GtSpaceTallyItem >> instanceCount [
	^ instanceCount
]

{ #category : #accessing }
GtSpaceTallyItem >> printCodeSize [
	^ self codeSize humanReadableSISizeString
]

{ #category : #printing }
GtSpaceTallyItem >> printObjectsByteSize [
	^ spaceForInstances humanReadableSISizeString
]

{ #category : #printing }
GtSpaceTallyItem >> printObjectsSize [
	^ (String streamContents: [ :s | instanceCount printSeparatedBy: $' every: 3 signed: false on: s ])
]

{ #category : #printing }
GtSpaceTallyItem >> printOn: aStream [

	super printOn:  aStream.
	aStream parenthesize: [
		self descriptionOn:  aStream ]
]

{ #category : #accessing }
GtSpaceTallyItem >> spaceForInstances [
	^ spaceForInstances
]

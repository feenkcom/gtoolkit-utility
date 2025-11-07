"
I extend a {{gtClass:SpaceTallyItem}} with extra information like the package containing the analyzed class.
"
Class {
	#name : #GtSpaceTallyItem,
	#superclass : #Object,
	#instVars : [
		'analyzedPackageName',
		'codeSize',
		'objectsTally'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtSpaceTallyItem class >> objectsTally: aTally [ 

	^ self 
		objectsTally: aTally 
		codeSize: aTally objectsClass spaceUsed 
		analyzedPackageName: aTally objectsClass package name 
]

{ #category : #'instance creation' }
GtSpaceTallyItem class >> objectsTally: aTally codeSize: codeSize [ 

	^ self new
		objectsTally: aTally;
		codeSize: codeSize 
]

{ #category : #'instance creation' }
GtSpaceTallyItem class >> objectsTally: aTally codeSize: codeSize analyzedPackageName: aPackageName [

	^ self new
		objectsTally: aTally;
		codeSize: codeSize;
		analyzedPackageName: aPackageName
]

{ #category : #accessing }
GtSpaceTallyItem >> analyzedClassName [
	^ objectsTally analyzedClassName
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
GtSpaceTallyItem >> gtObjectTallyPerSpaceFor: aView [
	<gtView>
	^ aView forward
		title: 'Per space';
		priority: 20;
		object: [ objectsTally ];
		view: #gtSpaceDetailsFor:
]

{ #category : #views }
GtSpaceTallyItem >> gtSummaryAttributes [
	^ objectsTally gtSummaryAttributes, {
		'Code size' -> self printCodeSize.
		'Package name' -> self analyzedPackageName }
]

{ #category : #accessing }
GtSpaceTallyItem >> instanceCount [
	^ objectsTally objectsSize
]

{ #category : #accessing }
GtSpaceTallyItem >> objectTally [
	^ objectsTally
]

{ #category : #accessing }
GtSpaceTallyItem >> objectsTally: anObject [
	objectsTally := anObject
]

{ #category : #accessing }
GtSpaceTallyItem >> printCodeSize [
	^ self codeSize humanReadableSISizeString
]

{ #category : #printing }
GtSpaceTallyItem >> printObjectsByteSize [
	^ objectsTally printObjectsByteSize
]

{ #category : #printing }
GtSpaceTallyItem >> printObjectsSize [
	^ objectsTally printObjectsSize
]

{ #category : #printing }
GtSpaceTallyItem >> printOn: aStream [

	super printOn:  aStream.
	aStream parenthesize: [
		self descriptionOn:  aStream ]
]

{ #category : #accessing }
GtSpaceTallyItem >> spaceForInstances [
	^ objectsTally objectsByteSize
]

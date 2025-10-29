"
I extend a {{gtClass:SpaceTallyItem}} with extra information like the package containing the analyzed class.
"
Class {
	#name : #GtSpaceTallyItem,
	#superclass : #SpaceTallyItem,
	#instVars : [
		'analyzedPackageName'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtSpaceTallyItem >> analyzedPackageName [

	^ analyzedPackageName
]

{ #category : #accessing }
GtSpaceTallyItem >> analyzedPackageName: anObject [

	analyzedPackageName := anObject
]

{ #category : #accessing }
GtSpaceTallyItem >> computeReferencePaths: count [
	| startIndex increment |
	3 timesRepeat: [ Smalltalk garbageCollect ].
	startIndex := instanceCount // count.
	increment := instanceCount // count.
	^ analyzedClassName asClass allInstances
		in: [ :aCollection | 
			(startIndex to: aCollection size by: increment)
				collect: [ :anIndex | GtReferencePaths to: (aCollection at: anIndex) ] ]
]

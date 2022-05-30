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

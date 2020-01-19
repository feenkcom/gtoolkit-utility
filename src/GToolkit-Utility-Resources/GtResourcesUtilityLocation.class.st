"
I represent a location where a ${class:Path}$ (file or directory) is searched for.
My subclasses should implement ${method:GtResourcesUtilityLocation>>#resourceAtPath:}$. 
My subclasses are used by ${class:GtResourcesUtility}$.

See my subclasses for more details ${class:GtResourcesUtilityLocation|expanded=true|show=#gtSubclassesFor:}$.
"
Class {
	#name : #GtResourcesUtilityLocation,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources-Locations'
}

{ #category : #initialization }
GtResourcesUtilityLocation class >> defaultPriority [
	^ 50
]

{ #category : #testing }
GtResourcesUtilityLocation >> exists [
	<return: #Boolean>
	^ (self resourceAtPath: Path * '.') exists
]

{ #category : #accessing }
GtResourcesUtilityLocation >> resourceAtPath: aPath [
	<return: #GtResourcesUtilityLocationResult>
	^ self subclassResponsibility
]

{ #category : #private }
GtResourcesUtilityLocation >> resultForFile: aFileReference [
	<return: #GtResourcesUtilityLocationResult>
	^ aFileReference exists 
		ifTrue: [ GtResourcesUtilityLocationExistingResult new file: aFileReference ]
		ifFalse: [ GtResourcesUtilityLocationNoResult new file: aFileReference ].
]

{ #category : #private }
GtResourcesUtilityLocation >> resultForPath: aStringOrPath in: aDirectory [
	<return: #GtResourcesUtilityLocationResult>
	| aFileReference |
	aFileReference := aDirectory asFileReference resolvePath: aStringOrPath.
	^ self resultForFile: aFileReference
]

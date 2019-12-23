"
I exemplify ${class:GtResourcesUtility}$
"
Class {
	#name : #GtResourcesUtilityExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources'
}

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtFeenkUtilityDefinedAsPath [
	<gtExample>
	| aDir |
	aDir := GtResourcesUtility resourceAtPath: Path * 'feenkcom' / 'gtoolkit-utility'.
	self assert: aDir isDirectory.
	self assert: aDir exists.
	^ aDir
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtFeenkUtilityDefinedAsString [
	<gtExample>
	| aDir |
	aDir := GtResourcesUtility resourceAtPath: 'feenkcom/gtoolkit-utility'.
	self assert: aDir isDirectory.
	self assert: aDir exists.
	^ aDir
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtNonExistingPath [
	<gtExample>
	| aDir |
	aDir := GtResourcesUtility resourceAtPath: Path * 'this' / 'is' / 'an' / 'non-existing' / 'resource'.
	self assert: aDir exists not.
	^ aDir
]

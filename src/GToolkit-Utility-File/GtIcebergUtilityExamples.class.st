Class {
	#name : #GtIcebergUtilityExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-File'
}

{ #category : #'examples - resources' }
GtIcebergUtilityExamples >> gtResourceAtFeenkUtilityDefinedAsPath [
	<gtExample>
	| aDir |
	aDir := GtIcebergUtility resourceAtPath: Path * 'feenkcom' / 'gtoolkit-utility'.
	self assert: aDir isDirectory.
	self assert: aDir exists.
	^ aDir
]

{ #category : #'examples - resources' }
GtIcebergUtilityExamples >> gtResourceAtFeenkUtilityDefinedAsString [
	<gtExample>
	| aDir |
	aDir := GtIcebergUtility resourceAtPath: 'feenkcom/gtoolkit-utility'.
	self assert: aDir isDirectory.
	self assert: aDir exists.
	^ aDir
]

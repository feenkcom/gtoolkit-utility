"
I exemplify ${class:GtResourcesUtility}$
"
Class {
	#name : #GtResourcesUtilityExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources'
}

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> basicGtExtraLocation [
	<gtExample>
	^ GtResourcesUtilityGtExtraLocation new
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> basicIcebergLocation [
	<gtExample>
	^ GtResourcesUtilityIcebergLocation new
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> basicMacOSResourcesLocation [
	<gtExample>
	^ GtResourcesUtilityMacOSResourcesLocation new
]

{ #category : #'examples - paths' }
GtResourcesUtilityExamples >> existingPath [
	<gtExample>
	| aPath aFile |
	aPath := Path * '.'.
	aFile := FileLocator home resolvePath: aPath.
	self assert: aFile exists.
	^ aPath
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> gtExtraLocation [
	<gtExample>
	| aLocation aPath aResult |
	aLocation := self basicGtExtraLocation.
	aPath := self existingPath.
	aResult := aLocation resourceAtPath: aPath.
	self assert: aResult exists.
	^ aResult
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtFeenkUtilityDefinedAsPath [
	<gtExample>
	| aDir |
	aDir := GtResourcesUtility resourceAtPath: Path * '.'.
	self assert: aDir isDirectory.
	self assert: aDir exists.
	^ aDir
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtFeenkUtilityDefinedAsString [
	<gtExample>
	| aDir |
	aDir := GtResourcesUtility resourceAtPath: './'.
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

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> icebergLocation [
	<gtExample>
	| aLocation aPath aResult |
	aLocation := self basicIcebergLocation.
	aPath := self existingPath.
	aResult := aLocation resourceAtPath: aPath.
	self assert: aResult exists.
	^ aResult
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> macOSResourcesLocation [
	<gtExample>
	| aLocation aPath aResult |
	aLocation := self basicMacOSResourcesLocation.
	aPath := self existingPath.
	aResult := aLocation resourceAtPath: aPath.
	self assert: aResult exists.
	^ aResult
]

{ #category : #'examples - paths' }
GtResourcesUtilityExamples >> notExistingPath [
	<gtExample>
	| aPath aFile |
	aPath := Path * 'not' / 'existing' / 'path'.
	aFile := FileLocator home resolvePath: aPath.
	self assert: aFile exists not.
	^ aPath
]

{ #category : #'examples - basic' }
GtResourcesUtilityExamples >> resourceUtility [
	<gtExample>
	| anUtility theLocationClasses anIcebergPosition anGtExtraPosition anMacOSPosition |
	anUtility := GtResourcesUtility new.
	self assert: anUtility locations isCollection.
	self assert: anUtility locations size >= 3.
	theLocationClasses := anUtility locations collect: #class.
	anIcebergPosition := theLocationClasses indexOf: GtResourcesUtilityIcebergLocation.
	anGtExtraPosition := theLocationClasses indexOf: GtResourcesUtilityGtExtraLocation.
	anMacOSPosition := theLocationClasses indexOf: GtResourcesUtilityMacOSResourcesLocation.
	self assert: anIcebergPosition < anGtExtraPosition.
	self assert: anGtExtraPosition < anMacOSPosition.
	^ anUtility	
]

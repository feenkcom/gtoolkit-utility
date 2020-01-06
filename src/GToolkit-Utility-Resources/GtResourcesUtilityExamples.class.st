"
I exemplify ${class:GtResourcesUtility}$
"
Class {
	#name : #GtResourcesUtilityExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources'
}

{ #category : #'examples - results' }
GtResourcesUtilityExamples >> basicExistingResult [
	<gtExample>
	| aResult |
	aResult := GtResourcesUtilityLocationExistingResult new.
	self assert: aResult file isNil.
	self assert: aResult exists.
	^ aResult
]

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

{ #category : #'examples - results' }
GtResourcesUtilityExamples >> basicNoResult [
	<gtExample>
	| aResult |
	aResult := GtResourcesUtilityLocationNoResult new.
	self assert: aResult file isNil.
	self assert: aResult exists not.
	^ aResult
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

{ #category : #'examples - results' }
GtResourcesUtilityExamples >> existingResult [
	<gtExample>
	| aFile aResult |
	aFile := self existingPath asFileReference.
	aResult := self basicExistingResult.
	aResult file: aFile.
	self assert: aResult file equals: aFile.
	self assert: aResult exists.
	^ aResult	
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> gtExtraDirectory [
	<gtExample>
	^ self gtExtraLocation file
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> gtExtraLocation [
	<gtExample>
	| aLocation aPath aResult |
	aLocation := self basicGtExtraLocation.
	aPath := self existingPath.
	aResult := aLocation resourceAtPath: aPath.
	self assert: aResult file isNotNil.
	self assert: aResult file basename equals: GtResourcesUtilityConstants localGtDirectoryName.
	self assert: aResult file equals: GtResourcesUtilityConstants localGtDirectory asFileReference.
	^ aResult
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtFeenkUtilityDefinedAsPath [
	<gtExample>
	| aDir |
	aDir := GtResourcesUtility resourceAtPath: Path * 'feenkcom'.
	self assert: (aDir isKindOf: AbstractFileReference).
	^ aDir
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtFeenkUtilityDefinedAsString [
	<gtExample>
	| aDir |
	aDir := GtResourcesUtility resourceAtPath: 'feenkcom'.
	self assert: (aDir isKindOf: AbstractFileReference).
	^ aDir
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtNonExistingPath [
	<gtExample>
	| aDir |
	aDir := GtResourcesUtility resourceAtPath: Path * 'this' / 'is' / 'an' / 'non-existing' / 'resource'.
	self assert: (aDir isKindOf: AbstractFileReference).
	self assert: aDir exists not.
	^ aDir
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourcesPointsToSameDirectory [
	<gtExample>
	| aDirOne aDirTwo |
	aDirOne := self gtResourceAtFeenkUtilityDefinedAsPath.
	aDirTwo := self gtResourceAtFeenkUtilityDefinedAsString.
	self assert: aDirOne equals: aDirTwo.
	^ { aDirOne. aDirTwo }
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> icebergLocation [
	<gtExample>
	| aLocation aPath aResult |
	aLocation := self basicIcebergLocation.
	aPath := self existingPath.
	aResult := aLocation resourceAtPath: aPath.
	self assert: aResult file isNotNil.
	self assert: aResult file equals: GtResourcesUtilityConstants icebergRepositoriesLocation.
	^ aResult
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> macOSResourcesLocation [
	<gtExample>
	| aLocation aPath aResult |
	aLocation := self basicMacOSResourcesLocation.
	aPath := self existingPath.
	aResult := aLocation resourceAtPath: aPath.
	self assert: aResult file isNotNil.
	OSPlatform current isMacOS ifTrue: [ 
		self assert: aResult file equals: GtResourcesUtilityConstants resourcesGtDirectory ].
	^ aResult
]

{ #category : #'examples - results' }
GtResourcesUtilityExamples >> noResult [
	<gtExample>
	| aFile aResult |
	aFile := self notExistingPath asFileReference.
	aResult := self basicNoResult.
	aResult file: aFile.
	self assert: aResult file equals: aFile.
	self assert: aResult exists not.
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

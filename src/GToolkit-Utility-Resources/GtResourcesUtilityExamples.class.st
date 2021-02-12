"
I exemplify ${class:GtResourcesUtility}$ and ${class:GtResourceReference}$.
"
Class {
	#name : #GtResourcesUtilityExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources-Examples'
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

{ #category : #'examples - file locator' }
GtResourcesUtilityExamples >> fileLocator [
	<gtExample>
	| aLocator |
	aLocator := FileLocator gtResource.
	
	self assert: aLocator origin equals: #gtResource.
	self assert: aLocator path equals: Path workingDirectory.
	
	^ aLocator
]

{ #category : #'examples - file locator' }
GtResourcesUtilityExamples >> fileLocator_asFileReference [
	<gtExample>
	| aLocator aFileReference |
	aLocator := self fileLocator.
	aFileReference := aLocator asFileReference.
	
	self assert: aFileReference class equals: FileReference.
	self assert: aFileReference path isAbsolute.
	
	^ aFileReference
]

{ #category : #'examples - file locator' }
GtResourcesUtilityExamples >> fileLocator_resolve [
	<gtExample>
	| aLocator aFileReference |
	aLocator := self fileLocator.
	aFileReference := aLocator resolve.
	
	self assert: aFileReference class equals: FileReference.
	self assert: aFileReference path isAbsolute.
	
	^ aFileReference
]

{ #category : #'examples - file locator' }
GtResourcesUtilityExamples >> fileLocator_withSlash [
	<gtExample>
	| aLocator aFileReference aNewLocator aNewFileReference |
	aLocator := self fileLocator.
	aNewLocator := aLocator / 'something'.
	
	aFileReference := aLocator asFileReference.
	aNewFileReference := aNewLocator asFileReference.
	
	self assert: aNewFileReference class equals: FileReference.
	self assert: aNewFileReference path isAbsolute.
	self assert: aNewFileReference parent equals: aFileReference.
	
	^ aNewLocator
]

{ #category : #'examples - file locator' }
GtResourcesUtilityExamples >> fileLocator_withSlashes [
	<gtExample>
	| aLocator aFileReference aNewLocator aNewFileReference |
	aLocator := self fileLocator.
	aNewLocator := aLocator / 'feenkcom/gtoolkit/doc'.
	
	aFileReference := aLocator asFileReference.
	aNewFileReference := aNewLocator asFileReference.
	
	self assert: aNewFileReference class equals: FileReference.
	self assert: aNewFileReference path isAbsolute.
	self assert: aNewFileReference parent parent parent equals: aFileReference.
	
	^ aNewLocator
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

{ #category : #'examples - resource reference' }
GtResourcesUtilityExamples >> gtResourceReferenceOfExistingPath [
	<gtExample>
	| aDir |
	aDir := GtResourceReference path: self existingPath.
	self assert: aDir class equals: GtResourceReference.
	self assert: aDir asFileReference == aDir.
	self assert: aDir exists.
	^ aDir
]

{ #category : #'examples - resource reference' }
GtResourcesUtilityExamples >> gtResourceReferenceOfExistingStringPath [
	<gtExample>
	| aDir |
	aDir := GtResourceReference path: 'feenkcom/gtoolkit/doc/gtoolkit.png'.
	self assert: aDir class equals: GtResourceReference.
	self assert: aDir asFileReference == aDir.
	self assert: aDir exists.
	^ aDir
]

{ #category : #'examples - resource reference' }
GtResourcesUtilityExamples >> gtResourceReferenceOfNotExistingPath [
	<gtExample>
	| aDir |
	aDir := GtResourceReference path: self notExistingPath.
	self assert: aDir class equals: GtResourceReference.
	self assert: aDir asFileReference == aDir.
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
	self assert: aResult file equals: GtResourcesUtilityConstants icebergRepositoriesLocation asFileReference.
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

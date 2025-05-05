"
I exemplify {{gtClass:GtResourcesUtility}} and {{gtClass:GtResourceReference}}.


"
Class {
	#name : #GtResourcesUtilityExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources-Examples'
}

{ #category : #'examples - results' }
GtResourcesUtilityExamples >> basicExistingResult [
	<gtExample>
	<return: #GtResourcesUtilityLocationExistingResult>
	| aResult |
	aResult := GtResourcesUtilityLocationExistingResult new.
	self assert: aResult file isNil.
	self assert: aResult exists.
	^ aResult
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> basicGtExtraLocation [
	<gtExample>
	<return: #GtResourcesUtilityGtExtraLocation>
	^ GtResourcesUtilityGtExtraLocation new
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> basicIcebergLocation [
	<gtExample>
	<return: #GtResourcesUtilityIcebergLocation>
	^ GtResourcesUtilityIcebergLocation new
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> basicMacOSResourcesLocation [
	<gtExample>
	<return: #GtResourcesUtilityMacOSResourcesLocation>
	^ GtResourcesUtilityMacOSResourcesLocation new
]

{ #category : #'examples - results' }
GtResourcesUtilityExamples >> basicNoResult [
	<gtExample>
	<return: #GtResourcesUtilityLocationNoResult>
	| aResult |
	aResult := GtResourcesUtilityLocationNoResult new.
	self assert: aResult file isNil.
	self assert: aResult exists not.
	^ aResult
]

{ #category : #'examples - paths' }
GtResourcesUtilityExamples >> existingPath [
	<gtExample>
	<return: #RelativePath>
	| aPath aFile |
	aPath := Path * '.'.
	aFile := FileLocator home resolvePath: aPath.
	self assert: aFile exists.
	^ aPath
]

{ #category : #'examples - results' }
GtResourcesUtilityExamples >> existingResult [
	<gtExample>
	<return: #GtResourcesUtilityLocationExistingResult>
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
	<return: #FileLocator>
	| aLocator |
	aLocator := FileLocator gtResource.

	self assert: aLocator origin equals: #gtResource.
	self assert: aLocator path equals: Path workingDirectory.

	^ aLocator
]

{ #category : #'examples - file locator' }
GtResourcesUtilityExamples >> fileLocator_asFileReference [
	<gtExample>
	<return: #GtResourceReference>
	| aLocator aFileReference |
	aLocator := self fileLocator.
	aFileReference := aLocator asFileReference.

	self assert: aFileReference class equals: GtResourceReference.
	self assert: aFileReference relativePath isAbsolute not.
	self assert: aFileReference path isAbsolute.

	^ aFileReference
]

{ #category : #'examples - file locator' }
GtResourcesUtilityExamples >> fileLocator_resolve [
	<gtExample>
	<return: #GtResourceReference>
	| aLocator aFileReference |
	aLocator := self fileLocator.
	aFileReference := aLocator resolve.

	self assert: aFileReference class equals: GtResourceReference.
	self assert: aFileReference relativePath isAbsolute not.
	self assert: aFileReference path isAbsolute.

	^ aFileReference
]

{ #category : #'examples - file locator' }
GtResourcesUtilityExamples >> fileLocator_withParents [
	<gtExample>
	<return: #Array>
	| aLocator aCollection |
	aLocator := self fileLocator.
	aCollection := aLocator withParents.

	self assert: aCollection isCollection.
	self assert: aCollection isNotEmpty.
	self assert: (aCollection allSatisfy: #isAbsolute).
	self
		assert: aCollection last asFileReference
		equals: aLocator asFileReference fileReference.

	^ aCollection
]

{ #category : #'examples - file locator' }
GtResourcesUtilityExamples >> fileLocator_withSlash [
	<gtExample>
	<return: #FileLocator>
	| aParentLocator aParentResource aChildLocator aChildResource |
	aParentLocator := self fileLocator.
	aChildLocator := aParentLocator / 'something'.

	aParentResource := aParentLocator asFileReference.
	aChildResource := aChildLocator asFileReference.

	self assert: aParentResource class equals: GtResourceReference.
	self assert: aChildResource class equals: GtResourceReference.
	self assert: aChildResource relativePath isAbsolute not.
	self assert: aChildResource path isAbsolute.
	self assert: aChildResource parent equals: aParentResource.
	self assert: aParentResource equals: aChildResource parent.
	self assert: aChildResource parent equals: aParentResource fileReference.

	^ aChildLocator
]

{ #category : #'examples - file locator' }
GtResourcesUtilityExamples >> fileLocator_withSlashes [
	<gtExample>
	<return: #FileLocator>
	| aParentLocator aParentResource aChildLocator aChildResource |
	aParentLocator := self fileLocator.
	aChildLocator := aParentLocator / 'feenkcom/gtoolkit/doc'.

	aParentResource := aParentLocator asFileReference.
	aChildResource := aChildLocator asFileReference.

	self assert: aParentResource class equals: GtResourceReference.
	self assert: aChildResource class equals: GtResourceReference.
	self assert: aChildResource relativePath isAbsolute not.
	self assert: aChildResource path isAbsolute.
	self assert: aChildResource parent parent parent equals: aParentResource.
	self
		assert: aChildResource parent parent parent
		equals: aParentResource fileReference.

	^ aChildLocator
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> gtExtraDirectory [
	<gtExample>
	<return: #FileReference>
	^ self gtExtraLocation file
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> gtExtraLocation [
	<gtExample>
	<return: #GtResourcesUtilityLocationNoResult>
	| aLocation aPath aResult |
	aLocation := self basicGtExtraLocation.
	aPath := self existingPath.
	aResult := aLocation resourceAtPath: aPath.
	self assert: aResult file isNotNil.
	self
		assert: aResult file basename
		equals: GtResourcesUtilityConstants localGtDirectoryName.
	self
		assert: aResult file
		equals: GtResourcesUtilityConstants localGtDirectory asFileReference.
	^ aResult
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtFeenkUtilityDefinedAsPath [
	<gtExample>
	<return: #FileReference>
	| aDir |
	aDir := GtResourcesUtility resourceAtPath: Path * 'feenkcom'.
	self assert: (aDir isKindOf: AbstractFileReference).
	^ aDir
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtFeenkUtilityDefinedAsString [
	<gtExample>
	<return: #FileReference>
	| aDir |
	aDir := GtResourcesUtility resourceAtPath: 'feenkcom'.
	self assert: (aDir isKindOf: AbstractFileReference).
	^ aDir
]

{ #category : #'examples - resources' }
GtResourcesUtilityExamples >> gtResourceAtNonExistingPath [
	<gtExample>
	<return: #FileReference>
	| aDir |
	aDir := GtResourcesUtility
			resourceAtPath: Path * 'this' / 'is' / 'an' / 'non-existing' / 'resource'.
	self assert: (aDir isKindOf: AbstractFileReference).
	self assert: aDir exists not.
	^ aDir
]

{ #category : #'examples - resource reference' }
GtResourcesUtilityExamples >> gtResourceReferenceOfExistingPath [
	<gtExample>
	<return: #GtResourceReference>
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
	<return: #GtResourceReference>
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
	<return: #GtResourceReference>
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
	<return: #Array>
	| aDirOne aDirTwo |
	aDirOne := self gtResourceAtFeenkUtilityDefinedAsPath.
	aDirTwo := self gtResourceAtFeenkUtilityDefinedAsString.
	self assert: aDirOne equals: aDirTwo.
	^ {aDirOne.
		aDirTwo}
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> icebergLocation [
	<gtExample>
	<return: #GtResourcesUtilityLocationExistingResult>
	| aLocation aPath aResult |
	aLocation := self basicIcebergLocation.
	aPath := self existingPath.
	aResult := aLocation resourceAtPath: aPath.
	self assert: aResult file isNotNil.
	self
		assert: aResult file
		equals: GtResourcesUtilityConstants icebergRepositoriesLocation asFileReference.
	^ aResult
]

{ #category : #'examples - locations' }
GtResourcesUtilityExamples >> macOSResourcesLocation [
	<gtExample>
	<return: #GtResourcesUtilityLocationNoResult>
	| aLocation aPath aResult |
	aLocation := self basicMacOSResourcesLocation.
	aPath := self existingPath.
	aResult := aLocation resourceAtPath: aPath.
	self assert: aResult file isNotNil.
	OSPlatform current isMacOS
		ifTrue: [ self
				assert: aResult file
				equals: GtResourcesUtilityConstants resourcesGtDirectory ].
	^ aResult
]

{ #category : #'examples - results' }
GtResourcesUtilityExamples >> noResult [
	<gtExample>
	<return: #GtResourcesUtilityLocationNoResult>
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
	<return: #RelativePath>
	| aPath aFile |
	aPath := Path * 'not' / 'existing' / 'path'.
	aFile := FileLocator home resolvePath: aPath.
	self assert: aFile exists not.
	^ aPath
]

{ #category : #'examples - comparison' }
GtResourcesUtilityExamples >> resourceReferenceEquals [
	<gtExample>
	<return: #GtResourceReference>
	| aResourceOne aResourceTwo |
	aResourceOne := GtResourceReference path: Path * 'file1.txt'.
	aResourceTwo := GtResourceReference path: Path * 'file1.txt'.

	self assert: aResourceOne equals: aResourceTwo.
	self assert: aResourceTwo equals: aResourceOne.

	^ aResourceOne
]

{ #category : #'examples - comparison' }
GtResourcesUtilityExamples >> resourceReferenceEquals_AnyObject [
	<gtExample>
	<return: #GtResourceReference>
	| aResource anObject |
	aResource := GtResourceReference path: Path * 'file1.txt'.
	anObject := Object new.

	self assert: (aResource = anObject) not.
	self assert: (anObject = aResource) not.

	^ aResource
]

{ #category : #'examples - comparison' }
GtResourcesUtilityExamples >> resourceReferenceEquals_FileLocator [
	<gtExample>
	<return: #GtResourceReference>
	| aResource aFile |
	aResource := GtResourceReference path: Path * 'file1.txt'.
	aFile := FileLocator gtResource / 'file1.txt'.

	self assert: aResource equals: aFile.
	self assert: (aFile = aResource) not.

	^ aResource
]

{ #category : #'examples - comparison' }
GtResourcesUtilityExamples >> resourceReferenceEquals_FileReference [
	<gtExample>
	<return: #GtResourceReference>
	| aResource aFile |
	aResource := GtResourceReference path: Path * 'file1.txt'.
	aFile := aResource fileReference.

	self assert: aResource equals: aFile.
	self assert: (aFile = aResource) not.

	^ aResource
]

{ #category : #'examples - resolve' }
GtResourcesUtilityExamples >> resourceReferenceWithThreeLocations [
	<gtExample>
	<return: #GtResourceReference>
	| anUtility aReference |
	anUtility := self resourceUtilityWithThreeLocations.
	aReference := GtResourceReference new utility: anUtility.

	self assert: aReference utility equals: anUtility.

	^ aReference
]

{ #category : #'examples - resolve' }
GtResourcesUtilityExamples >> resourceReferenceWithThreeLocations_FileReferenceResolveResourceReference [
	<gtExample>
	<return: #FileReference>
	| aReference aData aText aTextTwo aFile aFileData |
	aReference := self resourceReferenceWithThreeLocations.
	aFile := aReference fileReference.
	aFileData := aFile / 'data'.
	aData := aReference / 'data'.
	aText := aReference / 'data/text.txt'.
	aTextTwo := aReference / 'text.txt'.

	self assert: aFile exists description: [ 'resource file must exist' ].
	self
		assert: aFileData exists not
		description: [ 'data resource file must not exist' ].
	self
		assert: (aFile resolve: aText) exists not
		description: [ 'data/text.txt resource must exist' ].
	self
		assert: (aFileData resolve: aTextTwo) exists not
		description: [ 'data / text.txt resource must exist' ].

	^ aFileData resolve: aTextTwo
]

{ #category : #'examples - resolve' }
GtResourcesUtilityExamples >> resourceReferenceWithThreeLocations_RelativePathResolveResourceReference [
	<gtExample>
	<return: #GtResourceReference>
	| aReference aData aText aTextTwo aPath aPathData |
	aReference := self resourceReferenceWithThreeLocations.
	aPath := Path * 'data'.
	aPathData := aPath / 'data'.
	aData := aReference / 'data'.
	aText := aReference / 'data/text.txt'.
	aTextTwo := aReference / 'text.txt'.

	self
		assert: (aPath resolve: aText) exists
		description: [ 'data/text.txt resource must exist' ].
	self
		assert: (aPathData resolve: aTextTwo) exists not
		description: [ 'data / text.txt resource must exist' ].

	^ aPath resolve: aText
]

{ #category : #'examples - resolve' }
GtResourcesUtilityExamples >> resourceReferenceWithThreeLocations_ResolveRelativeFileReference [
	<gtExample>
	<return: #GtResourceReference>
	| aReference |
	aReference := self resourceReferenceWithThreeLocations.

	self
		assert: (aReference resolve: 'data' asFileReference) exists
		description: [ 'data resource must exist' ].
	self
		assert: (aReference resolve: 'data/text.txt' asFileReference) exists
		description: [ 'data/text.txt resource must exist' ].
	self
		assert: ((aReference resolve: 'data' asFileReference)
				resolve: 'text.txt' asFileReference) exists
		description: [ 'data / text.txt resource must exist' ].

	^ aReference resolve: 'data/text.txt' asFileReference
]

{ #category : #'examples - resolve' }
GtResourcesUtilityExamples >> resourceReferenceWithThreeLocations_ResolveRelativePath [
	<gtExample>
	<return: #GtResourceReference>
	| aReference |
	aReference := self resourceReferenceWithThreeLocations.

	self
		assert: (aReference resolve: Path * 'data') exists
		description: [ 'data resource must exist' ].
	self
		assert: (aReference resolve: Path * 'data/text.txt') exists
		description: [ 'data/text.txt resource must exist' ].
	self
		assert: ((aReference resolve: Path * 'data') resolve: Path * 'text.txt') exists
		description: [ 'data / text.txt resource must exist' ].

	^ aReference resolve: Path * 'data/text.txt'
]

{ #category : #'examples - resolve' }
GtResourcesUtilityExamples >> resourceReferenceWithThreeLocations_ResolveResourceReference [
	<gtExample>
	<return: #GtResourceReference>
	| aReference aData aText aTextTwo |
	aReference := self resourceReferenceWithThreeLocations.
	aData := aReference / 'data'.
	aText := aReference / 'data/text.txt'.
	aTextTwo := aReference / 'data' / 'text.txt'.

	self
		assert: (aReference resolve: aData) exists
		description: [ 'data resource must exist' ].
	self
		assert: (aReference resolve: aText) exists
		description: [ 'data/text.txt resource must exist' ].
	self
		assert: aTextTwo exists
		description: [ 'data / text.txt resource must exist' ].

	^ aReference resolve: aText
]

{ #category : #'examples - resolve' }
GtResourcesUtilityExamples >> resourceReferenceWithThreeLocations_ResolveString [
	<gtExample>
	<return: #GtResourceReference>
	| aReference |
	aReference := self resourceReferenceWithThreeLocations.

	self
		assert: (aReference resolve: 'data') exists
		description: [ 'data resource must exist' ].
	self
		assert: (aReference resolve: 'data/text.txt') exists
		description: [ 'data/text.txt resource must exist' ].
	self
		assert: ((aReference resolve: 'data') resolve: 'text.txt') exists
		description: [ 'data / text.txt resource must exist' ].

	^ aReference resolve: 'data/text.txt'
]

{ #category : #'examples - basic' }
GtResourcesUtilityExamples >> resourceUtility [
	<gtExample>
	<return: #GtResourcesUtility>
	| anUtility theLocationClasses anIcebergPosition anGtExtraPosition anMacOSPosition |
	anUtility := GtResourcesUtility new.
	self assert: anUtility locations isCollection.
	self assert: anUtility locations size >= 3.
	theLocationClasses := anUtility locations collect: #class.
	anIcebergPosition := theLocationClasses
			indexOf: GtResourcesUtilityIcebergLocation.
	anGtExtraPosition := theLocationClasses
			indexOf: GtResourcesUtilityGtExtraLocation.
	anMacOSPosition := theLocationClasses
			indexOf: GtResourcesUtilityMacOSResourcesLocation.
	self assert: anIcebergPosition < anGtExtraPosition.
	self assert: anGtExtraPosition < anMacOSPosition.
	^ anUtility
]

{ #category : #'examples - resolve' }
GtResourcesUtilityExamples >> resourceUtilityWithThreeLocations [
	<gtExample>
	<return: #GtResourcesUtility>
	| anUtility aRootDir aDirOne aDirTwo aDirThree aLocationOne aLocationTwo aLocationThree |
	anUtility := GtResourcesUtility new.
	aRootDir := FileSystem memory workingDirectory.

	aDirOne := (aRootDir / 'resource1') ensureCreateDirectory.
	aDirTwo := (aRootDir / 'resource2') ensureCreateDirectory.
	aDirThree := (aRootDir / 'resource3') ensureCreateDirectory.

	(aDirTwo / 'data') ensureCreateDirectory.
	(aDirThree / 'data') ensureCreateDirectory.
	aDirThree / 'data' / 'text.txt'
		writeStreamEncoded: #utf8
		do: [ :aStream | aStream nextPutAll: 'I am a data/text.txt resource.' ].


	aLocationOne := GtResourcesUtilityPluggableLocation new directory: aDirOne.
	aLocationTwo := GtResourcesUtilityPluggableLocation new directory: aDirTwo.
	aLocationThree := GtResourcesUtilityPluggableLocation new directory: aDirThree.

	anUtility
		locations: {aLocationOne.
				aLocationTwo.
				aLocationThree}.

	^ anUtility
]

Class {
	#name : #GtPropertiesFileExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Utility-Properties-Examples'
}

{ #category : #asserting }
GtPropertiesFileExamples >> assert: actual equals: expected [
	^ self
		assert: (actual sameContentAs: expected)
		description: [ self comparingStringBetween: actual and: expected ]
]

{ #category : #examples }
GtPropertiesFileExamples >> emptyPropertiesFile [
	"Answer an empty properties file using a memory file for storage"
	<gtExample>
	| properties |

	properties := GtPropertiesFile file: FileSystem memory root / 'gemstone.properties'.
	self deny: properties file exists.
	self assert: properties size equals: 0.
	^ properties
]

{ #category : #examples }
GtPropertiesFileExamples >> populatedPropertiesFile [
	<gtExample>
	| properties fileLocator dictionary fileDictionary readProperties |

	properties := self emptyPropertiesFile.
	fileLocator := FileLocator home / 'file.txt'.
	properties at: #aFile put: fileLocator.

	self assert: properties size equals: 1.
	self assert: properties file exists.

	dictionary := STONJSON fromString: properties file contents.

	self assert: dictionary size equals: 2.
	fileDictionary := dictionary at: #aFile.
	self assert: fileDictionary size equals: 2.
	self assert: (fileDictionary at: #__type) equals: #fileLocator.
	self assert: (fileDictionary at: #filename) equals: fileLocator printString.

	readProperties := GtPropertiesFile file: properties file.
	self assert: readProperties size equals: 1.
	self assert: readProperties file exists.
	self assert: (readProperties at: #aFile) equals: (FileLocator home / 'file.txt').

	^ properties
]

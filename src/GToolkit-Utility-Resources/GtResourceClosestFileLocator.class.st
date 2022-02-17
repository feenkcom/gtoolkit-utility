"
I transform a {{gtClass:FileReference}} to a {{gtClass:FileLocator}}.
I search for a {{gtClass:FileLocator}} parent that is closest to a referenced file.
1. # Usage

You can use {{gtMethod:AbstractFileReference>>#gtWithClosestFileLocatorParent}} to transform a {{gtClass:FileReference}} into {{gtClass:FileLocator}}.
1. # Local Directory Example

The following example shows an original file reference transformed to {{gtMethod:FileLocator class>>#localDirectory|label=#selector}}: {{gtExample:GtResourceClosestFileLocatorExamples>>#locator_FileReference_localDirectoryChild|previewExpanded=true|codeExpanded=false|previewHeight=200}}
1. # Resource Directory Example

Similarly we can transform a file reference into a {{gtMethod:FileLocator class>>#gtResource|label=#selector}}:
{{gtExample:GtResourceClosestFileLocatorExamples>>#locator_FileReference_gtResourceChild|previewExpanded=true|codeExpanded=false|previewHeight=200}}


"
Class {
	#name : #GtResourceClosestFileLocator,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#category : #'GToolkit-Utility-Resources-Core'
}

{ #category : #'api - search' }
GtResourceClosestFileLocator >> closestParent [
	| allParents aClosestParent |
	allParents := FileLocator gtLocations select: [ :eachFileLocator |
		(eachFileLocator contains: self file) or: [ 
			eachFileLocator asFileReference = self file asFileReference ] ].

	allParents ifEmpty: [ ^ nil ].
			
	aClosestParent := allParents detectMax: [ :e | e asFileReference fullName size ].
	
	"Prefer image directory to vm directory"
	(FileLocator imageDirectory asFileReference = FileLocator vmDirectory asFileReference 
		and: [ aClosestParent origin = FileLocator vmDirectory origin ])
			ifTrue: [ aClosestParent := FileLocator imageDirectory ].
	
	^ aClosestParent = self file 
		ifTrue: [ self file ] 
		ifFalse: [ aClosestParent ]
]

{ #category : #'api - accessing' }
GtResourceClosestFileLocator >> file [
	^ file
]

{ #category : #'api - accessing' }
GtResourceClosestFileLocator >> file: anObject [
	file := anObject
]

{ #category : #'api - search' }
GtResourceClosestFileLocator >> transform [

	| aClosestParent aPath aTransformedFile aClosestParentFile aChildFile |
	aClosestParent := self closestParent.

	aClosestParent ifNil: [ ^ self file ].

	aClosestParentFile := aClosestParent asFileReference.
	aClosestParentFile class = GtResourceReference ifTrue: [ 
		aClosestParentFile := aClosestParentFile fileReference ].

	aChildFile := self file asFileReference.
	aChildFile class = GtResourceReference ifTrue: [ 
		aChildFile := aChildFile fileReference ].

	aClosestParentFile = aChildFile ifTrue: [ ^ aClosestParent ].

	aPath := self file relativeTo: aClosestParentFile.
	aTransformedFile := aClosestParent withPath: aPath.

	^ aTransformedFile
]

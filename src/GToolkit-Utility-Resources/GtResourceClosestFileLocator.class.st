"
I transform a ${class:FileReference}$ to a ${class:FileLocator}$.
I search for a ${class:FileLocator}$ parent that is closest to a referenced file.
!! Usage
You can use ${method:AbstractFileReference>>#gtWithClosestFileLocatorParent}$ to transform a ${class:FileReference}$ into ${class:FileLocator}$.
!! Local Directory Example
The following example shows an original file reference transformed to ${method:FileLocator class>>#localDirectory|label=#selector}$: ${example:GtResourceClosestFileLocatorExamples>>#locator_FileReference_localDirectoryChild|previewExpanded=true|codeExpanded=false}$
!! Resource Directory Example
Similarly we can transform a file reference into a ${method:FileLocator class>>#gtResource|label=#selector}$:
${example:GtResourceClosestFileLocatorExamples>>#locator_FileReference_gtResourceChild|previewExpanded=true|codeExpanded=false}$
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
	| aClosestParent aPath aTransformedFile |
	aClosestParent := self closestParent.
	
	aClosestParent asFileReference = self file asFileReference 
		ifTrue: [ ^ aClosestParent ].
		
	aPath := self file relativeTo: aClosestParent.
	aTransformedFile := aClosestParent withPath: aPath.
	
	^ aTransformedFile
]

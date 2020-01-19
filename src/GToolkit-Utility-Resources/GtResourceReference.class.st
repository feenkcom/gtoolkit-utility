"
I am like ${class:FileReference}$. You can use me to dynamically resolve a resource file reference.
Users can use me to read resourcers, e.g., ${method:GtResourceReference>>#binaryReadStreamDo:}$, ${method:GtResourceReference>>#readStreamEncoded:do:}$.

Whenever I am asked to access a file or a directory, I ask ${class:GtResourcesUtility}$ using ${method:GtResourceReference>>#utility}$ to provide me a ${class:FileReference}$. See the ${class:GtResourcesUtility}$ class comment for more details.

!! Live Search 

You can search live here by clicking on the search icon in the inspector: 
${example:GtResourcesUtilityExamples>>#gtResourceReferenceOfExistingPath|noCode|previewHeight=230}$

!! Usage

You can either use a relative ${class:Path}$ to a resource:
${example:GtResourcesUtilityExamples>>#gtResourceReferenceOfExistingPath}$

Or you can pass a ${class:String}$ as a relative resource path:
${example:GtResourcesUtilityExamples>>#gtResourceReferenceOfExistingStringPath}$

In case of a non-existing path, it will return a possible reference inside, responding ${example:GtResourcesUtilityExamples>>#gtResourceReferenceOfNotExistingPath|label=#exists}$ to ==exists== calls: ${example:GtResourcesUtilityExamples>>#gtResourceReferenceOfNotExistingPath}$
"
Class {
	#name : #GtResourceReference,
	#superclass : #Object,
	#instVars : [
		'utility',
		'path'
	],
	#category : #'GToolkit-Utility-Resources-Core'
}

{ #category : #'instance creation' }
GtResourceReference class >> path: aPath [ 
	^ self new path: aPath
]

{ #category : #converting }
GtResourceReference >> asFileReference [
	^ self
]

{ #category : #streams }
GtResourceReference >> binaryReadStreamDo: doBlock [
	^ self fileReference binaryReadStreamDo: doBlock
]

{ #category : #streams }
GtResourceReference >> binaryReadStreamDo: doBlock ifAbsent: absentBlock [
	^ self fileReference binaryReadStreamDo: doBlock ifAbsent: absentBlock
]

{ #category : #testing }
GtResourceReference >> exists [
	<return: #String>
	^ self fileReference exists
]

{ #category : #accessing }
GtResourceReference >> fileReference [
	<return: #FileReference>
	^ self utility resourceAtPath: self path
]

{ #category : #accessing }
GtResourceReference >> fullName [
	<return: #String>
	^ self fileReference fullName
]

{ #category : #testing }
GtResourceReference >> isDirectory [
	<return: #Boolean>
	^ self fileReference isDirectory
]

{ #category : #testing }
GtResourceReference >> isFile [
	<return: #Boolean>
	^ self fileReference isFile
]

{ #category : #testing }
GtResourceReference >> isReadable [
	<return: #Boolean>
	^ self fileReference isReadable
]

{ #category : #accessing }
GtResourceReference >> path [
	^ path
]

{ #category : #accessing }
GtResourceReference >> path: anObject [
	path := anObject
]

{ #category : #printing }
GtResourceReference >> printOn: aStream [
	self fileReference printOn: aStream
]

{ #category : #streams }
GtResourceReference >> readStreamDo: doBlock [
	^ self fileReference readStreamDo: doBlock
]

{ #category : #streams }
GtResourceReference >> readStreamDo: doBlock ifAbsent: absentBlock [
	^ self fileReference readStreamDo: doBlock ifAbsent: absentBlock
]

{ #category : #streams }
GtResourceReference >> readStreamEncoded: anEncoding do: doBlock [
	^ self fileReference readStreamEncoded: anEncoding do: doBlock
]

{ #category : #accessing }
GtResourceReference >> results [
	<return: #Array of: #GtResourcesUtilityResultContext>
	^ self utility locationsAtPath: self path
]

{ #category : #accessing }
GtResourceReference >> size [
	"Return the size of the file in bytes."
	<return: #Integer>
	^ self fileReference size
]

{ #category : #accessing }
GtResourceReference >> utility [
	^ utility ifNil: [ GtResourcesUtility default ]
]

{ #category : #accessing }
GtResourceReference >> utility: anObject [
	utility := anObject
]

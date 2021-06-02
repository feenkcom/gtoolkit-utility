"
GtUrlStringUtility provides a mechanism for accepting file paths or URL, relative to a specified root directory.

Note that URLs are ascii strings with percent-encoding for other characters.  IRIs (see https://datatracker.ietf.org/doc/html/rfc3987) are not supported.


"
Class {
	#name : #GtUrlStringUtility,
	#superclass : #Object,
	#instVars : [
		'znUrl',
		'rootDirectory'
	],
	#category : #'GToolkit-Utility-URL-Model'
}

{ #category : #'instance creation' }
GtUrlStringUtility class >> rootDirectory: aFileReference [

	^ self new rootDirectory: aFileReference
]

{ #category : #private }
GtUrlStringUtility >> findPath: pathString [
	"Answer a FileReference for the supplied pathString.
	Answer nil if the file doesn't exist (the root directory isn't allowed)"
	| pathReference fileReference |

	pathString ifEmpty: [ ^ nil ].

	"If the path exists, answer it"
	pathReference := pathString asFileReference.
	pathReference exists ifTrue: [ ^ pathReference asZnUrl ].

	"If the path resolves against the rootDirectory, answer it"
	fileReference := self rootDirectory resolve: pathString.
	fileReference exists ifTrue: [ ^ fileReference asZnUrl ].

	"Try the path as an absolute path"
	fileReference := FileLocator root resolve: pathString.
	fileReference exists ifTrue: [ ^ fileReference asZnUrl ].

	"Answer the path string as a URL without default resolution"
	^ pathReference asZnRelativeUrl.

]

{ #category : #testing }
GtUrlStringUtility >> isValid [ 
	"Answer a boolean indicating whether the receiver's URL is considered valied, i.e.:
	- It is a file URL which exists
	- It is a valid looking URL (scheme ~= #file, no existence checking)"
	<return: #Boolean>

	znUrl ifNil: [ ^ false ].
	(znUrl hasScheme and: [ znUrl isFile not ]) ifTrue: [ ^ true ].
	^ znUrl asFileReference exists.

]

{ #category : #printing }
GtUrlStringUtility >> printOn: aStream [

	znUrl ifNil: [ ^ super printOn: aStream ].
	znUrl printOn: aStream.
]

{ #category : #private }
GtUrlStringUtility >> resolveUrl: aUrlString [
	"For file urls, resolve against the supplied root directory, and allow file urls of the form 'file:///path/to/image.png' (the host is missing), with the same resolution"

	(aUrlString indexOfSubCollection: '://') = 0 ifTrue: [ ^ self findPath: aUrlString ].

	(aUrlString beginsWith: 'file://') ifFalse: [ ^ ZnUrl fromString: aUrlString ].

	^ self findPath: (ZnUrl fromString: aUrlString) path.

]

{ #category : #accessing }
GtUrlStringUtility >> rootDirectory [

	^ rootDirectory ifNil: [ FileLocator workingDirectory ]
]

{ #category : #accessing }
GtUrlStringUtility >> rootDirectory: aFileReference [

	rootDirectory := aFileReference asFileReference 

]

{ #category : #accessing }
GtUrlStringUtility >> url [ 

	^ znUrl
]

{ #category : #accessing }
GtUrlStringUtility >> urlString [

	^ znUrl asString
]

{ #category : #accessing }
GtUrlStringUtility >> urlString: aString [ 

	znUrl := self resolveUrl: aString
]

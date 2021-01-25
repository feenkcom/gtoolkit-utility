"
GtUrlStringUtility can be used to work with strings that can be either file names or URLs.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	urlString:		<Object>


    Implementation Points
"
Class {
	#name : #GtUrlStringUtility,
	#superclass : #Object,
	#instVars : [
		'urlString',
		'rootDirectory'
	],
	#category : #'GToolkit-Utility-URL'
}

{ #category : #private }
GtUrlStringUtility >> cleanPlainFileURL: aUrlString [
	"For file urls, resolve against the database directory or root directory, and allow file urls of the form 'file://path/to/image.png' (the host is missing), with the same resolution"
	| absPath |

	absPath := self findFileUrlPath: aUrlString.
	absPath ifNotNil: [ ^ 'file://localhost', absPath ].

	^ aUrlString

]

{ #category : #private }
GtUrlStringUtility >> cleanSchemeURL: aUrlString [
	"For file urls, resolve against the database directory or root directory, and allow file urls of the form 'file://path/to/image.png' (the host is missing), with the same resolution"
	| absPath pathString |

	pathString := aUrlString copyFrom: 8 to: aUrlString size.

	"Assume the host is present, search for the path"
	absPath := self findFileUrlPath: ($/ join: (($/ split: pathString) allButFirst)).
	absPath ifNotNil: [ ^ 'file://localhost', absPath ].

	"Assume the host is actually part of the path and search for it"
	absPath := self findFileUrlPath: pathString.
	absPath ifNotNil: [ ^ 'file://localhost', absPath ].

	^ aUrlString

]

{ #category : #private }
GtUrlStringUtility >> cleanURL: aUrlString [
	"For file urls, resolve against the supplied root directory, and allow file urls of the form 'file:///path/to/image.png' (the host is missing), with the same resolution"

	(aUrlString indexOfSubCollection: '://') = 0 ifTrue: 
		[ ^ self cleanPlainFileURL: aUrlString ].

	(aUrlString beginsWith: 'file://') ifFalse: [ ^ aUrlString ].

	^ self cleanSchemeURL: aUrlString.

]

{ #category : #private }
GtUrlStringUtility >> findFileUrlPath: pathString [
	"Try to find the supplied path resolved against the supplied root directory or as an absolute path.
	Answer nil if path not found"
	| absPath |

	pathString ifEmpty: [ ^ nil ].
	absPath := self rootDirectory resolve: pathString.
	^ absPath exists ifTrue: 
		[ absPath pathString ]
	ifFalse: 
		[ absPath := ('/', pathString) asFileReference.
		absPath exists ifTrue: 
			[ absPath pathString ]
		ifFalse:
			[ nil ] ]

]

{ #category : #testing }
GtUrlStringUtility >> isValid [ 
	"Answer a boolean indicating whether the receiver's URL is considered valied, i.e.:
	- It is a file name which exists
	- It is a file URL on the localhost which exists
	- It is a valid looking URL (no real checking done here)"
	| cleanUrl relativePath |

	cleanUrl := urlString asZnUrl.
	(cleanUrl hasScheme and: [ cleanUrl isFile not ]) ifTrue: [ ^ true ].
	relativePath := cleanUrl path.
	relativePath asFileReference exists ifTrue: [ ^ true ].
	('/', relativePath) asFileReference exists ifTrue: [ ^ true ].
	^ (self rootDirectory resolve: cleanUrl path) asFileReference exists.
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
GtUrlStringUtility >> urlString [
	^ urlString
]

{ #category : #accessing }
GtUrlStringUtility >> urlString: aString [ 

	urlString := self cleanURL: aString
]

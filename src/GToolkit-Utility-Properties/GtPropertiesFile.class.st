"
GtJsonPropertiesFile is an abstract class that facilitates the use of properties files that are basically JSON files, with some interpretation of values.
 
## Internal Representation and Key Implementation Points.

### Instance Variables
	file:		<Object>


### Implementation Points
"
Class {
	#name : 'GtPropertiesFile',
	#superclass : 'Object',
	#instVars : [
		'file',
		'properties'
	],
	#category : 'GToolkit-Utility-Properties'
}

{ #category : 'accessing' }
GtPropertiesFile class >> file: aFileReference [
	"Answer a new instance of the receiver with the specified properties file"

	^ self new file: aFileReference
]

{ #category : 'accessing - properties' }
GtPropertiesFile >> at: aSymbol [
	<return: #String or: #Dictionary>

	^ properties at: aSymbol
]

{ #category : 'accessing - properties' }
GtPropertiesFile >> at: aSymbol ifAbsent: absentBlock [
	<return: #String or: #Dictionary>

	^ properties at: aSymbol ifAbsent: absentBlock
]

{ #category : 'accessing - properties' }
GtPropertiesFile >> at: aSymbol ifPresent: presentBlock ifAbsent: absentBlock [

	^ properties 
		at: aSymbol 
		ifPresent: presentBlock
		ifAbsent: absentBlock
]

{ #category : 'accessing - properties' }
GtPropertiesFile >> at: propertyName put: aJSONObject [

	aJSONObject ifNil: 
		[ properties removeKey: propertyName ifAbsent: [ ].
		^ self saveProperties ].
	(properties at: propertyName ifAbsent: [nil]) = aJSONObject ifTrue: [ ^ self ].
	properties at: propertyName put: aJSONObject.
	self saveProperties.
]

{ #category : 'accessing' }
GtPropertiesFile >> file [
	<return: #FileReference>

	^ file
]

{ #category : 'accessing' }
GtPropertiesFile >> file: aFileReference [

	file := aFileReference.
	self loadProperties.
]

{ #category : 'private' }
GtPropertiesFile >> fileReferenceFrom: aString [
	"Answer a FileReference or FileLocator from the supplied string.
	FileLocator origins are available as formatted strings, e.g.
		{home}/lepiter
	is the equivalent of
		FileLocator home / 'lepiter'"
	| namedDirectories regex name path |

	namedDirectories := (FileLocator supportedOrigins collect: [ :origin | 
		origin -> (FileLocator origin: origin) ]) asDictionary.
	regex := '\{([a-zA-Z]+)\}(.*)' asRegex.
	^ (regex matches: aString) ifTrue: 
		[ name := regex subexpression: 2.
		path := regex subexpression: 3.
		namedDirectories at: name
			ifPresent: [ :locator | locator resolve: path allButFirst ]
			ifAbsent: [ self error: 'Unknown directory: ', name printString ] ]
	ifFalse:
	 	[ aString asFileReference ].
]

{ #category : 'private' }
GtPropertiesFile >> fileReferenceString: aFileReferenceStringOrNil [
	"Answer the string form of the supplied reference"

	aFileReferenceStringOrNil ifNil: [ ^ nil ].
	^ aFileReferenceStringOrNil ifNotNil: 
			[ aFileReferenceStringOrNil isString ifTrue:
				[ aFileReferenceStringOrNil ]
			ifFalse: [ aFileReferenceStringOrNil class = FileLocator
				ifTrue: [ aFileReferenceStringOrNil asString ]
				ifFalse: [ String streamContents: [ :stream | 
						aFileReferenceStringOrNil fileSystem 
							printPath: aFileReferenceStringOrNil path 
							on: stream ] ] ] ]
]

{ #category : 'initialization' }
GtPropertiesFile >> initialize [ 

	super initialize.
	properties := Dictionary new.
]

{ #category : 'private' }
GtPropertiesFile >> loadProperties [

	file exists ifFalse: [ ^ self ].
	self halt.
	properties := file readStreamDo: [ :stream |
		LeJsonV4 default deserialize: stream ].

]

{ #category : 'private' }
GtPropertiesFile >> saveProperties [

	file writeStreamDo: [ :stream |
		stream truncate.
		LeJsonV4 default
			serialize: properties 
			on: (ZnNewLineWriterStream on: stream)
			prettyPrint: true ].
]

{ #category : 'accessing' }
GtPropertiesFile >> size [ 

	^ properties size
]

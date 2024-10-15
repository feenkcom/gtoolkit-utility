"
GtJsonPropertiesFile is an abstract class that facilitates the use of properties files that are basically JSON files, with some interpretation of values.
 
## Internal Representation and Key Implementation Points.

### Instance Variables
	file:		<Object>


### Implementation Points
"
Class {
	#name : #GtPropertiesFile,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'file',
		'properties',
		'announcer'
	],
	#category : 'GToolkit-Utility-Properties'
}

{ #category : #accessing }
GtPropertiesFile class >> file: aFileReference [
	"Answer a new instance of the receiver with the specified properties file"

	^ self new file: aFileReference
]

{ #category : #accessing }
GtPropertiesFile >> announcer [

	^ announcer
]

{ #category : #'accessing - properties' }
GtPropertiesFile >> at: aSymbol [
	<return: #String or: #Dictionary>

	^ properties at: aSymbol
]

{ #category : #'accessing - properties' }
GtPropertiesFile >> at: aSymbol ifAbsent: absentBlock [
	<return: #String or: #Dictionary>

	^ properties at: aSymbol ifAbsent: absentBlock
]

{ #category : #'accessing - properties' }
GtPropertiesFile >> at: aSymbol ifPresent: presentBlock ifAbsent: absentBlock [

	^ properties 
		at: aSymbol 
		ifPresent: presentBlock
		ifAbsent: absentBlock
]

{ #category : #'accessing - properties' }
GtPropertiesFile >> at: propertyName put: aJSONObject [

	aJSONObject ifNil: 
		[ properties removeKey: propertyName ifAbsent: [ ].
		^ self saveProperties ].
	(properties at: propertyName ifAbsent: [nil]) = aJSONObject ifTrue: [ ^ self ].
	properties at: propertyName put: aJSONObject.
	self saveProperties.
	^ aJSONObject
]

{ #category : #accessing }
GtPropertiesFile >> file [
	<return: #FileReference>

	^ file
]

{ #category : #accessing }
GtPropertiesFile >> file: aFileReference [

	file := aFileReference.
	self loadProperties.
]

{ #category : #initialization }
GtPropertiesFile >> initialize [ 

	super initialize.
	announcer := Announcer new.
	properties := Dictionary new.
]

{ #category : #private }
GtPropertiesFile >> loadProperties [

	file exists ifFalse: [ ^ self ].
	properties := file readStreamDo: [ :stream |
		LeJsonV4 default deserialize: stream ].

]

{ #category : #printing }
GtPropertiesFile >> printOn: aStream [

	file
		ifNil: [ super printOn: aStream ]
		ifNotNil: 
			[ aStream 
				<< file basename;
				<< ' @ ';
				<< file parent fullName ]
]

{ #category : #private }
GtPropertiesFile >> saveProperties [

	file writeStreamDo: [ :stream |
		stream truncate.
		LeJsonV4 default
			serialize: properties 
			on: (ZnNewLineWriterStream on: stream)
			prettyPrint: true ].
]

{ #category : #accessing }
GtPropertiesFile >> size [ 

	^ properties size
]

Class {
	#name : #GtResourcesUtilityPluggableLocation,
	#superclass : #GtResourcesUtilityLocation,
	#instVars : [
		'directory'
	],
	#category : #'GToolkit-Utility-Resources-Locations'
}

{ #category : #accessing }
GtResourcesUtilityPluggableLocation >> directory [

	^ directory
]

{ #category : #accessing }
GtResourcesUtilityPluggableLocation >> directory: anObject [

	directory := anObject
]

{ #category : #initialization }
GtResourcesUtilityPluggableLocation >> initialize [

	super initialize.
	directory := FileLocator imageDirectory
]

{ #category : #printing }
GtResourcesUtilityPluggableLocation >> printOn: aStream [

	aStream
		nextPutAll: 'directory ';
		print: self directory
]

{ #category : #accessing }
GtResourcesUtilityPluggableLocation >> resourceAtPath: aStringOrPath [
	"Search the path in local (deployed) directory"
	<return: #GtResourcesUtilityLocationResult>
	^ self resultForPath: aStringOrPath in: self directory
]

"
I am passed as a searched item to a ${class:GtSpotter}$ list, see for example the ${method:GtResourcesUtility>>#spotterStringResourcesAtLocationsFor:}$ method.

I keep a ${class:GtResourcesUtilityLocation}$ object as a search context (root directory).
I keep a ${class:GtResourcesUtilityLocationResult}$ object as a resource search result.

"
Class {
	#name : #GtResourcesUtilityResultContext,
	#superclass : #Object,
	#instVars : [
		'location',
		'result'
	],
	#category : #'GToolkit-Utility-Resources-Support'
}

{ #category : #testing }
GtResourcesUtilityResultContext >> exists [
	<return: #Boolean>
	^ self result exists
]

{ #category : #accessing }
GtResourcesUtilityResultContext >> location [
	<return: #GtResourcesUtilityLocation>
	^ location
]

{ #category : #accessing }
GtResourcesUtilityResultContext >> location: aGtResourcesUtilityLocation [
	location := aGtResourcesUtilityLocation
]

{ #category : #printing }
GtResourcesUtilityResultContext >> printOn: aStream [
	self location ifNil: [ ^ super printOn: aStream ].
	self result ifNil: [ ^ aStream print: self location ].
	aStream
		print: self result;
		nextPutAll: ' at ';
		print: self location
]

{ #category : #accessing }
GtResourcesUtilityResultContext >> resourceAtPath: aPath [
	<return: #GtResourcesUtilityLocationResult>
	| aResult |
	aResult := self location resourceAtPath: aPath.
	self result: aResult.
	^ aResult
]

{ #category : #accessing }
GtResourcesUtilityResultContext >> result [
	<return: #GtResourcesUtilityLocationResult>
	^ result
]

{ #category : #accessing }
GtResourcesUtilityResultContext >> result: aGtResourcesUtilityLocationResult [
	result := aGtResourcesUtilityLocationResult
]

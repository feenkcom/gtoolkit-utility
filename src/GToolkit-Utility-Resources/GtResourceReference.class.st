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

{ #category : #accessing }
GtResourceReference >> initialize [
	super initialize.
	utility := GtResourcesUtility default.
]

{ #category : #accessing }
GtResourceReference >> path [
	^ path
]

{ #category : #accessing }
GtResourceReference >> path: anObject [
	path := anObject
]

{ #category : #accessing }
GtResourceReference >> utility [
	^ utility
]

{ #category : #accessing }
GtResourceReference >> utility: anObject [
	utility := anObject
]

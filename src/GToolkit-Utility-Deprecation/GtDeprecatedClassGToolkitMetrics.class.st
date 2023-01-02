Class {
	#name : #GtDeprecatedClassGToolkitMetrics,
	#superclass : #Object,
	#instVars : [
		'gtoolkitProject'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-Utility-Deprecation'
}

{ #category : #accessing }
GtDeprecatedClassGToolkitMetrics class >> cleanUp [
	defaultInstance := nil
]

{ #category : #accessing }
GtDeprecatedClassGToolkitMetrics class >> defaultInstance [
	<gtExample>
	<noTest>
	
	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #accessing }
GtDeprecatedClassGToolkitMetrics class >> deprecatedClasses [
	<gtExample>
	<noTest>
	
	^ self gtoolkitProject deprecatedClasses
]

{ #category : #accessing }
GtDeprecatedClassGToolkitMetrics class >> deprecatedClassesWithNoReferences [
	<gtExample>
	<noTest>
	
	^ self gtoolkitProject deprecatedClassesWithNoReferences
]

{ #category : #accessing }
GtDeprecatedClassGToolkitMetrics class >> gtoolkitProject [
	<gtExample>
	<noTest>
	
	^ self defaultInstance gtoolkitProject
]

{ #category : #accessing }
GtDeprecatedClassGToolkitMetrics >> gtoolkitProject [
	^ gtoolkitProject ifNil: [
		gtoolkitProject := GtDeprecatedClassProjectWrapper forGToolkit. ]
]

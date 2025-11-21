Class {
	#name : #GtMigrationUtilityExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : 'GToolkit-Utility-System-Examples'
}

{ #category : #examples }
GtMigrationUtilityExamples >> currentVersion [
	"Make a call using the current version."

	<gtExample>
	<return: #GtMigrationUtilityExamples>
	| value |
	value := self
			gtUpToVersion: 'v0.8.2290'
			do: [ 1 ]
			after: [ 2 ].
	self assert: value equals: 2
]

{ #category : #examples }
GtMigrationUtilityExamples >> versionAfter [
	"Check that version specific method execution is working as expected."

	<gtExample>
	<return: #GtMigrationUtilityExamples>
	| value |
	value := self
			gtUpToVersion: 'v0.8.2281'
			currentVersion: 'v0.8.2280'
			do: [ 1 ]
			after: [ 2 ].
	self assert: value equals: 1
]

{ #category : #examples }
GtMigrationUtilityExamples >> versionEarlier [
	"Check that version specific method execution is working as expected."

	<gtExample>
	<return: #GtMigrationUtilityExamples>
	| value |
	value := self
			gtUpToVersion: 'v0.8.2279'
			currentVersion: 'v0.8.2280'
			do: [ 1 ]
			after: [ 2 ].
	self assert: value equals: 2
]

{ #category : #examples }
GtMigrationUtilityExamples >> versionEqual [
	"Check that version specific method execution is working as expected."

	<gtExample>
	<return: #GtMigrationUtilityExamples>
	| value |
	value := self
			gtUpToVersion: 'v0.8.2280'
			currentVersion: 'v0.8.2280'
			do: [ 1 ]
			after: [ 2 ].
	self assert: value equals: 1
]

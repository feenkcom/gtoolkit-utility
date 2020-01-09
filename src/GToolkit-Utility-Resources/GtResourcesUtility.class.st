"
I find a ${class:FileReference}$ to a directory or file that in one of a locations.
My main method is ${method:GtResourcesUtility>>#resourceAtPath:}$.

I keep ${class:GtResourcesUtilityLocation}$ instances. Each instance defines where a resource is searched. Check individual class comments ${class:GtResourcesUtilityLocation|expanded=true|show=#gtSubclassesFor:|height=150}$ for more details.

!! Live Search 

You can search live here by clicking on the search icon in the inspector: 
${example:GtResourcesUtilityExamples>>#resourceUtility|noCode|previewHeight=200}$

!! Usage

You can either use a relative ${class:Path}$ to a recourse:
${example:GtResourcesUtilityExamples>>#gtResourceAtFeenkUtilityDefinedAsPath}$

Or you can pass a ${class:String}$ as a relative resource path:
${example:GtResourcesUtilityExamples>>#gtResourceAtFeenkUtilityDefinedAsString}$

In case of non-existing path, it will return a possible reference inside of the ${method:IceLibgitRepository class>>#repositoriesLocation}$ directory:
${example:GtResourcesUtilityExamples>>#gtResourceAtNonExistingPath}$

"
Class {
	#name : #GtResourcesUtility,
	#superclass : #Object,
	#instVars : [
		'locations'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Utility-Resources-Core'
}

{ #category : #cleanup }
GtResourcesUtility class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #'accessing - instance' }
GtResourcesUtility class >> default [
	^ self uniqueInstance
]

{ #category : #cleanup }
GtResourcesUtility class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #'accessing - files' }
GtResourcesUtility class >> resourceAtPath: aPath [
	^ self default resourceAtPath: aPath
]

{ #category : #'accessing - instance' }
GtResourcesUtility class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #initialization }
GtResourcesUtility >> defaultLocations [
	| aCollection |
	aCollection := GtResourcesUtilityLocation allSubclasses
		reject: [ :eachClass | eachClass isAbstract ].
	aCollection sort: [ :a :b | a defaultPriority < b defaultPriority ].
	^ aCollection collect: [ :eachClass | eachClass new ] as: Array
]

{ #category : #initialization }
GtResourcesUtility >> initialize [
	super initialize.
	self locations: self defaultLocations.
]

{ #category : #accessing }
GtResourcesUtility >> localGtDirectory [
	^ GtResourcesUtilityConstants localGtDirectory
]

{ #category : #accessing }
GtResourcesUtility >> locations [
	^ locations
]

{ #category : #accessing }
GtResourcesUtility >> locations: anObject [
	locations := anObject
]

{ #category : #accessing }
GtResourcesUtility >> locationsAtPath: aPathOrString [
	<return: #Array of: #GtResourcesUtilityResultContext>
	^ self locations collect: [ :eachLocation |
		GtResourcesUtilityResultContext new
			location: eachLocation; 
			result: (eachLocation resourceAtPath: aPathOrString) ].
]

{ #category : #accessing }
GtResourcesUtility >> repositoriesLocation [
	"Return an Iceberg repositories location. 
	It is a local disk location where source code repositories take place.
	Always consider using ${method:GtIcebergUtility>>#resourceAtPath:}$ instead of this method.
	See the ${class:GtIcebergUtility}$ class comment for usage."
	<return: #FileReference>
	^ GtResourcesUtilityConstants icebergRepositoriesLocation
]

{ #category : #accessing }
GtResourcesUtility >> resourceAtPath: aPathOrString [
	"Return a resource (file, directory) pointing to an Iceberg repository or to a local (deployed) Gt directory.
	See the ${class:GtResourcesUtility}$ class comment for more details."
	<return: #FileReference>
	| aFirstResult aResult |
	aFirstResult := nil.
	self locations do: [ :eachLocation | 
		aResult := eachLocation resourceAtPath: aPathOrString.
		aResult exists ifTrue: [ ^ aResult file ].
		aFirstResult ifNil: [ aFirstResult := aResult ] ].
	^ aFirstResult file
]

"
I find a {{gtClass:FileReference}} resource (file or directory)) that is in one of locations.
My main method is {{gtMethod:GtResourcesUtility>>#resourceAtPath:}}.

I keep {{gtClass:GtResourcesUtilityLocation}} instances. Each instance defines where a resource is searched. Check individual class comments {{gtClass:GtResourcesUtilityLocation|expanded=true|show=#gtSubclassesFor:|height=150}} for more details.

1. # Live Search 


You can search live here by clicking on the search icon in the inspector: 
{{gtExample:GtResourcesUtilityExamples>>#resourceUtility|noCode|previewHeight=200}}

1. # Usage


You can either use a relative {{gtClass:Path}} to a recourse:
{{gtExample:GtResourcesUtilityExamples>>#gtResourceAtFeenkUtilityDefinedAsPath}}

Or you can pass a {{gtClass:String}} as a relative resource path:
{{gtExample:GtResourcesUtilityExamples>>#gtResourceAtFeenkUtilityDefinedAsString}}

In case of a non-existing path, I will return a possible reference inside of the {{gtMethod:IceLibgitRepository class>>#repositoriesLocation}} directory:
{{gtExample:GtResourcesUtilityExamples>>#gtResourceAtNonExistingPath}}


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
GtResourcesUtility >> location: aLocation [

	self locations: (self locations copyWith: aLocation)
]

{ #category : #accessing }
GtResourcesUtility >> locations [
	^ locations
]

{ #category : #accessing }
GtResourcesUtility >> locations: aCollection [
	locations := aCollection
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

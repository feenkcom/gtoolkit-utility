"
I find a ${class:FileReference}$ to a directory or file that is either in a ${method:IceLibgitRepository class>>#repositoriesLocation}$ or in another (deployment) location. See ${method:GtResourcesUtility>>#resourceAtPath:}$ for more details.

!! Example 

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
	#category : #'GToolkit-Utility-Resources'
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
GtResourcesUtility >> repositoriesLocation [
	"Return an Iceberg repositories location. 
	It is a local disk location where source code repositories take place.
	Always consider using ${method:GtIcebergUtility>>#resourceAtPath:}$ instead of this method.
	See the ${class:GtIcebergUtility}$ class comment for usage."
	<return: #FileReference>
	^ IceLibgitRepository repositoriesLocation
]

{ #category : #accessing }
GtResourcesUtility >> resourceAtMacOSResourcesDirectory: aPath [
	^ GtResourcesUtilityConstants resourcesGtDirectory resolvePath: aPath.
]

{ #category : #accessing }
GtResourcesUtility >> resourceAtPath: aPath [
	"Return a resource (file, directory) pointing to an Iceberg repository or to a local (deployed) Gt directory.
	See the ${class:GtIcebergUtility}$ class comment for more details."
	<return: #FileReference>
	| aFirstResult aResult |
	aFirstResult := nil.
	self locations do: [ :eachLocation | 
		aResult := eachLocation resourceAtPath: aPath.
		aResult exists ifTrue: [ aResult file ].
		aFirstResult ifNil: [ aFirstResult := aResult ] ].
	^ aFirstResult file
]

{ #category : #accessing }
GtResourcesUtility >> resourceAtPathOld: aPath [
	"Return a resource (file, directory) pointing to an Iceberg repository or to a local (deployed) Gt directory.
	See the ${class:GtIcebergUtility}$ class comment for more details."
	<return: #FileReference>
	| anIcebergFileReference aLocalFileReference anOsSpecificFileReference |
	"Search the path in Iceberg repositories."
	anIcebergFileReference := self repositoriesLocation resolvePath: aPath.
	anIcebergFileReference exists ifTrue: [ ^ anIcebergFileReference ].
	"Search the path in local (deployed) directory"
	aLocalFileReference := self localGtDirectory resolvePath: aPath.
	aLocalFileReference exists ifTrue: [ ^ aLocalFileReference ].
	"Search the path in OS specific directories"
	anOsSpecificFileReference := OSPlatform current gtResourceAtPath: aPath using: self.
	(anOsSpecificFileReference isNotNil and: [ anOsSpecificFileReference exists ]) 
		ifTrue: [ ^ anOsSpecificFileReference ].
	^ anIcebergFileReference
]

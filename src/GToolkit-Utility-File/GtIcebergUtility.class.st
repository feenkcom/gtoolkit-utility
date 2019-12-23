"
I find a ${class:FileReference}$ to a directory or file that is either in a ${method:IceLibgitRepository class>>#repositoriesLocation}$ or in another (deployment) location. See ${method:GtIcebergUtility class>>#resourceAtPath:}$ for more details.

!! Example 

You can either use a relative ${class:Path}$ to a recourse:
${example:GtIcebergUtilityExamples>>#gtResourceAtFeenkUtilityDefinedAsPath}$

Or you can pass a ${class:String}$ as a relative resource path:
${example:GtIcebergUtilityExamples>>#gtResourceAtFeenkUtilityDefinedAsString}$


"
Class {
	#name : #GtIcebergUtility,
	#superclass : #Object,
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
GtIcebergUtility class >> documentAtPath: aPath [
	"Return a document pointing to an Iceberg repository or to a local Gt directory"
	<return: #FileReference>
	self 
		deprecated: 'Please use #resourceAtPath: instead.'
		transformWith: '`@receiver documentAtPath: `@statements' -> '`@receiver resourceAtPath: `@statements'.
	
	^ self resourceAtPath: aPath
]

{ #category : #accessing }
GtIcebergUtility class >> documentsMatching: aPattern [
	<return: #Array of: #ReferenceFile>
	^ (IceRepository registry 
		select: [ :eachRepository | 
			eachRepository location notNil and: [ 
				(eachRepository location / 'doc') exists ] ])
		flatCollect: [ :eachRepository |
			(eachRepository location / 'doc') allChildrenMatching: aPattern ]
]

{ #category : #accessing }
GtIcebergUtility class >> pillarDocuments [
	<return: #Array of: #ReferenceFile>
	^ self documentsMatching: GtFileUtilityConstants pillarMatchingPattern
]

{ #category : #accessing }
GtIcebergUtility class >> repositoriesLocation [
	"Return an Iceberg repositories location. 
	It is a local disk location where source code repositories take place.
	Always consider using ${method:GtIcebergUtility class>>#resourceAtPath:}$ instead of this method.
	See the ${class:GtIcebergUtility}$ class comment for usage."
	<return: #FileReference>
	SystemVersion current major = 6 ifTrue: [ ^ IceRepository repositoriesLocation ].
	^ (self environment at: #IceLibgitRepository) repositoriesLocation
]

{ #category : #accessing }
GtIcebergUtility class >> resourceAtMacOSResourcesDirectory: aPath [
	^ GtFileUtilityConstants resourcesGtDirectory resolvePath: aPath.
]

{ #category : #accessing }
GtIcebergUtility class >> resourceAtPath: aPath [
	"Return a resource (file, directory) pointing to an Iceberg repository or to a local (deployed) Gt directory.
	See the ${class:GtIcebergUtility}$ class comment for more details."
	<return: #FileReference>
	| anIcebergFileReference aLocalFileReference anOnSpecificFileReference |
	"Search the path in Iceberg repositories."
	anIcebergFileReference := self repositoriesLocation resolvePath: aPath.
	anIcebergFileReference exists ifTrue: [ ^ anIcebergFileReference ].
	"Search the path in local (deployed) directory"
	aLocalFileReference := GtFileUtilityConstants localGtDirectory resolvePath: aPath.
	aLocalFileReference exists ifTrue: [ ^ aLocalFileReference ].
	"Search the path in a macOS Resources file"
	anOnSpecificFileReference := OSPlatform current gtResourceAtPath: aPath using: self.
	anOnSpecificFileReference exists ifTrue: [ ^ anOnSpecificFileReference ].
	^ anIcebergFileReference
]

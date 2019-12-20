Class {
	#name : #GtIcebergUtility,
	#superclass : #Object,
	#category : #'GToolkit-Utility-File'
}

{ #category : #accessing }
GtIcebergUtility class >> documentAtPath: aPath [
	"Return a document pointing to an Iceberg repository or to a local Gt directory"
	<return: #FileReference>
	| anIcebergFileReference aLocalFileReference aResourcesFileReference|
	anIcebergFileReference := GtIcebergUtility repositoriesLocation resolvePath: aPath.
	anIcebergFileReference exists ifTrue: [ ^ anIcebergFileReference ].
	aLocalFileReference := GtFileUtilityConstants localGtDirectory resolvePath: aPath.
	aLocalFileReference exists ifTrue: [ ^ aLocalFileReference ].
	aResourcesFileReference := GtFileUtilityConstants resourcesGtDirectory resolvePath: aPath.
	aResourcesFileReference exists ifTrue: [ ^ aResourcesFileReference ].
	^ anIcebergFileReference
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
	It is a local disk location where source code repositories take place"
	<return: #FileReference>
	| resources |
	SystemVersion current major = 6 ifTrue: [ ^ IceRepository repositoriesLocation ].
	resources := (FileLocator localDirectory / '..' / '..' / 'Resources' / 'gt-extra' / 'pharo-local' / 'iceberg') asFileReference.
	resources exists ifTrue: [ ^ resources ].
	^ (self environment at: #IceLibgitRepository) repositoriesLocation
]

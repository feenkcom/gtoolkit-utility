"
I search for a resource (file or directory) in Iceberg repositories directory:
${example:GtResourcesUtilityExamples>>#basicIcebergLocation|previewExpanded=true|noCode}$

"
Class {
	#name : #GtResourcesUtilityIcebergLocation,
	#superclass : #GtResourcesUtilityLocation,
	#category : #'GToolkit-Utility-Resources-Locations'
}

{ #category : #initialization }
GtResourcesUtilityIcebergLocation class >> defaultPriority [
	^ 10
]

{ #category : #printing }
GtResourcesUtilityIcebergLocation >> printOn: aStream [
	aStream nextPutAll: 'Iceberg repositories directory'
]

{ #category : #accessing }
GtResourcesUtilityIcebergLocation >> resourceAtPath: aPath [
	"Search the path in Iceberg repositories."
	<return: #GtResourcesUtilityLocationResult>
	| aFileReference |
	aFileReference := GtResourcesUtilityConstants icebergRepositoriesLocation resolvePath: aPath.
	^ self resultForFile: aFileReference
]

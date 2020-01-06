Class {
	#name : #GtResourcesUtilityIcebergLocation,
	#superclass : #GtResourcesUtilityLocation,
	#category : #'GToolkit-Utility-Resources'
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
GtResourcesUtilityIcebergLocation >> repositoriesLocation [
	^ GtResourcesUtility default repositoriesLocation
]

{ #category : #accessing }
GtResourcesUtilityIcebergLocation >> resourceAtPath: aPath [
	"Search the path in Iceberg repositories."
	<return: #GtResourcesUtilityLocationResult>
	| aFileReference |
	aFileReference := self repositoriesLocation resolvePath: aPath.
	^ self resultForFile: aFileReference
]

Class {
	#name : #GtResourcesUtilityGtExtraLocation,
	#superclass : #GtResourcesUtilityLocation,
	#category : #'GToolkit-Utility-Resources'
}

{ #category : #initialization }
GtResourcesUtilityGtExtraLocation class >> defaultPriority [
	^ 12
]

{ #category : #files }
GtResourcesUtilityGtExtraLocation >> localGtDirectory [
	^ GtResourcesUtility default localGtDirectory
]

{ #category : #printing }
GtResourcesUtilityGtExtraLocation >> printOn: aStream [
	aStream nextPutAll: 'gt-extra directory'
]

{ #category : #accessing }
GtResourcesUtilityGtExtraLocation >> resourceAtPath: aPath [
	"Search the path in local (deployed) directory"
	<return: #GtResourcesUtilityLocationResult>
	| aFileReference |
	aFileReference := self localGtDirectory resolvePath: aPath.
	^ self resultForFile: aFileReference
]

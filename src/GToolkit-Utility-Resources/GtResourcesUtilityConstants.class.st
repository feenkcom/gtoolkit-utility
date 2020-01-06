"
I keep constrants used by ${class:GtResourcesUtility}$.
"
Class {
	#name : #GtResourcesUtilityConstants,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources'
}

{ #category : #files }
GtResourcesUtilityConstants class >> localGtDirectory [
	<return: #FileReference>
	^ Smalltalk imageDirectory / self localGtDirectoryName
]

{ #category : #files }
GtResourcesUtilityConstants class >> localGtDirectoryName [
	^ 'gt-extra'
]

{ #category : #files }
GtResourcesUtilityConstants class >> resourcesGtDirectory [
	<return: #FileReference>
	^ FileLocator vmBinary asFileReference parent parent / 'Resources' / self localGtDirectoryName
]

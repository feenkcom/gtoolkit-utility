"
I search for a resource (file or directory) in a MacOS resources directory:
{{gtExample:GtResourcesUtilityExamples>>#basicMacOSResourcesLocation|previewExpanded=true|noCode}}


"
Class {
	#name : #GtResourcesUtilityMacOSResourcesLocation,
	#superclass : #GtResourcesUtilityLocation,
	#category : #'GToolkit-Utility-Resources-Locations'
}

{ #category : #initialization }
GtResourcesUtilityMacOSResourcesLocation class >> defaultPriority [
	^ 14
]

{ #category : #printing }
GtResourcesUtilityMacOSResourcesLocation >> printOn: aStream [
	aStream nextPutAll: 'macOS resources directory'
]

{ #category : #accessing }
GtResourcesUtilityMacOSResourcesLocation >> resourceAtMacOSResourcesDirectory: aStringOrPath [
	<return: #GtResourcesUtilityLocationResult>
	^ self resultForPath: aStringOrPath in: GtResourcesUtilityConstants resourcesGtDirectory
]

{ #category : #accessing }
GtResourcesUtilityMacOSResourcesLocation >> resourceAtPath: aPath [
	"Search the path in OS specific directories"
	<return: #GtResourcesUtilityLocationResult>
	^ OSPlatform current gtResourceAtPath: aPath using: self.
]

"
I search for a resource (file or directory) in a MacOS resources directory:
${example:GtResourcesUtilityExamples>>#basicMacOSResourcesLocation|previewExpanded=true|noCode}$

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
GtResourcesUtilityMacOSResourcesLocation >> resourceAtMacOSResourcesDirectory: aPath [
	<return: #GtResourcesUtilityLocationResult>
	| aFile |
	aFile := GtResourcesUtilityConstants resourcesGtDirectory asFileReference resolvePath: aPath.
	^ self resultForFile: aFile
]

{ #category : #accessing }
GtResourcesUtilityMacOSResourcesLocation >> resourceAtPath: aPath [
	"Search the path in OS specific directories"
	<return: #GtResourcesUtilityLocationResult>
	^ OSPlatform current gtResourceAtPath: aPath using: self.
]

Class {
	#name : #GtResourcesUtilityMacOSResourcesLocation,
	#superclass : #GtResourcesUtilityLocation,
	#category : #'GToolkit-Utility-Resources'
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
	aFile := GtResourcesUtilityConstants resourcesGtDirectory resolvePath: aPath.
	^ self resultForFile: aFile
]

{ #category : #accessing }
GtResourcesUtilityMacOSResourcesLocation >> resourceAtPath: aPath [
	"Search the path in OS specific directories"
	<return: #GtResourcesUtilityLocationResult>
	^ OSPlatform current gtResourceAtPath: aPath using: self.
]

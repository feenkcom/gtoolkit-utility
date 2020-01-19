"
I search for a resource (file or directory) in a ${example:GtResourcesUtilityExamples>>#gtExtraDirectory|label=#basename}$ directory:
${example:GtResourcesUtilityExamples>>#basicGtExtraLocation|previewExpanded=true|noCode}$

"
Class {
	#name : #GtResourcesUtilityGtExtraLocation,
	#superclass : #GtResourcesUtilityLocation,
	#category : #'GToolkit-Utility-Resources-Locations'
}

{ #category : #initialization }
GtResourcesUtilityGtExtraLocation class >> defaultPriority [
	^ 12
]

{ #category : #printing }
GtResourcesUtilityGtExtraLocation >> printOn: aStream [
	aStream nextPutAll: 'gt-extra directory'
]

{ #category : #accessing }
GtResourcesUtilityGtExtraLocation >> resourceAtPath: aStringOrPath [
	"Search the path in local (deployed) directory"
	<return: #GtResourcesUtilityLocationResult>
	^ self resultForPath: aStringOrPath in: GtResourcesUtilityConstants localGtDirectory
]

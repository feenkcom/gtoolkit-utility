Class {
	#name : #GtResourcesUtilityLocation,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources'
}

{ #category : #initialization }
GtResourcesUtilityLocation class >> defaultPriority [
	^ 50
]

{ #category : #accessing }
GtResourcesUtilityLocation >> resourceAtPath: aPath [
	<return: #GtResourcesUtilityLocationResult>
	^ GtResourcesUtilityLocationResult null
]

{ #category : #private }
GtResourcesUtilityLocation >> resultForFile: aFileReference [
	<return: #GtResourcesUtilityLocationResult>
	^ aFileReference exists 
		ifTrue: [ GtResourcesUtilityLocationExistingResult new file: aFileReference ]
		ifFalse: [ GtResourcesUtilityLocationNoResult new file: aFileReference ].
]

"
Use ${class:GtResourcesUtility}$ instead.
"
Class {
	#name : #GtIcebergUtility,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Resources'
}

{ #category : #testing }
GtIcebergUtility class >> isDeprecated [
	^ true
]

{ #category : #accessing }
GtIcebergUtility class >> resourceAtPath: aPath [
	^ GtResourcesUtility default resourceAtPath: aPath
]

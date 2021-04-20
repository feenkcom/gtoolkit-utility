Class {
	#name : #GtRobocoderForOneMetamodelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #examples }
GtRobocoderForOneMetamodelExamples >> newMetamodel [
	<gtExample>
	| aMetamodel |

	aMetamodel := GtRobocoderForOneMetamodel new.

	self assert: aMetamodel name equals: ''.
	self assert: aMetamodel prefix equals: ''.
	self assert: aMetamodel project equals: ''.
	self assert: aMetamodel suffix equals: ''.
	self assert: aMetamodel objectClassName equals: ''.
	self assert: aMetamodel package equals: 'MyPackage'.
	self assert: aMetamodel tag equals: ''.

	self assert: aMetamodel isForOne.
	self assert: aMetamodel isForMany not.
	self assert: aMetamodel alreadyHasClass not.
	self assert: aMetamodel hasParents not.

	^ aMetamodel
]

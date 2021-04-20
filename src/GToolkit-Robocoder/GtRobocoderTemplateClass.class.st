Class {
	#name : #GtRobocoderTemplateClass,
	#superclass : #GtRobocoderTemplateArtefact,
	#instVars : [
		'instanceSide',
		'classSide'
	],
	#category : #'GToolkit-Robocoder-Model'
}

{ #category : #accessing }
GtRobocoderTemplateClass >> classSide [
	^ classSide
]

{ #category : #accessing }
GtRobocoderTemplateClass >> classSide: anObject [
	classSide := anObject
]

{ #category : #accessing }
GtRobocoderTemplateClass >> instanceSide [
	^ instanceSide
]

{ #category : #accessing }
GtRobocoderTemplateClass >> instanceSide: anObject [
	instanceSide := anObject
]

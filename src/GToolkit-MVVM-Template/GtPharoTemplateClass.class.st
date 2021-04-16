Class {
	#name : #GtPharoTemplateClass,
	#superclass : #GtPharoTemplateArtefact,
	#instVars : [
		'instanceSide',
		'classSide'
	],
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #accessing }
GtPharoTemplateClass >> classSide [
	^ classSide
]

{ #category : #accessing }
GtPharoTemplateClass >> classSide: anObject [
	classSide := anObject
]

{ #category : #accessing }
GtPharoTemplateClass >> instanceSide [
	^ instanceSide
]

{ #category : #accessing }
GtPharoTemplateClass >> instanceSide: anObject [
	instanceSide := anObject
]

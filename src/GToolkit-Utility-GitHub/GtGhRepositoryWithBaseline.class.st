Class {
	#name : #GtGhRepositoryWithBaseline,
	#superclass : #Object,
	#instVars : [
		'gitHubRepository',
		'baselineRepository'
	],
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #accessing }
GtGhRepositoryWithBaseline >> baselineRepository [

	^ baselineRepository
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> baselineRepository: anObject [

	baselineRepository := anObject
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> gitHubRepository [

	^ gitHubRepository
]

{ #category : #accessing }
GtGhRepositoryWithBaseline >> gitHubRepository: anObject [

	gitHubRepository := anObject
]

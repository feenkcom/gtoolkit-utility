Class {
	#name : #GtOrElementViewModelConnection,
	#superclass : #GtOrObjectConnection,
	#instVars : [
		'element',
		'viewModel'
	],
	#category : #'GToolkit-Utility-ObjectConnections'
}

{ #category : #accessing }
GtOrElementViewModelConnection >> connectionKey [
	^ #brickViewModel
]

{ #category : #accessing }
GtOrElementViewModelConnection >> element [
	^ element
]

{ #category : #accessing }
GtOrElementViewModelConnection >> element: anElement [
	element := anElement
]

{ #category : #accessing }
GtOrElementViewModelConnection >> fromObject [
	^ self element
]

{ #category : #accessing }
GtOrElementViewModelConnection >> toObject [
	^ self viewModel
]

{ #category : #accessing }
GtOrElementViewModelConnection >> viewModel [
	^ viewModel
]

{ #category : #accessing }
GtOrElementViewModelConnection >> viewModel: aViewModel [
	viewModel := aViewModel
]

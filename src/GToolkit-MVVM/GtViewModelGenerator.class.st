Class {
	#name : #GtViewModelGenerator,
	#superclass : #Object,
	#traits : 'TGtModelClassGenerator',
	#classTraits : 'TGtModelClassGenerator classTrait',
	#instVars : [
		'viewModelName'
	],
	#category : #'GToolkit-MVVM-Generators'
}

{ #category : #accessing }
GtViewModelGenerator >> className [
	<return: #Symbol>
	
	self viewModelName
		ifNotNil: [ :aViewModelName | ^ aViewModelName ].
	
	^ Symbol streamContents: [ :aStream |
		aStream
			nextPutAll: self projectPrefix;
			nextPutAll: self modelName capitalized;
			nextPutAll: 'ViewModel' ]
]

{ #category : #initialization }
GtViewModelGenerator >> initialize [
	super initialize.
	
	traits := #()
]

{ #category : #accessing }
GtViewModelGenerator >> templateClass [
	^ GtViewModelClassTemplate
]

{ #category : #accessing }
GtViewModelGenerator >> viewModelName [
	^ viewModelName
]

{ #category : #accessing }
GtViewModelGenerator >> viewModelName: anObject [
	viewModelName := anObject
]

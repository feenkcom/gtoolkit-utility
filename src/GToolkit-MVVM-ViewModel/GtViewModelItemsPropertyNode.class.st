Class {
	#name : #GtViewModelItemsPropertyNode,
	#superclass : #GtViewModelPropertyNode,
	#instVars : [
		'suffix'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelItemsPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitItemsProperty: self
]

{ #category : #accessing }
GtViewModelItemsPropertyNode >> nameString [
	^ String streamContents: [ :aStream |
		aStream nextPutAll: self name source.
		self suffix
			ifNotNil: [ :aSuffixNode | aStream nextPutAll: aSuffixNode source ] ]
]

{ #category : #generated }
GtViewModelItemsPropertyNode >> suffix [
	^ suffix
]

{ #category : #generated }
GtViewModelItemsPropertyNode >> suffix: aSmaCCToken [
	suffix := aSmaCCToken
]

{ #category : #generated }
GtViewModelItemsPropertyNode >> tokenVariables [
	^ #(#suffix)
]

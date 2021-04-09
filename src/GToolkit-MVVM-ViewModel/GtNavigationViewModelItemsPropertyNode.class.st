Class {
	#name : #GtNavigationViewModelItemsPropertyNode,
	#superclass : #GtNavigationViewModelPropertyNode,
	#instVars : [
		'suffix'
	],
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelItemsPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitItemsProperty: self
]

{ #category : #accessing }
GtNavigationViewModelItemsPropertyNode >> nameString [
	^ String streamContents: [ :aStream |
		aStream nextPutAll: self name source.
		self suffix
			ifNotNil: [ :aSuffixNode | aStream nextPutAll: aSuffixNode source ] ]
]

{ #category : #generated }
GtNavigationViewModelItemsPropertyNode >> suffix [
	^ suffix
]

{ #category : #generated }
GtNavigationViewModelItemsPropertyNode >> suffix: aSmaCCToken [
	suffix := aSmaCCToken
]

{ #category : #generated }
GtNavigationViewModelItemsPropertyNode >> tokenVariables [
	^ #(#suffix)
]

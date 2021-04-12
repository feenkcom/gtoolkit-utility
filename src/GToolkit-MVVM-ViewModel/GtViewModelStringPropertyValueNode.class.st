Class {
	#name : #GtViewModelStringPropertyValueNode,
	#superclass : #GtViewModelPropertyValueNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelStringPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitStringPropertyValue: self
]

{ #category : #accessing }
GtViewModelStringPropertyValueNode >> literalValue [
	| aString |
	aString := self value value.
	aString first = $'
		ifTrue: [ aString := (aString copyFrom: 2 to: aString size - 1)
			copyReplaceAll: '''''' with: '''' ].
	^ aString
]

Class {
	#name : #GtViewModelSymbolPropertyValueNode,
	#superclass : #GtViewModelPropertyValueNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtViewModelSymbolPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSymbolPropertyValue: self
]

{ #category : #converting }
GtViewModelSymbolPropertyValueNode >> asSymbol [
	| name |
	name := self value source.
	name first = $#
		ifTrue: [ name := name copyFrom: 2 to: name size ].
	name first = $'
		ifTrue: [ name := (name copyFrom: 2 to: name size - 1) copyReplaceAll: '''''' with: '''' ].
	^ name asSymbol
]

{ #category : #accessing }
GtViewModelSymbolPropertyValueNode >> literalValue [
	^ self asSymbol
]

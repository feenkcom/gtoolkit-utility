Class {
	#name : #GtNavigationViewModelSymbolPropertyValueNode,
	#superclass : #GtNavigationViewModelPropertyValueNode,
	#category : #'GToolkit-MVVM-ViewModel-Ast'
}

{ #category : #generated }
GtNavigationViewModelSymbolPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSymbolPropertyValue: self
]

{ #category : #converting }
GtNavigationViewModelSymbolPropertyValueNode >> asSymbol [
	| name |
	name := self value source.
	name first = $#
		ifTrue: [ name := name copyFrom: 2 to: name size ].
	name first = $'
		ifTrue: [ name := (name copyFrom: 2 to: name size - 1) copyReplaceAll: '''''' with: '''' ].
	^ name asSymbol
]

{ #category : #accessing }
GtNavigationViewModelSymbolPropertyValueNode >> literalValue [
	^ self asSymbol
]

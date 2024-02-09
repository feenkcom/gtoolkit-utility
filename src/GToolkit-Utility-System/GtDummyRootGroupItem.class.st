Class {
	#name : #GtDummyRootGroupItem,
	#superclass : #Object,
	#instVars : [
		'valueA',
		'valueB'
	],
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #accessing }
GtDummyRootGroupItem class >> gtGroupType [
	^ GtDummyItemGroup
]

{ #category : #accessing }
GtDummyRootGroupItem >> valueA [
	^ valueA
]

{ #category : #accessing }
GtDummyRootGroupItem >> valueA: anObject [
	valueA := anObject
]

{ #category : #accessing }
GtDummyRootGroupItem >> valueB [
	^ valueB
]

{ #category : #accessing }
GtDummyRootGroupItem >> valueB: anObject [
	valueB := anObject
]

Class {
	#name : #GtDummyGroupAItem,
	#superclass : #GtDummyRootGroupItem,
	#instVars : [
		'valueC'
	],
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #accessing }
GtDummyGroupAItem class >> gtGroupType [
	^ GtDummyItemAGroup
]

{ #category : #accessing }
GtDummyGroupAItem >> valueC [
	^ valueC
]

{ #category : #accessing }
GtDummyGroupAItem >> valueC: anObject [
	valueC := anObject
]

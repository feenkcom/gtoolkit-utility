Class {
	#name : #GtDummyGroupBItem,
	#superclass : #GtDummyRootGroupItem,
	#instVars : [
		'valueD',
		'valueE'
	],
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #accessing }
GtDummyGroupBItem class >> gtGroupType [
	^ GtDummyItemBGroup
]

{ #category : #accessing }
GtDummyGroupBItem >> valueD [
	^ valueD
]

{ #category : #accessing }
GtDummyGroupBItem >> valueD: anObject [
	valueD := anObject
]

{ #category : #accessing }
GtDummyGroupBItem >> valueE [
	^ valueE
]

{ #category : #accessing }
GtDummyGroupBItem >> valueE: anObject [
	valueE := anObject
]

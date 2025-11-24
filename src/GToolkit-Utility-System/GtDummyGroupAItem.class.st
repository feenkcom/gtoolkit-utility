Class {
	#name : #GtDummyGroupAItem,
	#superclass : #GtDummyRootGroupItem,
	#instVars : [
		'valueA'
	],
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #accessing }
GtDummyGroupAItem class >> gtGroupType [
	^ GtDummyItemAGroup
]

{ #category : #'instance creation' }
GtDummyGroupAItem class >> valueY: aValueY valueZ: aValueZ valueA: aValueA [
	^ self new 
		valueY: aValueY valueZ: aValueZ valueA: aValueA
]

{ #category : #printing }
GtDummyGroupAItem >> descriptionOn: aStream [
	super descriptionOn: aStream.
	
	aStream 
		<< '; valueA=';
		print: valueA
]

{ #category : #accessing }
GtDummyGroupAItem >> valueA [
	^ valueA
]

{ #category : #initialization }
GtDummyGroupAItem >> valueY: aValueY valueZ: aValueZ valueA: aValueA [
	self commonValueY: aValueY commonValueZ: aValueZ.
	valueA := aValueA.
]

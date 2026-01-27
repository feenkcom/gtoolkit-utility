Class {
	#name : #GtDummyGroupBItem,
	#superclass : #GtDummyRootGroupItem,
	#instVars : [
		'valueB1',
		'valueB2'
	],
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #accessing }
GtDummyGroupBItem class >> gtGroupType [
	^ GtDummyItemBGroup
]

{ #category : #'instance creation' }
GtDummyGroupBItem class >> valueY: aValueY valueZ: aValueZ valueB1: aValueB1 valueB2: aValueB2 [
	^ self new 
		valueY: aValueY valueZ: aValueZ valueB1: aValueB1 valueB2: aValueB2
]

{ #category : #printing }
GtDummyGroupBItem >> descriptionOn: aStream [
	super descriptionOn: aStream.
	
	aStream 
		<< '; valueB1=';
		print: valueB1;
		<< '; valueB2=';
		print: valueB2
]

{ #category : #accessing }
GtDummyGroupBItem >> valueB1 [
	^ valueB1
]

{ #category : #accessing }
GtDummyGroupBItem >> valueB2 [
	^ valueB2
]

{ #category : #initialization }
GtDummyGroupBItem >> valueY: aValueY valueZ: aValueZ valueB1: aValueB1 valueB2: aValueB2 [
	self commonValueY: aValueY commonValueZ: aValueZ.
	valueB1 := aValueB1.
	valueB2 := aValueB2
]

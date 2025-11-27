Class {
	#name : #GtDummyRootGroupItem,
	#superclass : #Object,
	#instVars : [
		'commonValueY',
		'commonValueZ'
	],
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #accessing }
GtDummyRootGroupItem class >> gtGroupType [
	^ GtDummyItemGroup
]

{ #category : #accessing }
GtDummyRootGroupItem >> commonValueY [
	^ commonValueY
]

{ #category : #initialization }
GtDummyRootGroupItem >> commonValueY: aValueY commonValueZ: aValueZ [
	commonValueY := aValueY.
	commonValueZ := aValueZ.
]

{ #category : #accessing }
GtDummyRootGroupItem >> commonValueZ [
	^ commonValueZ
]

{ #category : #printing }
GtDummyRootGroupItem >> descriptionOn: aStream [
	
	aStream 
		<< 'commonValueY=';
		print: commonValueY;
		<< '; commonValueZ=';
		print: commonValueZ 
]

{ #category : #printing }
GtDummyRootGroupItem >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		self descriptionOn: aStream ]
]

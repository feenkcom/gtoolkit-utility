Class {
	#name : #GtReportsCompositeStore,
	#superclass : #GtReportsStore,
	#instVars : [
		'stores'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtReportsCompositeStore class >> withAll: aCollectionOfStores [
	^ self new setStores: aCollectionOfStores asArray

]

{ #category : #printing }
GtReportsCompositeStore >> description [
	^ String streamContents: [ :aStream |
		stores
			do: [ :each | aStream nextPutAll: each description ]
			separatedBy: [ aStream nextPutAll: ' and ' ] ]

]

{ #category : #accessing }
GtReportsCompositeStore >> entryFolderName: aFolderName filePrefix: aPrefix [
	| baseName |
	baseName := self baseNameWithPrefix: aPrefix.
	^ GtReportsCompositeStoreEntry entries: (stores collect: [ :each |
		each entryFolderName: aFolderName baseName: baseName ])

]

{ #category : #'gt - extensions' }
GtReportsCompositeStore >> gtSummaryFor: aView [
	<gtView>
	^ aView list
		title: 'Stores';
		priority: 5;
		items: [ stores ];
		itemText: [ :each | each description ]

]

{ #category : #initialization }
GtReportsCompositeStore >> setStores: anArray [
	stores := anArray

]

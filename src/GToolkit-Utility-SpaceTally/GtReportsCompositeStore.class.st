"
I store a report in several stores at once, with the same id and file names in each of them. The files are serialized once and written to every store.
"
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
GtReportsCompositeStore >> entryFor: aReport storageId: aStorageId [
	^ GtReportsCompositeStoreEntry entries: (stores collect: [ :each |
		each entryFor: aReport storageId: aStorageId ])

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

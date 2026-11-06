Class {
	#name : #GtReportsCompositeStoreEntry,
	#superclass : #Object,
	#instVars : [
		'entries'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtReportsCompositeStoreEntry class >> entries: aCollectionOfEntries [
	^ self new setEntries: aCollectionOfEntries asArray

]

{ #category : #accessing }
GtReportsCompositeStoreEntry >> files [
	^ entries flatCollect: [ :each | each files ]

]

{ #category : #'gt - extensions' }
GtReportsCompositeStoreEntry >> gtFilesFor: aView [
	<gtView>
	^ aView list
		title: 'Files';
		priority: 5;
		items: [ self files ];
		itemText: [ :each | each fullName ]

]

{ #category : #printing }
GtReportsCompositeStoreEntry >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			print: self files size;
			nextPutAll: ' files' ]

]

{ #category : #initialization }
GtReportsCompositeStoreEntry >> setEntries: anArray [
	entries := anArray

]

{ #category : #accessing }
GtReportsCompositeStoreEntry >> stateDescription [
	^ 'Saved'

]

{ #category : #actions }
GtReportsCompositeStoreEntry >> writeJsonOf: aReport [
	entries do: [ :each | each writeJsonOf: aReport ]

]

{ #category : #actions }
GtReportsCompositeStoreEntry >> writeText: aString extension: anExtension [
	entries do: [ :each | each writeText: aString extension: anExtension ]

]

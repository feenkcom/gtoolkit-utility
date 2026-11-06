Class {
	#name : #GtReportsStoreEntry,
	#superclass : #Object,
	#instVars : [
		'store',
		'folder',
		'baseName',
		'files'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtReportsStoreEntry class >> store: aStore folder: aFolder baseName: aString [
	^ self new setStore: aStore folder: aFolder baseName: aString

]

{ #category : #accessing }
GtReportsStoreEntry >> files [
	^ files

]

{ #category : #'gt - extensions' }
GtReportsStoreEntry >> gtFilesFor: aView [
	<gtView>
	^ aView list
		title: 'Files';
		priority: 5;
		items: [ files ];
		itemText: [ :each | each basename ]

]

{ #category : #printing }
GtReportsStoreEntry >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [ aStream nextPutAll: baseName ]

]

{ #category : #initialization }
GtReportsStoreEntry >> setStore: aStore folder: aFolder baseName: aString [
	store := aStore.
	folder := aFolder.
	baseName := aString.
	files := OrderedCollection new

]

{ #category : #private }
GtReportsStoreEntry >> write: aString extension: anExtension [
	| file |
	file := folder / (baseName , '.' , anExtension).
	store write: aString to: file.
	files add: file.
	^ file

]

{ #category : #actions }
GtReportsStoreEntry >> writeJsonOf: aReport [
	^ self write: (LeJsonV4 uniqueInstance serializePretty: aReport) extension: 'json'

]

{ #category : #actions }
GtReportsStoreEntry >> writeText: aString extension: anExtension [
	^ self write: aString extension: anExtension

]

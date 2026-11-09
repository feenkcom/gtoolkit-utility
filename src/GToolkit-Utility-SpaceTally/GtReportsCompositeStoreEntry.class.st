"
I am the entry of a composite store: I forward every write to one entry per store.
"
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

{ #category : #accessing }
GtReportsCompositeStoreEntry >> filesWithEntries [
	^ entries flatCollect: [ :anEntry |
		anEntry files collect: [ :aFile | anEntry -> aFile ] ]

]

{ #category : #'gt - extensions' }
GtReportsCompositeStoreEntry >> gtFilesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Files';
		priority: 5;
		items: [ self filesWithEntries ];
		column: 'Store' text: [ :each | each key storeDescription ] width: 100;
		column: 'Name' text: [ :each | each value basename ];
		column: 'Kind' text: [ :each | each value kindDescription ] width: 100;
		column: 'Size' text: [ :each | each value sizeDescription ] width: 90;
		column: 'Write duration' text: [ :each | each value writeDuration gtHumanReadableString ] width: 110;
		send: [ :each | each value ]

]

{ #category : #'gt - extensions' }
GtReportsCompositeStoreEntry >> gtFolderFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Folder';
		priority: 6;
		items: [ self filesWithEntries ];
		column: 'Store' text: [ :each | each key storeDescription ] width: 100;
		column: 'Name' text: [ :each | each value basename ];
		column: 'Location' text: [ :each | each value destination parent fullName ];
		send: [ :each | each value destination ]

]

{ #category : #'gt - extensions' }
GtReportsCompositeStoreEntry >> gtMetadataFor: aView [
	<gtView>
	^ aView forward
		title: 'Metadata';
		priority: 10;
		object: [ self metadata ];
		view: #gtSummaryFor:

]

{ #category : #accessing }
GtReportsCompositeStoreEntry >> metadata [
	^ entries first metadata

]

{ #category : #printing }
GtReportsCompositeStoreEntry >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			nextPutAll: self storeDescription;
			nextPutAll: ', ';
			nextPutAll: self storageId;
			nextPutAll: ', ';
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

{ #category : #accessing }
GtReportsCompositeStoreEntry >> storageId [
	^ entries first storageId

]

{ #category : #printing }
GtReportsCompositeStoreEntry >> storeDescription [
	^ String streamContents: [ :aStream |
		entries
			do: [ :each | aStream nextPutAll: each storeDescription ]
			separatedBy: [ aStream nextPutAll: ' and ' ] ]

]

{ #category : #actions }
GtReportsCompositeStoreEntry >> writeBytes: aByteArray extension: anExtension [
	entries do: [ :each | each writeBytes: aByteArray extension: anExtension ]

]

{ #category : #actions }
GtReportsCompositeStoreEntry >> writeBytes: aByteArray named: aName extension: anExtension [
	entries do: [ :each | each writeBytes: aByteArray named: aName extension: anExtension ]

]

{ #category : #actions }
GtReportsCompositeStoreEntry >> writeGzippedStonOf: aReport [
	| bytes |
	bytes := aReport gzippedSton.
	entries do: [ :each | each writeBytes: bytes extension: 'ston.gz' ]

]

{ #category : #actions }
GtReportsCompositeStoreEntry >> writeJsonOf: anObject [
	self writeJsonOf: anObject named: entries first reportType

]

{ #category : #actions }
GtReportsCompositeStoreEntry >> writeJsonOf: anObject named: aName [
	| json |
	json := LeJsonV4 uniqueInstance serializePretty: anObject.
	entries do: [ :each | each writeText: json named: aName extension: 'json' ]

]

{ #category : #actions }
GtReportsCompositeStoreEntry >> writeMetadataOf: aReport [
	entries do: [ :each | each writeMetadataOf: aReport ]

]

{ #category : #actions }
GtReportsCompositeStoreEntry >> writeText: aString extension: anExtension [
	entries do: [ :each | each writeText: aString extension: anExtension ]

]

{ #category : #actions }
GtReportsCompositeStoreEntry >> writeText: aString named: aName extension: anExtension [
	entries do: [ :each | each writeText: aString named: aName extension: anExtension ]

]

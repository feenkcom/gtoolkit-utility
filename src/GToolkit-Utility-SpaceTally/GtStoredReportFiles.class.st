"
I read one stored report folder back: its metadata, its JSON, text, gzipped STON or binary files, and the report itself (`report`), through the class named in the metadata. Report classes rebuild themselves with `fromStoredFiles:`.
"
Class {
	#name : #GtStoredReportFiles,
	#superclass : #Object,
	#instVars : [
		'folder',
		'metadata'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtStoredReportFiles class >> folder: aFolder [
	^ self new setFolder: aFolder

]

{ #category : #testing }
GtStoredReportFiles class >> isReportFolder: aFolder [
	^ (aFolder / GtReportMetadata fileName) exists

]

{ #category : #accessing }
GtStoredReportFiles >> fileNamed: aName extension: anExtension [
	^ folder / (aName , '.' , anExtension)

]

{ #category : #accessing }
GtStoredReportFiles >> filesWithExtension: anExtension [
	^ (folder childrenMatching: '*.' , anExtension) asArray
		sort: [ :a :b | a basename <= b basename ]

]

{ #category : #accessing }
GtStoredReportFiles >> folder [
	^ folder

]

{ #category : #'gt - extensions' }
GtStoredReportFiles >> gtFilesFor: aView [
	<gtView>
	^ aView list
		title: 'Files';
		priority: 10;
		items: [ folder children asArray sort: [ :a :b | a basename <= b basename ] ];
		itemText: [ :each | each basename ]

]

{ #category : #'gt - extensions' }
GtStoredReportFiles >> gtMetadataFor: aView [
	<gtView>
	^ aView forward
		title: 'Metadata';
		priority: 5;
		object: [ metadata ];
		view: #gtSummaryFor:

]

{ #category : #'gt - extensions' }
GtStoredReportFiles >> gtReadReportActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Read the report and inspect it';
		action: [ :aButton | aButton phlow spawnObject: self report ]

]

{ #category : #accessing }
GtStoredReportFiles >> metadata [
	^ metadata

]

{ #category : #printing }
GtStoredReportFiles >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			nextPutAll: metadata reportType;
			nextPutAll: ' ';
			nextPutAll: metadata storageId ]

]

{ #category : #reading }
GtStoredReportFiles >> readBytesNamed: aName extension: anExtension [
	^ (self fileNamed: aName extension: anExtension)
		binaryReadStreamDo: [ :aStream | aStream upToEnd ]

]

{ #category : #reading }
GtStoredReportFiles >> readGzippedSton [
	^ STON fromString: (GZipReadStream on:
		(self readBytesNamed: metadata reportType extension: 'ston.gz')) upToEnd utf8Decoded

]

{ #category : #reading }
GtStoredReportFiles >> readJson [
	^ self readJsonNamed: metadata reportType

]

{ #category : #reading }
GtStoredReportFiles >> readJsonNamed: aName [
	^ LeJsonV4 uniqueInstance deserialize:
		(self fileNamed: aName extension: 'json') contents readStream

]

{ #category : #reading }
GtStoredReportFiles >> readText: anExtension [
	^ self readTextNamed: metadata reportType extension: anExtension

]

{ #category : #reading }
GtStoredReportFiles >> readTextNamed: aName extension: anExtension [
	^ (self fileNamed: aName extension: anExtension) contents

]

{ #category : #reading }
GtStoredReportFiles >> report [
	^ self reportClass fromStoredFiles: self

]

{ #category : #accessing }
GtStoredReportFiles >> reportClass [
	^ Smalltalk globals at: metadata reportClassName asSymbol

]

{ #category : #initialization }
GtStoredReportFiles >> setFolder: aFolder [
	folder := aFolder.
	metadata := LeJsonV4 uniqueInstance deserialize:
		(aFolder / GtReportMetadata fileName) contents readStream

]

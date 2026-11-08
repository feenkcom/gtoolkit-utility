"
I am one stored report in one store: a folder, the report type, the storage id, the machine name, the files written so far (`GtReportsStoreFile`s) and the metadata. Reports write their files through me: `writeJsonOf:`, `writeText:extension:`, `writeGzippedStonOf:` or `writeBytes:extension:` name the file after the report type; the `named:` variants give a role name for reports with several files of the same kind (e.g. pictures). The store writes the metadata last; after that `metadata` answers the `GtReportMetadata` that was written.
"
Class {
	#name : #GtReportsStoreEntry,
	#superclass : #Object,
	#instVars : [
		'store',
		'folder',
		'reportType',
		'storageId',
		'machineName',
		'files',
		'metadata'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtReportsStoreEntry class >> store: aStore folder: aFolder reportType: aReportType storageId: aStorageId machineName: aMachineName [
	^ self new
		setStore: aStore
		folder: aFolder
		reportType: aReportType
		storageId: aStorageId
		machineName: aMachineName

]

{ #category : #accessing }
GtReportsStoreEntry >> files [
	^ files

]

{ #category : #accessing }
GtReportsStoreEntry >> folder [
	^ folder

]

{ #category : #'gt - extensions' }
GtReportsStoreEntry >> gtFilesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Files';
		priority: 5;
		items: [ files ];
		column: 'Name' text: [ :each | each basename ];
		column: 'Kind' text: [ :each | each kindDescription ] width: 100;
		column: 'Size' text: [ :each | each sizeDescription ] width: 90;
		column: 'Write duration' text: [ :each | each writeDuration gtHumanReadableString ] width: 110;
		send: [ :each | each ]

]

{ #category : #'gt - extensions' }
GtReportsStoreEntry >> gtFolderFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Folder';
		priority: 6;
		items: [ files collect: [ :each | each destination ] ];
		column: 'Name' text: [ :each | each basename ] width: 250;
		column: 'Location' text: [ :each | each parent fullName ];
		send: [ :each | each ]

]

{ #category : #'gt - extensions' }
GtReportsStoreEntry >> gtMetadataFor: aView [
	<gtView>
	^ aView forward
		title: 'Metadata';
		priority: 10;
		object: [ metadata ];
		view: #gtSummaryFor:

]

{ #category : #accessing }
GtReportsStoreEntry >> metadata [
	^ metadata

]

{ #category : #private }
GtReportsStoreEntry >> metadataFor: aReport [
	^ GtReportMetadata
		report: aReport
		storageId: storageId
		machineName: machineName
		files: (files collect: [ :each | each fileDescription ])

]

{ #category : #printing }
GtReportsStoreEntry >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			nextPutAll: self storeDescription;
			nextPutAll: ', ';
			nextPutAll: reportType;
			nextPutAll: ' ';
			nextPutAll: storageId ]

]

{ #category : #private }
GtReportsStoreEntry >> record: aStoreFile writing: aBlock [
	aStoreFile writeWith: aBlock.
	files add: aStoreFile.
	^ aStoreFile

]

{ #category : #accessing }
GtReportsStoreEntry >> reportType [
	^ reportType

]

{ #category : #initialization }
GtReportsStoreEntry >> setStore: aStore folder: aFolder reportType: aReportType storageId: aStorageId machineName: aMachineName [
	store := aStore.
	folder := aFolder.
	reportType := aReportType.
	storageId := aStorageId.
	machineName := aMachineName.
	files := OrderedCollection new.
	metadata := GtReportMetadata new

]

{ #category : #accessing }
GtReportsStoreEntry >> stateDescription [
	^ 'Saved'

]

{ #category : #accessing }
GtReportsStoreEntry >> storageId [
	^ storageId

]

{ #category : #printing }
GtReportsStoreEntry >> storeDescription [
	^ store description

]

{ #category : #private }
GtReportsStoreEntry >> write: aString named: aName extension: anExtension [
	^ self
		record: (GtReportsStoreDataFile destination: folder / (aName , '.' , anExtension))
		writing: [ :aDestination | store write: aString to: aDestination ]

]

{ #category : #actions }
GtReportsStoreEntry >> writeBytes: aByteArray extension: anExtension [
	^ self writeBytes: aByteArray named: reportType extension: anExtension

]

{ #category : #actions }
GtReportsStoreEntry >> writeBytes: aByteArray named: aName extension: anExtension [
	^ self
		record: (GtReportsStoreDataFile destination: folder / (aName , '.' , anExtension))
		writing: [ :aDestination | store writeBytes: aByteArray to: aDestination ]

]

{ #category : #actions }
GtReportsStoreEntry >> writeGzippedStonOf: aReport [
	^ self writeBytes: aReport gzippedSton extension: 'ston.gz'

]

{ #category : #actions }
GtReportsStoreEntry >> writeJsonOf: anObject [
	^ self writeJsonOf: anObject named: reportType

]

{ #category : #actions }
GtReportsStoreEntry >> writeJsonOf: anObject named: aName [
	^ self
		write: (LeJsonV4 uniqueInstance serializePretty: anObject)
		named: aName
		extension: 'json'

]

{ #category : #actions }
GtReportsStoreEntry >> writeMetadataOf: aReport [
	| json |
	metadata := self metadataFor: aReport.
	json := LeJsonV4 uniqueInstance serializePretty: metadata.
	^ self
		record: (GtReportsStoreMetadataFile
			metadata: metadata
			destination: folder / GtReportMetadata fileName)
		writing: [ :aDestination | store write: json to: aDestination ]

]

{ #category : #actions }
GtReportsStoreEntry >> writeText: aString extension: anExtension [
	^ self writeText: aString named: reportType extension: anExtension

]

{ #category : #actions }
GtReportsStoreEntry >> writeText: aString named: aName extension: anExtension [
	^ self write: aString named: aName extension: anExtension

]

"
I am the metadata of one stored report, written as `meta.json` in its folder after all the other files, so a folder without me is incomplete.

I hold three names of the report, each with one role:
- the report type: the kind of data, used for the folders and for grouping (e.g. `message-tally`);
- the report class name: how to read the report back now;
- the report alias: a stable name of the report class (its `leJsonV4Name`), to read the report back after the class is renamed.

I hold two ids:
- the report uid: a `UUID` given to the report when it is created and stored with it; it stays the same however often the report is stored, so copies of the same report share it. Metadata written without one has `UUID nilUUID` (`hasReportUid` is false);
- the storage id: one per stored copy, the UTC time plus a short random part; it names the folder.

I also hold the time it was stored (UTC), the machine name when one is known, the image data, the data files with their sizes (`GtReportFileDescription`s) and my format version (`currentFormatVersion`). The format version is written into every `meta.json` so that a later reader can recognise older or newer formats; today it is only shown (`isNewerFormat`).
"
Class {
	#name : #GtReportMetadata,
	#superclass : #Object,
	#instVars : [
		'formatVersion',
		'reportType',
		'reportClassName',
		'reportAlias',
		'reportUid',
		'storageId',
		'storedAt',
		'machineName',
		'imageData',
		'files'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtReportMetadata class >> currentFormatVersion [
	^ 1

]

{ #category : #accessing }
GtReportMetadata class >> fileName [
	^ 'meta.json'

]

{ #category : #serialization }
GtReportMetadata class >> leJsonV4Name [
	^ #gtReportMetadata

]

{ #category : #'instance creation' }
GtReportMetadata class >> report: aReport storageId: aStorageId machineName: aMachineName files: aCollectionOfFileNames [
	^ self new
		setReport: aReport
		storageId: aStorageId
		machineName: aMachineName
		files: aCollectionOfFileNames

]

{ #category : #accessing }
GtReportMetadata >> files [
	^ files

]

{ #category : #accessing }
GtReportMetadata >> files: aCollectionOfFileNames [
	files := aCollectionOfFileNames

]

{ #category : #accessing }
GtReportMetadata >> formatVersion [
	^ formatVersion

]

{ #category : #accessing }
GtReportMetadata >> formatVersion: anInteger [
	formatVersion := anInteger

]

{ #category : #'gt - extensions' }
GtReportMetadata >> gtImageDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Image data';
		priority: 10;
		object: [ imageData ];
		view: #gtSummaryFor:

]

{ #category : #'gt - extensions' }
GtReportMetadata >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ self summaryAttributes ];
		column: 'Attribute' text: [ :each | each key ] width: 150;
		column: 'Value' text: [ :each | each value ifNil: [ '-' ] ];
		send: [ :each | each value ]

]

{ #category : #testing }
GtReportMetadata >> hasReportUid [
	^ reportUid isNilUUID not

]

{ #category : #accessing }
GtReportMetadata >> imageData [
	^ imageData

]

{ #category : #accessing }
GtReportMetadata >> imageData: aReportImageData [
	imageData := aReportImageData

]

{ #category : #initialization }
GtReportMetadata >> initialize [
	super initialize.
	formatVersion := self class currentFormatVersion.
	reportType := ''.
	reportClassName := ''.
	reportAlias := ''.
	reportUid := UUID nilUUID.
	storageId := ''.
	machineName := ''.
	imageData := GtReportImageData new.
	files := #()

]

{ #category : #testing }
GtReportMetadata >> isNewerFormat [
	^ formatVersion > self class currentFormatVersion

]

{ #category : #accessing }
GtReportMetadata >> machineName [
	^ machineName

]

{ #category : #accessing }
GtReportMetadata >> machineName: aString [
	machineName := aString

]

{ #category : #printing }
GtReportMetadata >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			nextPutAll: reportType;
			nextPutAll: ' ';
			nextPutAll: storageId.
		machineName ifNotEmpty: [
			aStream
				nextPutAll: ', ';
				nextPutAll: machineName ] ]

]

{ #category : #accessing }
GtReportMetadata >> reportAlias [
	^ reportAlias

]

{ #category : #accessing }
GtReportMetadata >> reportAlias: aString [
	reportAlias := aString

]

{ #category : #accessing }
GtReportMetadata >> reportClassName [
	^ reportClassName

]

{ #category : #accessing }
GtReportMetadata >> reportClassName: aString [
	reportClassName := aString

]

{ #category : #accessing }
GtReportMetadata >> reportType [
	^ reportType

]

{ #category : #accessing }
GtReportMetadata >> reportType: aString [
	reportType := aString

]

{ #category : #accessing }
GtReportMetadata >> reportUid [
	^ reportUid

]

{ #category : #accessing }
GtReportMetadata >> reportUid: aUUID [
	reportUid := aUUID

]

{ #category : #initialization }
GtReportMetadata >> setReport: aReport storageId: aStorageId machineName: aMachineName files: aCollectionOfFileNames [
	reportType := aReport reportType.
	reportClassName := aReport class name asString.
	reportAlias := aReport class leJsonV4Name asString.
	reportUid := aReport reportUid.
	storageId := aStorageId.
	machineName := aMachineName.
	imageData := aReport imageData.
	files := aCollectionOfFileNames asArray.
	storedAt := DateAndTime now asUTC

]

{ #category : #accessing }
GtReportMetadata >> storageId [
	^ storageId

]

{ #category : #accessing }
GtReportMetadata >> storageId: aString [
	storageId := aString

]

{ #category : #accessing }
GtReportMetadata >> storedAt [
	^ storedAt

]

{ #category : #accessing }
GtReportMetadata >> storedAt: aDateAndTime [
	storedAt := aDateAndTime

]

{ #category : #accessing }
GtReportMetadata >> summaryAttributes [
	^ OrderedCollection new
		add: 'Report type' -> reportType;
		add: 'Report uid' -> reportUid;
		add: 'Storage id' -> storageId;
		add: 'Stored at' -> (storedAt ifNotNil: [ :aDateAndTime | aDateAndTime asLocal ]);
		add: 'Machine' -> machineName;
		add: 'Report class' -> reportClassName;
		add: 'Report alias' -> reportAlias;
		add: 'Format version' -> formatVersion;
		add: 'Files' -> files;
		yourself

]

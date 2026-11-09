"
I show how reports are stored: the folder layout, the file names, the metadata, several files of the same kind, composite stores and the store that keeps nothing.
"
Class {
	#name : #GtReportsStoreExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #examples }
GtReportsStoreExamples >> compositeEntryKnowsTheStoreOfEachFile [
	<gtExample>
	| first second entry filesWithEntries |
	first := self memoryLocalStore.
	second := self memoryLocalStore.
	entry := GtProcessesReport new storeIn: (GtReportsCompositeStore withAll: (Array with: first with: second)).
	filesWithEntries := entry filesWithEntries.
	self assert: filesWithEntries size equals: 4.
	self
		assert: (filesWithEntries collect: [ :each | each value destination ]) asSet size
		equals: 4.
	self assert: entry metadata storageId equals: entry storageId.
	^ entry

]

{ #category : #examples }
GtReportsStoreExamples >> compositeStoreUsesTheSameIdInEveryStore [
	<gtExample>
	| first second entry |
	first := self memoryLocalStore.
	second := self memoryLocalStore.
	entry := GtProcessesReport new storeIn: (GtReportsCompositeStore withAll: (Array with: first with: second)).
	self assert: entry files size equals: 4.
	(Array with: first with: second) do: [ :each |
		self assert: (each rootFolder / 'processes' / (each dateOf: entry storageId) / entry storageId
			/ GtReportMetadata fileName) exists ].
	^ entry

]

{ #category : #examples }
GtReportsStoreExamples >> entryKeepsTheMetadataItWrote [
	<gtExample>
	| entry metadataFile |
	entry := self processesReportStoredLocally.
	metadataFile := entry files last.
	self assert: metadataFile class equals: GtReportsStoreMetadataFile.
	self assert: metadataFile metadata == entry metadata.
	self assert: entry metadata storageId equals: entry storageId.
	self
		assert: (entry metadata files collect: [ :each | each name ]) asArray
		equals: #('processes.json').
	^ entry metadata

]

{ #category : #examples }
GtReportsStoreExamples >> memoryLocalStore [
	<gtExample>
	^ GtReportsLocalStore rootFolder: FileSystem memory root / 'gt-reports'

]

{ #category : #examples }
GtReportsStoreExamples >> messageTallyReportStoredWithItsTextAndItsJson [
	<gtExample>
	| entry |
	entry := GtMessageTallyReport new storeIn: self memoryLocalStore.
	self
		assert: (entry files collect: [ :each | each basename ]) asArray
		equals: #('message-tally.txt' 'message-tally.json' 'meta.json').
	^ entry

]

{ #category : #examples }
GtReportsStoreExamples >> metadataOfAStoredReport [
	<gtExample>
	| entry metadata |
	entry := self processesReportStoredLocally.
	metadata := LeJsonV4 uniqueInstance deserialize:
		(entry folder / GtReportMetadata fileName) contents readStream.
	self assert: metadata reportType equals: 'processes'.
	self assert: metadata reportClassName equals: 'GtProcessesReport'.
	self assert: metadata reportAlias equals: 'gtProcessesReport'.
	self assert: metadata storageId equals: entry storageId.
	self assert: metadata reportUid class equals: UUID.
	self assert: metadata hasReportUid.
	self assert: metadata machineName equals: ''.
	self assert: (metadata files collect: [ :each | each name ]) asArray equals: #('processes.json').
	self assert: metadata files first numberOfBytes equals: (entry folder / 'processes.json') size.
	self assert: metadata formatVersion equals: GtReportMetadata currentFormatVersion.
	self assert: metadata isNewerFormat not.
	^ metadata

]

{ #category : #examples }
GtReportsStoreExamples >> noStoreKeepsNothing [
	<gtExample>
	| entry |
	entry := GtProcessesReport new storeIn: GtNoReportsStore new.
	self assert: entry files isEmpty.
	^ entry

]

{ #category : #examples }
GtReportsStoreExamples >> processesReportStoredLocally [
	<gtExample>
	| store entry |
	store := self memoryLocalStore.
	entry := GtProcessesReport recordNewReport storeIn: store.
	self assert: entry folder basename equals: entry storageId.
	self assert: entry folder parent basename equals: (store dateOf: entry storageId).
	self assert: entry folder parent parent equals: store rootFolder / 'processes'.
	self
		assert: (entry files collect: [ :each | each basename ]) asArray
		equals: #('processes.json' 'meta.json').
	^ entry

]

{ #category : #examples }
GtReportsStoreExamples >> reportStoredTwiceKeepsItsUid [
	<gtExample>
	| store report entries metadatas |
	store := self memoryLocalStore.
	report := GtProcessesReport new.
	entries := Array
		with: (report storeIn: store)
		with: (report storeIn: store).
	self assert: (entries first storageId = entries second storageId) not.
	metadatas := entries collect: [ :each |
		LeJsonV4 uniqueInstance deserialize:
			(each folder / GtReportMetadata fileName) contents readStream ].
	metadatas do: [ :each |
		self assert: each reportUid equals: report reportUid ].
	^ metadatas

]

{ #category : #examples }
GtReportsStoreExamples >> severalFilesOfTheSameKind [
	<gtExample>
	| store report entry |
	store := self memoryLocalStore.
	report := GtProcessesReport new.
	entry := store entryFor: report storageId: store newStorageId.
	entry
		writeBytes: #[1 2 3] named: 'picture-1' extension: 'png';
		writeBytes: #[4 5] named: 'picture-2' extension: 'png';
		writeMetadataOf: report.
	self
		assert: (entry files collect: [ :each | each basename ]) asArray
		equals: #('picture-1.png' 'picture-2.png' 'meta.json').
	^ entry

]

{ #category : #examples }
GtReportsStoreExamples >> storageIdHasTheUtcTimeAndADateFolder [
	<gtExample>
	| store storageId |
	store := self memoryLocalStore.
	storageId := store newStorageId.
	self assert: storageId size equals: 25.
	self assert: (storageId at: 9) equals: $T.
	self assert: (storageId at: 16) equals: $Z.
	self assert: (storageId at: 17) equals: $-.
	self
		assert: (store dateOf: storageId)
		equals: (storageId copyFrom: 1 to: 4) , '-' , (storageId copyFrom: 5 to: 6) , '-' , (storageId copyFrom: 7 to: 8).
	^ storageId

]

{ #category : #examples }
GtReportsStoreExamples >> storedFilesKnowTheirFileSizeAndWriteTime [
	<gtExample>
	| entry |
	entry := self messageTallyReportStoredWithItsTextAndItsJson.
	entry files do: [ :each |
		self assert: each destination exists.
		self assert: each numberOfBytes equals: each destination size.
		self assert: each writeDuration class equals: Duration ].
	self
		assert: (entry files collect: [ :each | each kindDescription ]) asArray
		equals: #('report data' 'report data' 'metadata').
	^ entry files

]

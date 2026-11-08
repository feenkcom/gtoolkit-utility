"
I am the abstract store of reports. `store: aReport` (what `aReport storeIn: aStore` does) creates an entry for the report in a folder `<type>/<yyyy-mm-dd>/<storage id>/`, lets the report write its files into the entry and then writes the metadata.

The storage id is the UTC time plus a short random part; the date folder is its UTC day. Storing the same report again gives a new storage id, while the report keeps its uid. Subclasses decide where the root folder is and how files are written: `write:to:` and `writeBytes:to:` answer the number of bytes they wrote, read from the written file, which goes into the metadata.
"
Class {
	#name : #GtReportsStore,
	#superclass : #Object,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtReportsStore >> dateOf: aStorageId [
	^ (aStorageId copyFrom: 1 to: 4) , '-' , (aStorageId copyFrom: 5 to: 6) , '-' , (aStorageId copyFrom: 7 to: 8)

]

{ #category : #printing }
GtReportsStore >> description [
	^ self subclassResponsibility

]

{ #category : #accessing }
GtReportsStore >> entryFor: aReport storageId: aStorageId [
	| aMachineName |
	aMachineName := self machineNameFor: aReport.
	^ GtReportsStoreEntry
		store: self
		folder: (self folderFor: aReport reportType storageId: aStorageId machineName: aMachineName)
		reportType: aReport reportType
		storageId: aStorageId
		machineName: aMachineName

]

{ #category : #accessing }
GtReportsStore >> folderFor: aReportType storageId: aStorageId machineName: aMachineName [
	^ (self folderForType: aReportType) / (self dateOf: aStorageId) / aStorageId

]

{ #category : #accessing }
GtReportsStore >> folderForType: aReportType [
	^ self rootFolder / aReportType

]

{ #category : #'gt - extensions' }
GtReportsStore >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ OrderedCollection with: 'Root' -> self rootFolder ];
		column: 'Attribute' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]

]

{ #category : #accessing }
GtReportsStore >> machineName [
	^ ''

]

{ #category : #accessing }
GtReportsStore >> machineNameFor: aReport [
	^ (aReport imageData machineName ifEmpty: [ self machineName ]) asLowercase

]

{ #category : #accessing }
GtReportsStore >> newStorageId [
	^ self utcTimestampString , '-' , (UUID new asString first: 8)

]

{ #category : #accessing }
GtReportsStore >> rootFolder [
	^ self subclassResponsibility

]

{ #category : #actions }
GtReportsStore >> store: aReport [
	| entry |
	entry := self entryFor: aReport storageId: self newStorageId.
	aReport writeFilesTo: entry.
	entry writeMetadataOf: aReport.
	^ entry

]

{ #category : #private }
GtReportsStore >> utcTimestampString [
	| now |
	now := DateAndTime now asUTC.
	^ String streamContents: [ :aStream |
		aStream
			print: now year;
			nextPutAll: (now month printPaddedWith: $0 to: 2);
			nextPutAll: (now dayOfMonth printPaddedWith: $0 to: 2);
			nextPut: $T;
			nextPutAll: (now hour printPaddedWith: $0 to: 2);
			nextPutAll: (now minute printPaddedWith: $0 to: 2);
			nextPutAll: (now second printPaddedWith: $0 to: 2);
			nextPut: $Z ]

]

{ #category : #actions }
GtReportsStore >> write: aString to: aDestination [
	^ self subclassResponsibility

]

{ #category : #actions }
GtReportsStore >> writeBytes: aByteArray to: aDestination [
	^ self subclassResponsibility

]

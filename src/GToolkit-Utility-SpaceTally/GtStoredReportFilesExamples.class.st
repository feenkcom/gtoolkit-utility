"
I show how stored reports are read back into report objects.
"
Class {
	#name : #GtStoredReportFilesExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #examples }
GtStoredReportFilesExamples >> garbageCollectsReportReadBack [
	<gtExample>
	| report |
	report := (self storedFilesOf: (GtGarbageCollectsReport new storeIn: GtReportsStoreExamples new memoryLocalStore)) report.
	self assert: report class equals: GtGarbageCollectsReport.
	^ report

]

{ #category : #examples }
GtStoredReportFilesExamples >> messageTallyReportReadBackWithItsText [
	<gtExample>
	| original report |
	original := GtMessageTallyReport new
		textualContent: 'a tally';
		duration: 30 seconds;
		yourself.
	report := (self storedFilesOf: (original storeIn: GtReportsStoreExamples new memoryLocalStore)) report.
	self assert: report class equals: GtMessageTallyReport.
	self assert: report textualContent equals: 'a tally'.
	self assert: report duration equals: 30 seconds.
	self assert: report messageTally isNil.
	^ report

]

{ #category : #examples }
GtStoredReportFilesExamples >> metadataReadBack [
	<gtExample>
	| entry files |
	entry := GtReportsStoreExamples new processesReportStoredLocally.
	files := self storedFilesOf: entry.
	self assert: files metadata storageId equals: entry storageId.
	self assert: files reportClass equals: GtProcessesReport.
	self assert: files metadata isNewerFormat not.
	^ files

]

{ #category : #examples }
GtStoredReportFilesExamples >> metadataWithoutReportUidHasTheNilUUID [
	<gtExample>
	| metadata |
	metadata := LeJsonV4 uniqueInstance deserialize:
		'{"__schema":"4.1","__type":"gtReportMetadata","reportType":"processes"}' readStream.
	self assert: metadata reportUid equals: UUID nilUUID.
	self assert: metadata hasReportUid not.
	^ metadata

]

{ #category : #examples }
GtStoredReportFilesExamples >> processesReportReadBack [
	<gtExample>
	| original files report |
	original := GtProcessesReport recordNewReport.
	files := self storedFilesOf: (original storeIn: GtReportsStoreExamples new memoryLocalStore).
	report := files report.
	self assert: report class equals: GtProcessesReport.
	self assert: report processReports size equals: original processReports size.
	self assert: report imageData gtVersion equals: original imageData gtVersion.
	^ report

]

{ #category : #examples }
GtStoredReportFilesExamples >> readBackReportKeepsItsUid [
	<gtExample>
	| report files |
	report := GtProcessesReport new.
	files := self storedFilesOf: (report storeIn: GtReportsStoreExamples new memoryLocalStore).
	self assert: files metadata reportUid equals: report reportUid.
	self assert: files report reportUid equals: report reportUid.
	^ files

]

{ #category : #examples }
GtStoredReportFilesExamples >> severalFilesOfTheSameKindReadBack [
	<gtExample>
	| files |
	files := self storedFilesOf: GtReportsStoreExamples new severalFilesOfTheSameKind.
	self
		assert: ((files filesWithExtension: 'png') collect: [ :each | each basename ])
		equals: #('picture-1.png' 'picture-2.png').
	self assert: (files readBytesNamed: 'picture-1' extension: 'png') equals: #[1 2 3].
	^ files

]

{ #category : #examples }
GtStoredReportFilesExamples >> spaceTallyReportReadBack [
	<gtExample>
	| files report |
	files := self storedFilesOf: (GtSpaceTallyReport new storeIn: GtReportsStoreExamples new memoryLocalStore).
	self assert: (files filesWithExtension: 'gz') size equals: 1.
	report := files report.
	self assert: report class equals: GtSpaceTallyReport.
	^ report

]

{ #category : #examples }
GtStoredReportFilesExamples >> storedFilesOf: anEntry [
	^ GtStoredReportFiles folder: anEntry folder

]

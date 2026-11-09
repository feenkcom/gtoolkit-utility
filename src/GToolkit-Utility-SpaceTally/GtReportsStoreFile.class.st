"
I am one file written for a stored report: where it was written (a local file or an S3 file), how many bytes were written (as answered by the store, read from the written file), when, and how long the write took. I do not keep the written contents, which can be large; open my destination to see them. Entries create me while they write (`GtReportsStoreEntry>>#record:writing:`).
"
Class {
	#name : #GtReportsStoreFile,
	#superclass : #Object,
	#instVars : [
		'destination',
		'numberOfBytes',
		'writtenAt',
		'writeDuration'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtReportsStoreFile class >> destination: aFile [
	^ self new setDestination: aFile

]

{ #category : #accessing }
GtReportsStoreFile >> basename [
	^ destination basename

]

{ #category : #accessing }
GtReportsStoreFile >> destination [
	^ destination

]

{ #category : #accessing }
GtReportsStoreFile >> fileDescription [
	^ GtReportFileDescription name: self basename numberOfBytes: numberOfBytes

]

{ #category : #accessing }
GtReportsStoreFile >> fullName [
	^ destination fullName

]

{ #category : #'gt - extensions' }
GtReportsStoreFile >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ self summaryAttributes ];
		column: 'Attribute' text: [ :each | each key ] width: 130;
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]

]

{ #category : #initialization }
GtReportsStoreFile >> initialize [
	super initialize.
	numberOfBytes := 0.
	writtenAt := DateAndTime now.
	writeDuration := Duration zero

]

{ #category : #accessing }
GtReportsStoreFile >> kindDescription [
	^ self subclassResponsibility

]

{ #category : #accessing }
GtReportsStoreFile >> numberOfBytes [
	^ numberOfBytes

]

{ #category : #printing }
GtReportsStoreFile >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			nextPutAll: self basename;
			nextPutAll: ', ';
			nextPutAll: self sizeDescription ]

]

{ #category : #initialization }
GtReportsStoreFile >> setDestination: aFile [
	destination := aFile

]

{ #category : #accessing }
GtReportsStoreFile >> sizeDescription [
	^ numberOfBytes humanReadableIsqByteSize
]

{ #category : #accessing }
GtReportsStoreFile >> summaryAttributes [
	^ OrderedCollection new
		add: 'File' -> destination;
		add: 'Kind' -> self kindDescription;
		add: 'Size' -> self sizeDescription;
		add: 'Written at' -> writtenAt;
		add: 'Write duration' -> writeDuration;
		yourself

]

{ #category : #accessing }
GtReportsStoreFile >> writeDuration [
	^ writeDuration

]

{ #category : #actions }
GtReportsStoreFile >> writeWith: aBlock [
	writtenAt := DateAndTime now.
	writeDuration := [ numberOfBytes := aBlock value: destination ] timeToRun

]

{ #category : #accessing }
GtReportsStoreFile >> writtenAt [
	^ writtenAt

]

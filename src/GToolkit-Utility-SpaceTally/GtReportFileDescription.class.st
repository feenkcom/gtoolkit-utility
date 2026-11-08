"
I describe one data file of a stored report in its metadata: the file name and the number of bytes that were written, read from the written file. Metadata lists me for every file except `meta.json` itself, so the size of a report is known from its metadata alone, e.g. after a metadata-only download.
"
Class {
	#name : #GtReportFileDescription,
	#superclass : #Object,
	#instVars : [
		'name',
		'numberOfBytes'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtReportFileDescription class >> leJsonV4Name [
	^ #gtReportFileDescription

]

{ #category : #'instance creation' }
GtReportFileDescription class >> name: aString numberOfBytes: anInteger [
	^ self new setName: aString numberOfBytes: anInteger

]

{ #category : #initialization }
GtReportFileDescription >> initialize [
	super initialize.
	name := ''.
	numberOfBytes := 0

]

{ #category : #accessing }
GtReportFileDescription >> name [
	^ name

]

{ #category : #accessing }
GtReportFileDescription >> name: aString [
	name := aString

]

{ #category : #accessing }
GtReportFileDescription >> numberOfBytes [
	^ numberOfBytes

]

{ #category : #accessing }
GtReportFileDescription >> numberOfBytes: anInteger [
	numberOfBytes := anInteger

]

{ #category : #printing }
GtReportFileDescription >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			nextPutAll: name;
			nextPutAll: ', ';
			nextPutAll: self sizeDescription ]

]

{ #category : #initialization }
GtReportFileDescription >> setName: aString numberOfBytes: anInteger [
	name := aString.
	numberOfBytes := anInteger

]

{ #category : #accessing }
GtReportFileDescription >> sizeDescription [
	^ numberOfBytes humanReadableIsqByteSize

]

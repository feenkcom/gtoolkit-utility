"
I am the `meta.json` of a stored report. I keep the `GtReportMetadata` that was written, so it can be inspected without reading the file back.
"
Class {
	#name : #GtReportsStoreMetadataFile,
	#superclass : #GtReportsStoreFile,
	#instVars : [
		'metadata'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtReportsStoreMetadataFile class >> metadata: aReportMetadata destination: aFile [
	^ (self destination: aFile)
		setMetadata: aReportMetadata;
		yourself

]

{ #category : #'gt - extensions' }
GtReportsStoreMetadataFile >> gtMetadataFor: aView [
	<gtView>
	^ aView forward
		title: 'Metadata';
		priority: 1;
		object: [ metadata ];
		view: #gtSummaryFor:

]

{ #category : #accessing }
GtReportsStoreMetadataFile >> kindDescription [
	^ 'metadata'

]

{ #category : #accessing }
GtReportsStoreMetadataFile >> metadata [
	^ metadata

]

{ #category : #initialization }
GtReportsStoreMetadataFile >> setMetadata: aReportMetadata [
	metadata := aReportMetadata

]

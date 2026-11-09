"
I am the entry of the store that keeps nothing: every write does nothing and I have no files.
"
Class {
	#name : #GtReportsNoStoreEntry,
	#superclass : #Object,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtReportsNoStoreEntry >> files [
	^ #()

]

{ #category : #'gt - extensions' }
GtReportsNoStoreEntry >> gtFilesFor: aView [
	<gtView>
	^ aView empty

]

{ #category : #'gt - extensions' }
GtReportsNoStoreEntry >> gtFolderFor: aView [
	<gtView>
	^ aView empty

]

{ #category : #accessing }
GtReportsNoStoreEntry >> metadata [
	^ GtReportMetadata new

]

{ #category : #printing }
GtReportsNoStoreEntry >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [ aStream nextPutAll: self storeDescription ]

]

{ #category : #accessing }
GtReportsNoStoreEntry >> stateDescription [
	^ 'Recorded'

]

{ #category : #printing }
GtReportsNoStoreEntry >> storeDescription [
	^ 'no store'

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeBytes: aByteArray extension: anExtension [

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeBytes: aByteArray named: aName extension: anExtension [

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeGzippedStonOf: aReport [

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeJsonOf: aReport [

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeJsonOf: anObject named: aName [

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeMetadataOf: aReport [

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeText: aString extension: anExtension [

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeText: aString named: aName extension: anExtension [

]

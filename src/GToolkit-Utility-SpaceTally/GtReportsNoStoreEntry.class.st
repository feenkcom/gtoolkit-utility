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
GtReportsNoStoreEntry >> writeJsonOf: aReport [

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeText: aString extension: anExtension [

]

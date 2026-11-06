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

{ #category : #accessing }
GtReportsNoStoreEntry >> stateDescription [
	^ 'Recorded'

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeJsonOf: aReport [

]

{ #category : #actions }
GtReportsNoStoreEntry >> writeText: aString extension: anExtension [

]

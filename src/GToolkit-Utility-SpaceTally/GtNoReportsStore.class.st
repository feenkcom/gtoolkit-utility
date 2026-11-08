"
I am the store that keeps nothing: storing a report into me answers an entry that writes no files. Use me to record a report only to inspect it.
"
Class {
	#name : #GtNoReportsStore,
	#superclass : #GtReportsStore,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #printing }
GtNoReportsStore >> description [
	^ 'no store'

]

{ #category : #accessing }
GtNoReportsStore >> entryFor: aReport storageId: aStorageId [
	^ GtReportsNoStoreEntry new

]

{ #category : #'gt - extensions' }
GtNoReportsStore >> gtSummaryFor: aView [
	<gtView>
	^ aView empty

]

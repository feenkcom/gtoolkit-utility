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
GtNoReportsStore >> entryFolderName: aFolderName filePrefix: aPrefix [
	^ GtReportsNoStoreEntry new

]

{ #category : #'gt - extensions' }
GtNoReportsStore >> gtSummaryFor: aView [
	<gtView>
	^ aView empty

]

Class {
	#name : #GtReportsStore,
	#superclass : #Object,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #private }
GtReportsStore >> baseNameWithPrefix: aPrefix [
	^ aPrefix , DateAndTime now asFileNameCompatibleString , '-' , (UUID new asString first: 8)

]

{ #category : #printing }
GtReportsStore >> description [
	^ self subclassResponsibility

]

{ #category : #accessing }
GtReportsStore >> entryFolderName: aFolderName baseName: aBaseName [
	^ GtReportsStoreEntry
		store: self
		folder: (self folderNamed: aFolderName)
		baseName: aBaseName

]

{ #category : #accessing }
GtReportsStore >> entryFolderName: aFolderName filePrefix: aPrefix [
	^ self
		entryFolderName: aFolderName
		baseName: (self baseNameWithPrefix: aPrefix)

]

{ #category : #accessing }
GtReportsStore >> folderNamed: aFolderName [
	^ self rootFolder / aFolderName / Date current yyyymmdd

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
GtReportsStore >> rootFolder [
	^ self subclassResponsibility

]

{ #category : #actions }
GtReportsStore >> write: aString to: aDestination [
	^ self subclassResponsibility

]

{ #category : #actions }
GtReportsStore >> writeBytes: aByteArray to: aDestination [
	^ self subclassResponsibility

]

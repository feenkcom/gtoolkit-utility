Class {
	#name : #GtReportsLocalStore,
	#superclass : #GtReportsStore,
	#instVars : [
		'rootFolder'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtReportsLocalStore class >> default [
	^ self rootFolder: FileLocator imageDirectory / 'gt-reports'

]

{ #category : #'instance creation' }
GtReportsLocalStore class >> rootFolder: aFileReference [
	^ self new setRootFolder: aFileReference

]

{ #category : #printing }
GtReportsLocalStore >> description [
	^ 'local store'

]

{ #category : #'gt - extensions' }
GtReportsLocalStore >> gtOpenRootFolderActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect the root folder';
		action: [ :aButton | aButton phlow spawnObject: rootFolder ]

]

{ #category : #'gt - extensions' }
GtReportsLocalStore >> gtRootFolderFor: aView [
	<gtView>
	^ aView forward
		title: 'Reports folder';
		priority: 20;
		object: [ rootFolder ];
		view: #gtTreeFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect the reports folder'
			action: [ :aButton | aButton phlow spawnObject: rootFolder ];
		actionButtonIcon: BrGlamorousVectorIcons folder
			tooltip: 'Open the reports folder in the OS file browser'
			action: [ :aButton |
				rootFolder ensureCreateDirectory.
				rootFolder openInOSFileBrowser ]

]

{ #category : #accessing }
GtReportsLocalStore >> rootFolder [
	^ rootFolder

]

{ #category : #initialization }
GtReportsLocalStore >> setRootFolder: aFileReference [
	rootFolder := aFileReference

]

{ #category : #actions }
GtReportsLocalStore >> write: aString to: aFileReference [
	aFileReference parent ensureCreateDirectory.
	aFileReference writeStreamDo: [ :aStream | aStream nextPutAll: aString ]

]

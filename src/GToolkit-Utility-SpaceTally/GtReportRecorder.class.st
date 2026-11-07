Class {
	#name : #GtReportRecorder,
	#superclass : #Object,
	#instVars : [
		'imageData'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtReportRecorder class >> current [
	^ self imageData: self currentImageData

]

{ #category : #'instance creation' }
GtReportRecorder class >> currentImageData [
	^ GtReportImageData current

]

{ #category : #'instance creation' }
GtReportRecorder class >> imageData: anImageData [
	^ self new setImageData: anImageData

]

{ #category : #actions }
GtReportRecorder >> completeReport: aReport [
	^ aReport

]

{ #category : #actions }
GtReportRecorder >> createReport [
	^ self completeReport: self recordReport

]

{ #category : #printing }
GtReportRecorder >> description [
	^ self recordingName

]

{ #category : #'gt - extensions' }
GtReportRecorder >> gtActionInspectRecordingFor: anAction [
	<gtAction>
	^ anAction button
		priority: 80;
		target: GtPhlowObjectContextMenuTarget;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect a new recording into the local store, not started';
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: [ 'Recording of ' , self recordingName ];
		action: [ :aButton |
			aButton phlow spawnObject: self recordingLocally ]

]

{ #category : #'gt - extensions' }
GtReportRecorder >> gtDestinationFor: aView [
	<gtView>
	^ aView forward
		title: 'Destination';
		priority: 20;
		object: [ self newReport ];
		view: #gtStorageFor:

]

{ #category : #'gt - extensions' }
GtReportRecorder >> gtImageDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Image data';
		priority: 30;
		object: [ imageData ];
		view: #gtSummaryFor:

]

{ #category : #'gt - extensions' }
GtReportRecorder >> gtRecordAndSaveLocallyActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons savetodisk;
		label: 'Record';
		tooltip: 'Record in the background and save locally';
		priority: 10;
		action: [ :aButton |
			aButton phlow
				spawnObject: self recordLocallyInBackground ]

]

{ #category : #'gt - extensions' }
GtReportRecorder >> gtSettingsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Settings';
		priority: 10;
		items: [ self settingsAttributes ];
		column: 'Attribute' text: [ :each | each key ] width: 150;
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]

]

{ #category : #accessing }
GtReportRecorder >> newReport [
	^ self subclassResponsibility

]

{ #category : #printing }
GtReportRecorder >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [ aStream nextPutAll: self description ]

]

{ #category : #actions }
GtReportRecorder >> recordInBackgroundInto: aStore [
	^ (self recordingInto: aStore) start

]

{ #category : #actions }
GtReportRecorder >> recordInBackgroundWithoutStoring [
	^ self recordingWithoutStoring start

]

{ #category : #actions }
GtReportRecorder >> recordLocallyInBackground [
	^ self recordingLocally start

]

{ #category : #actions }
GtReportRecorder >> recordReport [
	^ self subclassResponsibility

]

{ #category : #actions }
GtReportRecorder >> recordingInto: aStore [
	^ GtReportRecording recorder: self store: aStore

]

{ #category : #actions }
GtReportRecorder >> recordingLocally [
	^ self recordingInto: GtReportsLocalStore default

]

{ #category : #accessing }
GtReportRecorder >> recordingName [
	^ self subclassResponsibility

]

{ #category : #accessing }
GtReportRecorder >> recordingPriority [
	^ Processor userInterruptPriority

]

{ #category : #actions }
GtReportRecorder >> recordingWithoutStoring [
	^ self recordingInto: GtNoReportsStore new

]

{ #category : #initialization }
GtReportRecorder >> setImageData: anImageData [
	imageData := anImageData

]

{ #category : #accessing }
GtReportRecorder >> settingsAttributes [
	^ OrderedCollection new
		add: 'Recording' -> self recordingName;
		add: 'Priority' -> self recordingPriority;
		add: 'Image data' -> imageData;
		yourself

]

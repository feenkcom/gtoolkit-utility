Class {
	#name : #GtReportRecording,
	#superclass : #Object,
	#instVars : [
		'recorder',
		'store',
		'announcer',
		'process',
		'startedAt',
		'report',
		'entry',
		'error'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtReportRecording class >> recorder: aRecorder store: aStore [
	^ self new setRecorder: aRecorder store: aStore

]

{ #category : #accessing }
GtReportRecording >> announcer [
	^ announcer

]

{ #category : #accessing }
GtReportRecording >> entry [
	^ entry

]

{ #category : #'gt - extensions' }
GtReportRecording >> gtInspectReportActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect the report';
		action: [ :aButton | report ifNotNil: [ :aReport | aButton phlow spawnObject: aReport ] ]

]

{ #category : #'gt - extensions' }
GtReportRecording >> gtStartActionFor: anAction [
	<gtAction>
	self isStarted ifTrue: [ ^ anAction noAction ].
	^ anAction button
		icon: BrGlamorousVectorIcons play;
		tooltip: 'Start the recording';
		priority: 5;
		action: [ :aButton |
			aButton disable.
			self whenEndedUpdateToolOf: aButton.
			self start ]

]

{ #category : #'gt - extensions' }
GtReportRecording >> gtStoredFilesFor: aView [
	<gtView>
	entry ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Stored files';
		priority: 10;
		object: [ entry ];
		view: #gtFilesFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect the stored entry'
			action: [ :aButton | aButton phlow spawnObject: entry ]

]

{ #category : #'gt - extensions' }
GtReportRecording >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ OrderedCollection new
			add: 'State' -> self stateDescription;
			add: 'Recorder' -> recorder;
			add: 'Store' -> store;
			add: 'Started at' -> startedAt;
			add: 'Report' -> report;
			add: 'Stored files' -> entry;
			add: 'Error' -> error;
			yourself ];
		column: 'Attribute' text: [ :each | each key ] width: 250;
		column: 'Value' text: [ :each | each value ifNil: [ '-' ] ];
		send: [ :each | each value ];
		updateWhen: [ GtReportRecordingChanged ] in: [ announcer ]

]

{ #category : #testing }
GtReportRecording >> hasFailed [
	^ error notNil

]

{ #category : #testing }
GtReportRecording >> isSaved [
	^ entry notNil

]

{ #category : #testing }
GtReportRecording >> isStarted [
	^ startedAt notNil

]

{ #category : #private }
GtReportRecording >> notify: anAnnouncementClass [
	announcer announce: (anAnnouncementClass recording: self)

]

{ #category : #printing }
GtReportRecording >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			nextPutAll: recorder description;
			nextPutAll: ' into ';
			nextPutAll: store description;
			nextPutAll: ', ';
			nextPutAll: self stateDescription.
		startedAt ifNotNil: [ :aDateAndTime |
			aStream
				nextPutAll: ', started at ';
				print: aDateAndTime asTime ] ]

]

{ #category : #private }
GtReportRecording >> record [
	[ report := recorder createReport.
	"The report is created at the recording priority, above the UI, so that it is not delayed by a busy UI.
	Storing it (serializing, writing or uploading files) is slow but not urgent: lower the priority first
	so that the UI stays responsive meanwhile."
	Processor activeProcess priority: Processor userBackgroundPriority.
	entry := report storeIn: store.
	self notify: GtReportRecordingEnded ]
		on: Error
		do: [ :anError |
			error := anError.
			self notify: GtReportRecordingEnded.
			anError pass ]

]

{ #category : #accessing }
GtReportRecording >> report [
	^ report

]

{ #category : #initialization }
GtReportRecording >> setRecorder: aRecorder store: aStore [
	recorder := aRecorder.
	store := aStore.
	announcer := Announcer new

]

{ #category : #ui }
GtReportRecording >> showOutcomeOn: aButton [
	aButton enqueueTask: (BlTaskAction new action: [
		aButton enable.
		aButton addChangingColorAnimationFor: (self hasFailed
			ifTrue: [ BrGlamorousColors errorBackgroundColor ]
			ifFalse: [ BrGlamorousColors successBackgroundColor ]) ])

]

{ #category : #actions }
GtReportRecording >> start [
	startedAt := DateAndTime now.
	self notify: GtReportRecordingStarted.
	process := [ self record ]
		forkAt: recorder recordingPriority
		named: 'Record ' , recorder recordingName.

]

{ #category : #accessing }
GtReportRecording >> stateDescription [
	self hasFailed ifTrue: [ ^ 'Failed' ].
	self isSaved ifTrue: [ ^ 'Saved' ].
	^ self isStarted ifTrue: [ 'Recording' ] ifFalse: [ 'Not started' ]

]

{ #category : #ui }
GtReportRecording >> whenEndedShowOutcomeOn: aButton [
	announcer
		when: GtReportRecordingEnded
		do: [ :anAnnouncement | self showOutcomeOn: aButton ]
		for: aButton

]

{ #category : #ui }
GtReportRecording >> whenEndedUpdateToolOf: aButton [
	announcer
		when: GtReportRecordingEnded
		do: [ :anAnnouncement |
			aButton enqueueTask: (BlTaskAction new action: [ aButton phlow fireToolUpdateWish ]) ]
		for: aButton

]

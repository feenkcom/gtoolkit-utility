"
I record a Message Tally of the whole image for a fixed duration (30 seconds by default) with a given poll period, into a `GtMessageTallyReport`. I am meant to run in the background, so the UI stays usable and what is done in it is profiled.
"
Class {
	#name : #GtMessageTallyReportRecorder,
	#superclass : #GtReportRecorder,
	#instVars : [
		'duration',
		'pollPeriodMilliseconds'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #actions }
GtMessageTallyReportRecorder >> completeReport: aReport [
	aReport recordText.
	^ aReport

]

{ #category : #printing }
GtMessageTallyReportRecorder >> description [
	^ super description , ', ' , duration gtHumanReadableString

]

{ #category : #accessing }
GtMessageTallyReportRecorder >> duration [
	^ duration

]

{ #category : #accessing }
GtMessageTallyReportRecorder >> duration: aDuration [
	duration := aDuration

]

{ #category : #'gt - extensions' }
GtMessageTallyReportRecorder >> gtRecordActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons playinspect;
		tooltip: 'Record in the background and inspect the report';
		priority: 5;
		action: [ :aButton |
			aButton disable.
			self recordingWithoutStoring
				whenEndedSpawnReportFrom: aButton;
				start ]

]

{ #category : #initialization }
GtMessageTallyReportRecorder >> initialize [
	super initialize.
	duration := 30 seconds.
	pollPeriodMilliseconds := MessageTally defaultPollPeriod

]

{ #category : #testing }
GtMessageTallyReportRecorder >> isAvailable [
	^MessageTally isSpying not
]

{ #category : #accessing }
GtMessageTallyReportRecorder >> newReport [
	^ GtMessageTallyReport new
		imageData: imageData;
		duration: duration;
		pollPeriodMilliseconds: pollPeriodMilliseconds;
		yourself

]

{ #category : #accessing }
GtMessageTallyReportRecorder >> pollPeriodMilliseconds [
	^ pollPeriodMilliseconds

]

{ #category : #accessing }
GtMessageTallyReportRecorder >> pollPeriodMilliseconds: anInteger [
	pollPeriodMilliseconds := anInteger

]

{ #category : #actions }
GtMessageTallyReportRecorder >> recordReport [
	| report initialParameters messageTally |
	report := self newReport.
	report startTime: DateAndTime now.
	initialParameters := GtVmAllParametersReport recordNewReport.
	messageTally := MessageTally new.
	messageTally reportOtherProcesses: true.
	messageTally spyAllEvery: pollPeriodMilliseconds on: [ duration wait ].
	report vmParametersDiff: (GtVmAllParametersDiffReport new
		sourceReport: initialParameters;
		targetReport: GtVmAllParametersReport recordNewReport;
		yourself).
	report recordTally: messageTally.
	^ report

]

{ #category : #accessing }
GtMessageTallyReportRecorder >> recordingName [
	^ 'Message Tally'

]

{ #category : #actions }
GtMessageTallyReportRecorder >> renewed [
	^(super renewed)
		duration: duration;
		pollPeriodMilliseconds: pollPeriodMilliseconds;
		yourself
]

{ #category : #accessing }
GtMessageTallyReportRecorder >> settingsAttributes [
	^ super settingsAttributes
		add: 'Duration' -> duration;
		add: 'Poll period (ms)' -> pollPeriodMilliseconds;
		yourself

]

{ #category : #accessing }
GtMessageTallyReportRecorder >> unavailabilityDescription [
	^'A Message Tally is already running'
]

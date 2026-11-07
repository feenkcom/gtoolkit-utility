Class {
	#name : #GtReportRecordingChanged,
	#superclass : #Announcement,
	#instVars : [
		'recording'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'instance creation' }
GtReportRecordingChanged class >> recording: aRecording [
	^ self new setRecording: aRecording

]

{ #category : #accessing }
GtReportRecordingChanged >> recording [
	^ recording

]

{ #category : #initialization }
GtReportRecordingChanged >> setRecording: aRecording [
	recording := aRecording

]

"
I record a space tally of the whole image (`GtSpaceTallyReport`). The VM walks the whole heap while recording, which freezes the image for a few seconds; storing the report takes much longer, so I am meant to run in the background.
"
Class {
	#name : #GtSpaceTallyReportRecorder,
	#superclass : #GtReportRecorder,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'gt - extensions' }
GtSpaceTallyReportRecorder >> gtRecordActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons playinspect;
		tooltip: 'Record the report and inspect it';
		priority: 5;
		action: [ :aButton | aButton phlow spawnObject: self createReport ]

]

{ #category : #accessing }
GtSpaceTallyReportRecorder >> newReport [
	^ GtSpaceTallyReport imageData: imageData

]

{ #category : #actions }
GtSpaceTallyReportRecorder >> recordReport [
	^ GtSpaceTallyReport recordNewReportWithImageData: imageData

]

{ #category : #accessing }
GtSpaceTallyReportRecorder >> recordingName [
	^ 'Space tally'

]

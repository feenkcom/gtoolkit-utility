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

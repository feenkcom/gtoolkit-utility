Class {
	#name : #GtProcessesReportRecorder,
	#superclass : #GtReportRecorder,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #'gt - extensions' }
GtProcessesReportRecorder >> gtRecordActionFor: anAction [
	<gtAction>
	
	^ anAction button
		icon: BrGlamorousVectorIcons playinspect;
		tooltip: 'Record the report and inspect it';
		priority: 5;
		action: [ :aButton | 
			aButton phlow spawnObject: self createReport ]

]

{ #category : #accessing }
GtProcessesReportRecorder >> newReport [
	^ GtProcessesReport new
		imageData: imageData;
		yourself

]

{ #category : #actions }
GtProcessesReportRecorder >> recordReport [
	^ self newReport
		recordReportStatistics;
		yourself

]

{ #category : #accessing }
GtProcessesReportRecorder >> recordingName [
	^ 'Processes report'

]

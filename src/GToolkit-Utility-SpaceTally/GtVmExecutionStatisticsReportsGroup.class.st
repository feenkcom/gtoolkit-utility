Class {
	#name : #GtVmExecutionStatisticsReportsGroup,
	#superclass : #GtBasicGroup,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmExecutionStatisticsReportsGroup >> gtViewGcStatisticsFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'VM GC Statistics';
		items: [ self ];
		column: 'Execution' text: [ :aReport | aReport label ];
		column: 'Total Time' text: [ :aReport | aReport totalRunningDuration ];
		column: 'Total GC Time' text: [ :aReport | aReport totalGcDuration ]
]

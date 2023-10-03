Class {
	#name : #GtVmExecutionStatisticsReportsGroup,
	#superclass : #GtBasicGroup,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmExecutionStatisticsReportsGroup >> gtViewGcStatisticsFor:  aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'VM GC Statistics';
		items: [ self ];
		column: 'Execution' text: [ :aReport | aReport label ];
		column: 'Total Time' text: [ :aReport | aReport totalRunningDuration ];
		column: 'GC Percentage' text: [ :aReport | 
			(aReport gcRunningTimePercentage printShowingDecimalPlaces: 2), ' %' ];
		column: 'Total GC Time' text: [ :aReport | aReport totalGcDuration ];
		column: 'Full GC Time' text: [ :aReport | aReport fullGcDuration ];
		column: 'Incremental GC Time' text: [ :aReport | aReport incrGcDuration ]
]

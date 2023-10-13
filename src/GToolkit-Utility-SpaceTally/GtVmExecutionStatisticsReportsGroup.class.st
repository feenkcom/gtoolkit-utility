Class {
	#name : #GtVmExecutionStatisticsReportsGroup,
	#superclass : #GtBasicGroup,
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #accessing }
GtVmExecutionStatisticsReportsGroup >> gtViewGcFullStatisticsFor:  aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'VM GC Statistics (full)';
		items: [ self ];
		priority: 15;
		column: 'Execution' text: [ :aReport | aReport label ];
		column: 'Total Time' text: [ :aReport | aReport totalRunningDuration ];
		column: 'GC Percentage' text: [ :aReport | 
			(aReport gcRunningTimePercentage printShowingDecimalPlaces: 2), ' %' ];
		column: 'Total GC Time' text: [ :aReport | aReport totalGcDuration ];
		column: 'Full GC Time' text: [ :aReport | aReport fullGcDuration ];
		column: 'Incremental GC Time' text: [ :aReport | aReport incrGcDuration ];
		column: 'Full GC Count' text: [ :aReport | aReport fullGCsDiff];
		column: 'Incremental GC Count' text: [ :aReport | aReport incrGCsDiff];
		column: 'Average Full GC Time' text: [ :aReport | (aReport fullGCsDiff isZero 
			ifFalse: [(Duration milliSeconds: aReport fullGcTimeDiff / aReport fullGCsDiff)]
			ifTrue: [ '-' ])];
		column: 'Average Incremental GC Time' text: [ :aReport | (aReport incrGCsDiff isZero 
			ifFalse: [(Duration milliSeconds: aReport incrGcTimeDiff / aReport incrGCsDiff)]
			ifTrue: [ '-' ])]
]

{ #category : #accessing }
GtVmExecutionStatisticsReportsGroup >> gtViewGcStatisticsFor:  aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'VM GC Statistics';
		priority: 5;
		items: [ self ];
		column: 'Execution' text: [ :aReport | aReport label ];
		column: 'Total Time' text: [ :aReport | aReport totalRunningDuration ];
		column: 'GC Percentage' text: [ :aReport | 
			(aReport gcRunningTimePercentage printShowingDecimalPlaces: 2), ' %' ];
		column: 'Total GC Time' text: [ :aReport | aReport totalGcDuration ];
		column: 'Full GC Time' text: [ :aReport | aReport fullGcDuration ];
		column: 'Incremental GC Time' text: [ :aReport | aReport incrGcDuration ]
]

Class {
	#name : #GtRlGlamorousToolkitReleaserLogExamples,
	#superclass : #Object,
	#category : #'GToolkit-Releaser-Logging-Analysis'
}

{ #category : #accessing }
GtRlGlamorousToolkitReleaserLogExamples >> eventsGrouperWithLoadedData [
	<gtExample>
	| eventsGrouper |
	eventsGrouper := GtRlReleaserSignalsLogReader readFromFile:  self logFile.
	
	self assert: eventsGrouper numberOfRootEvents equals: 159.
	
	^ eventsGrouper
]

{ #category : #accessing }
GtRlGlamorousToolkitReleaserLogExamples >> logFile [
	^  FileLocator gtResource
		/ 'feenkcom/gtoolkit/doc/releaser'
		/ 'releaser-log-example.txt'.
]

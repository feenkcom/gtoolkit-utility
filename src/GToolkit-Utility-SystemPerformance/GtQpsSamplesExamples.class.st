Class {
	#name : #GtQpsSamplesExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-SystemPerformance-Examples'
}

{ #category : #'as yet unclassified' }
GtQpsSamplesExamples >> shortSample [
	<gtExample>
	"Sample every 100ms for 1 seconds"
	| samples sampleProc busyProc start now semaphore |

	samples := GtQpsSamples new
		duration: 1 second;
		count: 10.
	sampleProc := [ samples gather ] forkAt: Processor highIOPriority.
	semaphore := Semaphore new.
	busyProc := [
		now := DateAndTime now.
		start := now.
		[ (now - start) < 150 milliSeconds ] whileTrue:
			[ now := DateAndTime now ].
		semaphore signal ] forkNamed: 'shortSample loop'.
	semaphore wait.
	^ samples.
]

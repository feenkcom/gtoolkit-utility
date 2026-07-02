Class {
	#name : #GtReleaseLatchExamples,
	#superclass : #TestCase,
	#category : #'GToolkit-Utility-Tests'
}

{ #category : #examples }
GtReleaseLatchExamples >> newLatchIsInitiallyClosed [
	<gtExample>
	| latch |
	latch := GtReleaseLatch new.
	self deny: latch isReleased.
	^ latch
]

{ #category : #examples }
GtReleaseLatchExamples >> signalIsIdempotent [
	<gtExample>
	| latch |
	latch := self signalReleasesCurrentWaitersAndFutureWaiters.
	latch signal.
	self assert: latch isReleased.
	^ latch
]

{ #category : #examples }
GtReleaseLatchExamples >> signalReleasesCurrentWaitersAndFutureWaiters [
	<gtExample>
	| latch firstWaiterDone secondWaiterDone firstDoneSemaphore secondDoneSemaphore priority |
	latch := GtReleaseLatch new.
	firstWaiterDone := false.
	secondWaiterDone := false.
	firstDoneSemaphore := Semaphore new.
	secondDoneSemaphore := Semaphore new.
	priority := Processor activeProcess priority.
	Processor activeProcess priority: 40.
	[ latch wait.
	firstWaiterDone := true.
	firstDoneSemaphore signal ] forkAt: 42.
	[ latch wait.
	secondWaiterDone := true.
	secondDoneSemaphore signal ] forkAt: 41.
	self deny: firstDoneSemaphore isSignaled.
	self deny: secondDoneSemaphore isSignaled.
	latch signal.
	firstDoneSemaphore wait.
	secondDoneSemaphore wait.
	self assert: firstWaiterDone.
	self assert: secondWaiterDone.
	latch wait.
	self assert: latch isReleased.
	Processor activeProcess priority: priority.
	^ latch
]

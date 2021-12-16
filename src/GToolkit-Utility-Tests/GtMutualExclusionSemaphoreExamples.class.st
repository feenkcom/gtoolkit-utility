Class {
	#name : #GtMutualExclusionSemaphoreExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Utility-Tests'
}

{ #category : #examples }
GtMutualExclusionSemaphoreExamples >> multiProcessAccess [
	"Demonstrate normal critical operation across multiple processes"
	<gtExample>
	| mutualExclusion sem1 sem2 sem3 flagged priority |

	mutualExclusion := GtMutualExclusionSemaphore forMutualExclusion.
	flagged := false.
	sem1 := Semaphore new.
	sem2 := Semaphore new.
	sem3 := Semaphore new.
	"Ensure the active process has priority 40 so that the forked processes get to run first"
	priority := Processor activeProcess priority.
	Processor activeProcess priority: 40.
	[ mutualExclusion critical: [ sem1 wait. sem2 signal ] ] forkAt: 42.
	[ mutualExclusion critical: [ sem2 wait. flagged := true. sem3 signal. ] ] forkAt: 41.
	self deny: sem3 isSignaled.
	sem1 signal.
	sem3 wait.
	self assert: flagged.
	Processor activeProcess priority: priority.

]

{ #category : #examples }
GtMutualExclusionSemaphoreExamples >> preventProcessDeadlock [
	"Demonstrate that {{gtClass:GtMutualExclusionSemaphore}} prevents process from re-entering the critical section"
	<gtExample>
	| semaphore flagged |

	semaphore := GtMutualExclusionSemaphore forMutualExclusion.
	flagged := false.
	self 
		should: [ semaphore critical: [ semaphore critical: [ flagged := true ] ] ]
		raise: Error.
	self deny: flagged.
]

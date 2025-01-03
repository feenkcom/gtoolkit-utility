Extension { #name : #FinalizationProcess }

{ #category : #'*GToolkit-Utility-System' }
FinalizationProcess class >> finalizationProcess [
	"The finalization process arranges to send mourn to each element of the VM's finalization queue,
	 which is accessed via primitiveFetchMourner.  The VM signals FinalizationSemaphore whenever
	 the queue is non-empty.  This process loops, waiting on the semaphore, fetches the first element
	 of the queue and then spawns a process at a higher priority to actually send the mourn messages.
	 If an error occurs in the higher priority mourn loop process then this process will simply spawn
	 another process, hence ensuring that errors in finalization methods don't break finalization.

	 In addition this process also runs the old finalization scheme, supporting clients of the older,
	 WeakRegistry based scheme.  Hopefully this will go away when all clients have moved over."
	<gtPharoPatch: #Pharo11>
	| throttle firstMourner |
	throttle := Semaphore new.
	[true] whileTrue: [FinalizationSemaphore wait; initSignals.

	 [firstMourner := self primitiveFetchMourner.
	  firstMourner notNil] whileTrue:
		[MournLoopProcess := [
			[ [ self mournLoopWith: firstMourner]
				on: Error
				fork: [ :ex | ex pass ] ]
					ensure: [ throttle signal ].
		] forkAt: Processor activePriority + 1.
		 throttle wait]]
]

{ #category : #'*GToolkit-Utility-System' }
FinalizationProcess class >> gtSummaryFor: aView [
	<gtView>
	<gtClassView>

	^ aView columnedList
		title: 'Summary';
		priority: 10;
		items: [ {
			'FinalizationProcess' -> TheFinalizationProcess.
			'FinalizationSemaphore' -> FinalizationSemaphore size.
			'MournLoopProcess' -> MournLoopProcess.
			'StopRequested' -> StopRequested.
			'StoppedSemaphore' -> StoppedSemaphore size. } ];
		column: 'Item' text: #key;
		column: 'Value' text: #value;
		actionUpdateButton.
]

{ #category : #'*GToolkit-Utility-System' }
FinalizationProcess class >> mournLoopWith: firstMourner [
	"Send mourn to all the objects available in the mourn queue, starting
	 with firstMourner which the sender has already extracted for us.  If
	 an error occurs here, it will break this loop but the sender will spawn
	 another mournLoopWith: so that finalization is not broken by errors in
	 individual cases."
	<gtPharoPatch: #Pharo11>
	| mourner |
	mourner := firstMourner.
	[ self stopRequested ifTrue:
		[ self stoppedSemaphore signal.
		MournLoopProcess := nil.
		^ self ].
	mourner mourn.
	 (mourner := self primitiveFetchMourner) notNil] whileTrue.
	MournLoopProcess := nil.
]

{ #category : #'*GToolkit-Utility-System' }
FinalizationProcess class >> restartFinalizationProcess [
	"kill any old process, just in case"
	<gtPharoPatch: #Pharo11>

	self stopFinalizationProcess.

	FinalizationSemaphore := Smalltalk specialObjectsArray at: 42.
	StopRequested := false.
	TheFinalizationProcess := [self finalizationProcess]
		forkAt: Processor userInterruptPriority.
	TheFinalizationProcess name: 'WeakArray Finalization Process'
]

{ #category : #'*GToolkit-Utility-System' }
FinalizationProcess class >> shutDown: quitting [
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE"

	self stopFinalizationProcess
]

{ #category : #'*GToolkit-Utility-System' }
FinalizationProcess class >> startUp: resuming [
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE"

	self restartFinalizationProcess
]

{ #category : #'*GToolkit-Utility-System' }
FinalizationProcess class >> stopFinalizationProcess [
	<gtPharoPatch: #Pharo11>
	"DO NOT EDIT HERE"

	TheFinalizationProcess ifNotNil: 
		[TheFinalizationProcess terminate.
		TheFinalizationProcess := nil].

	(MournLoopProcess isNil or: [ MournLoopProcess isTerminated ])
		ifTrue: [ ^ self ].
	self assert: self stoppedSemaphore isSignaled not.
	StopRequested := true.
	StoppedSemaphore wait.
]

{ #category : #'*GToolkit-Utility-System' }
FinalizationProcess class >> stopRequested [

	^ StopRequested ifNil: [ false ]
]

{ #category : #'*GToolkit-Utility-System' }
FinalizationProcess class >> stoppedSemaphore [

	^ StoppedSemaphore ifNil: [ StoppedSemaphore := Semaphore new ]
]

Extension { #name : #WeakArray }

{ #category : #'*GToolkit-Utility-System' }
WeakArray class >> finalizationProcess [
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
	 "Support the old scheme until things have changed over..."
	 self forPharo11OrNewer: []
	 	forPharo10: [ self doOldFinalization ].
	 [firstMourner := self primitiveFetchMourner.
	  firstMourner notNil] whileTrue:
		[MournLoopProcess := [throttle signal.
		  self mournLoopWith: firstMourner] forkAt: Processor activePriority + 1.
		 throttle wait]]
]

{ #category : #'*GToolkit-Utility-System' }
WeakArray class >> gtSummaryFor: aView [
	<gtView>
	<gtClassView>

	^ aView columnedList
		title: 'Summary';
		priority: 10;
		items: [ {
			'FinalizationProcess' -> (FinalizationProcess isNotNil and: [ FinalizationProcess isTerminated not ]).
			'FinalizationSemaphore' -> FinalizationSemaphore size.
			'MournLoopProcess' -> MournLoopProcess.
			'StopRequested' -> StopRequested.
			'StoppedSemaphore' -> StoppedSemaphore size. } ];
		column: 'Item' text: #key;
		column: 'Value' text: #value;
		actionUpdateButton.
]

{ #category : #'*GToolkit-Utility-System' }
WeakArray class >> initialize [
	"Do we need to initialize specialObjectsArray?"
	<gtPharoPatch: #Pharo11>

	Smalltalk specialObjectsArray size < 42
		ifTrue: [Smalltalk recreateSpecialObjectsArray].

	SessionManager default
		registerSystemClassNamed: self name.

	FinalizationSemaphore := Smalltalk specialObjectsArray at: 42.
	StopRequested := false.
	StoppedSemaphore := Semaphore new.
]

{ #category : #'*GToolkit-Utility-System' }
WeakArray class >> mournLoopWith: firstMourner [
	"Send mourn to all the objects available in the mourn queue, starting
	 with firstMourner which the sender has already extracted for us.  If
	 an error occurs here, it will break this loop but the sender will spawn
	 another mournLoopWith: so that finalization is not broken by errors in
	 individual cases."
	<gtPharoPatch: #Pharo11>
	| mourner |
	mourner := firstMourner.
	[ StopRequested ifTrue:
		[ StoppedSemaphore signal.
		MournLoopProcess := nil.
		^ self ].
	mourner mourn.
	 (mourner := self primitiveFetchMourner) notNil] whileTrue.
	MournLoopProcess := nil.
]

{ #category : #'*GToolkit-Utility-System' }
WeakArray class >> restartFinalizationProcess [
	"kill any old process, just in case"
	<gtPharoPatch: #Pharo11>

	self stopFinalizationProcess.

	FinalizationSemaphore := Smalltalk specialObjectsArray at: 42.
	StopRequested := false.
	StoppedSemaphore ifNil:
		[ StoppedSemaphore := Semaphore new ].
	FinalizationProcess := [self finalizationProcess]
		forkAt: Processor userInterruptPriority.
	FinalizationProcess name: 'WeakArray Finalization Process'
]

{ #category : #'*GToolkit-Utility-System' }
WeakArray class >> shutDown: quitting [
	<gtPharoPatch: #Pharo11>

	self stopFinalizationProcess
]

{ #category : #'*GToolkit-Utility-System' }
WeakArray class >> startUp: resuming [
	<gtPharoPatch: #Pharo11>

	self restartFinalizationProcess
]

{ #category : #'*GToolkit-Utility-System' }
WeakArray class >> stopFinalizationProcess [
	<gtPharoPatch: #Pharo11>

	FinalizationProcess ifNotNil: 
		[FinalizationProcess terminate.
		FinalizationProcess := nil].

	(MournLoopProcess isNil or: [ MournLoopProcess isTerminated ])
		ifTrue: [ ^ self ].
	self assert: StoppedSemaphore isSignaled not.
	StopRequested := true.
	StoppedSemaphore wait.

]

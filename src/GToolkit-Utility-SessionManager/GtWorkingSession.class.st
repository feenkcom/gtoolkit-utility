"
I am GtWorkingSession.
I am a WorkingSession.

I am used by GtSessionManager to record information about which actions where performed during startup and shutdown and how long they took.
"
Class {
	#name : #GtWorkingSession,
	#superclass : #WorkingSession,
	#category : #'GToolkit-Utility-SessionManager-Utilities'
}

{ #category : #'gt-extensions' }
GtWorkingSession >> gtViewDetailsIn: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		priority: 30;
		items: [ {
			{ #self . self }.
			{ #id . self id printString . self id }.
			{ #creationTime . self creationTime  }.
			{ #deferredStartupActions . 
				deferredStartupActions size. 
				deferredStartupActions  } 
		} , 
		(self properties associations 
			collect: [ :association | { association key. association value } ]) ];
		column: #key text: #first weight: 0.5;
		column: #value text: #second;
		send: #last
]

{ #category : #printing }
GtWorkingSession >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(; print: self id; nextPut: $)
]

{ #category : #'startup - shutdown' }
GtWorkingSession >> runShutdown: isImageQuitting [
	manager shutDownEvents removeAll.
	self
		runList: manager shutdownList
		do: [ :each | | initialMillliseconds event |
			initialMillliseconds := Time millisecondClockValue.
			each shutdown: isImageQuitting.
			event := GtSessionHandlerEvent new
				handler: each;
				action: #shutDown;
				flag: isImageQuitting;
				duration: (Time millisecondsSince: initialMillliseconds).
			manager shutDownEvents add: event ]
]

{ #category : #'startup - shutdown' }
GtWorkingSession >> runStartup: isImageStarting [
	manager startUpEvents removeAll.
	self
		runList: manager startupList
		do: [ :each | | initialMillliseconds event |
			initialMillliseconds := Time millisecondClockValue.
			each startup: isImageStarting.
			event := GtSessionHandlerEvent new
				handler: each;
				action: #startUp;
				flag: isImageStarting;
				duration: (Time millisecondsSince: initialMillliseconds).
			manager startUpEvents add: event ]
]

{ #category : #'startup - shutdown' }
GtWorkingSession >> stop: isImageQuitting [
	super stop: isImageQuitting.
	manager dumpShutdownEvents
]

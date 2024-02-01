"
I am GtSessionMananger.
I am a SessionManager.

I use my own session class, GtWorkingSession, that records GtSessionHandlerEvent object in me during startUp and shutDown.

This record of events documents what happened and how long each step took.
"
Class {
	#name : #GtSessionManager,
	#superclass : #SessionManager,
	#instVars : [
		'startUpEvents',
		'shutDownEvents'
	],
	#category : #'GToolkit-Utility-SessionManager-Base'
}

{ #category : #utilities }
GtSessionManager class >> install [
	"Install an instance of me as a replacement for the normal SessionManager"
	
	| newSessionManager currentSession|
	newSessionManager := self new.
	SessionManager default gtStartupListWithDetails do: [ :each |
		"make sure to use the category of the new manager"
		newSessionManager 
			register: each third 
			inCategory: (newSessionManager categoryNamed: each first name) 
			atPriority: each second ].
	"change the class of the current session while keeping its identity"
	currentSession := SessionManager default currentSession.
	GtWorkingSession adoptInstance: currentSession.
	newSessionManager installSession: currentSession.
	SessionManager default: newSessionManager.
	^ newSessionManager
]

{ #category : #utilities }
GtSessionManager class >> uninstall [
	"Uninstall me and reinstall the normal SessionManager"
	
	| standardSessionManager currentSession|
	standardSessionManager := SessionManager new.
	SessionManager default gtStartupListWithDetails do: [ :each |
		"make sure to use the category of the new manager"
		standardSessionManager 
			register: each third 
			inCategory: (standardSessionManager categoryNamed: each first name) 
			atPriority: each second ]. 
	"change the class of the current session while keeping its identity"
	currentSession := SessionManager default currentSession.
	WorkingSession adoptInstance: currentSession.
	standardSessionManager installSession: currentSession.
	SessionManager default: standardSessionManager.
	^ standardSessionManager
]

{ #category : #'session management' }
GtSessionManager >> dumpShutdownEvents [
	self shutDownEventsLog ensureDelete; writeStreamDo: [ :out | 
		self shutDownEvents do: [ :each |
			out
				nextPutAll: each handledId;
				nextPut: $|;
				nextPutAll: each shutDownMethod printString;
				nextPut: $|;
				print: each duration;
				nextPutAll: ' ms';
				nextPutAll: OSPlatform current lineEnding ] ]
]

{ #category : #accessing }
GtSessionManager >> gtViewShutDownEventsFor: aView [
	<gtView>
	self shutDownEvents isEmpty ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Shutdown events';
		priority: 35;
		items: [ self shutDownEvents ];
		column: #Handler text: #handler;
		column: #Method text: [ :each | 
			each shutDownMethod methodClass = Behavior
				ifTrue: [ each shutDownMethod printString asRopedText foreground: Color gray ]
				ifFalse: [ each shutDownMethod ] ];
		column: #Flag text: [ :each | 
			each flag ifTrue: [ each flagDescription ] ifFalse: [ 'running' ] ];
		column: 'Duration (ms)' text: [ :each |
			each duration isZero
				ifTrue: [ 0 asRopedText foreground: Color gray ]
				ifFalse: [ each duration ] ] 
]

{ #category : #accessing }
GtSessionManager >> gtViewStartUpEventsFor: aView [
	<gtView>
	self startUpEvents isEmpty ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Startup events';
		priority: 30;
		items: [ self startUpEvents ];
		column: #Handler text: #handler;
		column: #Method text: [ :each | 
			each startUpMethod methodClass = Behavior
				ifTrue: [ each startUpMethod printString asRopedText foreground: Color gray ]
				ifFalse: [ each startUpMethod ] ];
		column: 'Duration (ms)' text: [ :each |
			each duration isZero
				ifTrue: [ 0 asRopedText foreground: Color gray ]
				ifFalse: [ each duration ] ] 
]

{ #category : #initialization }
GtSessionManager >> initialize [
	super initialize.
	startUpEvents := OrderedCollection new.
	shutDownEvents := OrderedCollection new
]

{ #category : #'session management' }
GtSessionManager >> newSession [
	| aWorkingSession |
	aWorkingSession := GtWorkingSession new.
	aWorkingSession manager: self.
	^ aWorkingSession
]

{ #category : #accessing }
GtSessionManager >> shutDownEvents [
	^ shutDownEvents
]

{ #category : #'session management' }
GtSessionManager >> shutDownEventsLog [
	^ FileLocator imageDirectory / 'gt-session-manager-shutdown-events.log'
]

{ #category : #accessing }
GtSessionManager >> startUpEvents [
	^ startUpEvents
]

"
I am GtSessionHandlerEvent.

I hold a record of a startUp or shutDown action that was performed and its duration in milliseconds.
"
Class {
	#name : #GtSessionHandlerEvent,
	#superclass : #Object,
	#instVars : [
		'handler',
		'duration',
		'action'
	],
	#category : #'GToolkit-Utility-SessionManager-Utilities'
}

{ #category : #accessing }
GtSessionHandlerEvent >> action [
	^ action
]

{ #category : #accessing }
GtSessionHandlerEvent >> action: symbol [
	self assert: (#(startUp shutDown) includes: symbol).
	action := symbol
]

{ #category : #accessing }
GtSessionHandlerEvent >> actionMethod [
	^ self action = #startUp
		ifTrue: [ self startUpMethod ]
		ifFalse: [ self shutDownMethod ]
]

{ #category : #accessing }
GtSessionHandlerEvent >> duration [
	^ duration ifNil: [ 0 ]
]

{ #category : #accessing }
GtSessionHandlerEvent >> duration: milliseconds [
	duration := milliseconds
]

{ #category : #accessing }
GtSessionHandlerEvent >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 30;
		items: [ {
			{ #action. self action }.
			{ #handler. self handler }.
			{ #method. self actionMethod }.
			{ 'duration (ms)'. self duration } 
			} ];
		column: #key text: #first;
		column: #value text: #second;
		send: #second
]

{ #category : #accessing }
GtSessionHandlerEvent >> handledId [
	^ self handler handledId
]

{ #category : #accessing }
GtSessionHandlerEvent >> handler [
	^ handler
]

{ #category : #accessing }
GtSessionHandlerEvent >> handler: sessionHandler [
	handler := sessionHandler
]

{ #category : #accessing }
GtSessionHandlerEvent >> shutDownMethod [
	^ [ self handler gtShutDownMethod ]
		on: MessageNotUnderstood
		do: [ self handler class lookupSelector: #shutdown: ]
]

{ #category : #accessing }
GtSessionHandlerEvent >> startUpMethod [
	^ [ self handler gtStartUpMethod ]
		on: MessageNotUnderstood
		do: [ self handler class lookupSelector: #startup: ]
]

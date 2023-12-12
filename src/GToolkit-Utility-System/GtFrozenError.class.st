"
GtFrozenError holds another exception and its original stack trace.  This allows the information to be kept and resignalled in another process.
"
Class {
	#name : #GtFrozenError,
	#superclass : #Error,
	#instVars : [
		'originalException',
		'stackString'
	],
	#category : #'GToolkit-Utility-System'
}

{ #category : #'instance creation' }
GtFrozenError class >> originalException: anException [

	^ self new 
		initializeWithException: anException
		stackString: anException stackString
]

{ #category : #'instance creation' }
GtFrozenError class >> signalOriginalException: anException [

	^ (self originalException: anException) signal
]

{ #category : #accessing }
GtFrozenError >> description [

	^ String streamContents: [ :stream |
		stream
			<< 'Frozen: ';
			<< (originalException messageText ifEmpty:
				[ originalException defaultDescription ]);
			lf; lf;
			<< 'Original Stack:';
			lf;
			print: stackString ]
]

{ #category : #initialization }
GtFrozenError >> initializeWithException: anException stackString: aString [

	originalException := anException.
	stackString := aString
]

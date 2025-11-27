Class {
	#name : #GtSubprocessError,
	#superclass : #Error,
	#instVars : [
		'process'
	],
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
GtSubprocessError >> description [

	^ String streamContents: [ :stream | | mt |
		stream
			<< 'OS Subprocess completed unsuccessfully:'; cr.
		(mt := self messageText) isEmptyOrNil
			ifFalse: [ stream << ': ' << mt ].
		process exitStatusInterpreter ifNil: 
			[ stream 
				<< 'Probably an unknown command: ';
				<< process command; cr ].
		process pollException ifNil:
			[ stream
				tab; << 'Command: ';
					print: process command; cr;
				tab; << 'Arguments: ';
					print: process arguments; cr;
				tab; << 'Code: ';
					print: process exitCode; cr;
				tab; << 'Retries: ';
					print: process retryCount; cr;
				tab; << 'Stdout: ';
					<< process stdout asString; cr;
				tab; << 'Stderr: ';
					<< process stderr asString; cr ]
		ifNotNil:
			[ process pollException printOn: stream ] ]
]

{ #category : #accessing }
GtSubprocessError >> process [

	^ process
]

{ #category : #accessing }
GtSubprocessError >> process: anObject [

	process := anObject
]

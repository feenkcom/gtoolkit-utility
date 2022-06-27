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

	^ String streamContents: [ :stream |
		stream
			<< 'OS Subprocess completed unsuccessfully:'; cr;
			tab; << 'Command: ';
				print: process command; cr;
			tab; << 'Arguments: ';
				print: process arguments; cr;
			tab; << 'Code: ';
				print: process exitCode; cr;
			tab; << 'Stdout: ';
				<< process stdout asString; cr;
			tab; << 'Stderr: ';
				<< process stderr asString; cr ]
]

{ #category : #accessing }
GtSubprocessError >> messageText [

	^ messageText ifNil: 
		[ process exitStatusInterpreter 
			ifNil: [ 'Probably an unknown command: ', process command ]
			ifNotNil: [ self description ] ]
]

{ #category : #accessing }
GtSubprocessError >> process [

	^ process
]

{ #category : #accessing }
GtSubprocessError >> process: anObject [

	process := anObject
]

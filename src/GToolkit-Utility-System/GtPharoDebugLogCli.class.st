Class {
	#name : #GtPharoDebugLogCli,
	#superclass : #Object,
	#category : #'GToolkit-Utility-System'
}

{ #category : #initialization }
GtPharoDebugLogCli class >> checkForPharoDebugLog [
	| arguments index filename |

	arguments := Smalltalk argumentsStartingAtIndex: 0.
	index := arguments indexOf: '--pharoDebugLog'.
	index = 0 ifTrue: [ ^ self ].
	index = arguments size ifTrue:
		[ self error: '--pharoDebugLog: no file name supplied' ].
	filename := arguments at: index + 1.
	Stdio stdout
		<< 'PharoDebug.log filename set to: ';
		<< filename;
		lf.
	Smalltalk logFileName: filename
]

{ #category : #initialization }
GtPharoDebugLogCli class >> initialize [
	SessionManager default
		registerSystemClassNamed: self name
]

{ #category : #initialization }
GtPharoDebugLogCli class >> pharoDebugLogPresent [
	"Answer a boolean indicating if the pharoDebugLog option is present on the command line"
	
	^ ((Smalltalk argumentsStartingAtIndex: 0) indexOf: '--pharoDebugLog') > 0
]

{ #category : #initialization }
GtPharoDebugLogCli class >> startUp: resuming [

	resuming ifTrue: 
		[ self checkForPharoDebugLog ]
]

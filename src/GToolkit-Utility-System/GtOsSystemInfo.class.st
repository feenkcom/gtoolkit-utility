"
GtOsSystemInfo provides information about the host computer Gt is running on.
"
Class {
	#name : #GtOsSystemInfo,
	#superclass : #Object,
	#category : #'GToolkit-Utility-System'
}

{ #category : #'instance creation' }
GtOsSystemInfo class >> current [
	"Answer an appropriate system info instance for the current platform"
	| cls currentName |

	currentName := OSPlatform current name.
	cls := self subclasses detect: [ :each | each platformName = currentName ].
	^ cls new.
]

{ #category : #private }
GtOsSystemInfo >> colonSeparatedGet: key from: filename [
	"Answer the specified key from the colon separated file"
	| line fields |

	filename asFileReference readStreamDo: [ :stream |
		[ stream atEnd ] whileFalse:
			[ line := stream nextLine.
			fields := $: split: line.
			fields first trimBoth = key ifTrue:
				[ ^ fields second trimBoth ] ] ].
	^ KeyNotFound signalFor: key
]

{ #category : #'cpu info' }
GtOsSystemInfo >> freeMemory [
	"Answer the free RAM of the host in bytes"

	^ self subclassResponsibility 
]

{ #category : #'cpu info' }
GtOsSystemInfo >> numberOfCores [
	"Answer the number of cores on the host"

	^ self subclassResponsibility 
]

{ #category : #'cpu info' }
GtOsSystemInfo >> physicalMemory [
	"Answer the RAM capacity of the host in bytes"

	^ self subclassResponsibility 
]

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
GtOsSystemInfo >> colonSeparatedGet: key fromFile: filename [
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

{ #category : #private }
GtOsSystemInfo >> colonSeparatedGet: key fromString: aString [
	"Answer the specified key from the colon separated string"
	| fields |

	aString lines do: [ :line |
		fields := $: split: line.
		fields first trimBoth = key ifTrue:
			[ ^ fields second trimBoth ] ].
	^ KeyNotFound signalFor: key
]

{ #category : #'process info' }
GtOsSystemInfo >> currentProcessId [
	"Answer the OS PID of the current process"

	^ self subclassResponsibility 
]

{ #category : #'cpu info' }
GtOsSystemInfo >> freeMemory [
	"Answer the free RAM of the host in bytes"

	^ self subclassResponsibility 
]

{ #category : #ui }
GtOsSystemInfo >> gtSummaryFor: aView [
	<gtView>

	^ aView columnedList
		  title: 'Summary';
		  priority: 10;
		  items: [ self summaryAttributes ];
		  column: #Attribute text: [ :item | item key ];
		  column: #Value text: [ :item | item value ].
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

{ #category : #ui }
GtOsSystemInfo >> summaryAttributes [

	^ { 
	#NumberOfCores -> self numberOfCores.
	#PhysicalMemory -> self physicalMemory humanReadableIsqByteSize.
	#FreeMemory -> self freeMemory humanReadableIsqByteSize.
	 }
]

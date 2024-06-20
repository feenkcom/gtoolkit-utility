Class {
	#name : #GtVmReportVmSingleParameter,
	#superclass : #GtVmReportParameter,
	#instVars : [
		'index'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmReportVmSingleParameter class >> leJsonV4Name [

	^ #gtVmReportVmSingleParameter
]

{ #category : #accessing }
GtVmReportVmSingleParameter class >> parameterFormattersPerIndex [
	^ ({
		1  -> (GtVmReportMemoryParameterFormatter labeled: 'Old space size').
		2  -> (GtVmReportMemoryParameterFormatter labeled: 'New space size').
		3  -> (GtVmReportMemoryParameterFormatter labeled: 'Heap size').
		4  -> (GtVmReportFixedParameterFormatter labeled: '<not used>').
		5  -> (GtVmReportFixedParameterFormatter labeled: '<not used>').
		6  -> (GtVmReportFixedParameterFormatter labeled: 'Survivor count treshold'). 
		7  -> (GtVmReportCountParameterFormatter labeled: 'Full GGc count').
		8  -> (GtVmReportMillisecondsDurationParameterFormatter labeled: 'Full GCs duration').
		9  -> (GtVmReportCountParameterFormatter labeled: 'Scavanges count').
		10 -> (GtVmReportMillisecondsDurationParameterFormatter labeled: 'Scavanges duration').
		11  -> (GtVmReportCountParameterFormatter labeled: 'Tenures count').
		12  -> (GtVmReportFixedParameterFormatter labeled: '<not used>').
		16 -> (GtVmReportMicrosecondsDurationParameterFormatter  labeled: 'Milliseconds at idle').
		17  -> (GtVmReportFixedParameterFormatter labeled: 'Fraction of code zone').
		18 -> (GtVmReportMillisecondsDurationParameterFormatter labeled: 'Full GG compaction duration').
		19  -> (GtVmReportFixedParameterFormatter labeled: 'Scavange threshold').
		20  -> (GtVmReportFixedParameterFormatter labeled: 'Time at startup').
		21  -> (GtVmReportCountParameterFormatter labeled: 'Root table size').
		22  -> (GtVmReportCountParameterFormatter  labeled: 'Root table overflows').
		23  -> (GtVmReportMemoryParameterFormatter  labeled: 'Extra VM buffers size').
		24  -> (GtVmReportMemoryParameterFormatter labeled: 'Memory shrinking threshold').
		25  -> (GtVmReportMemoryParameterFormatter labeled: 'Memory headroom').
		26  -> (GtVmReportCountParameterFormatter labeled: 'InterruptChecksEveryNms').
		27  -> (GtVmReportCountParameterFormatter labeled: 'Mark loop iterations').
		28  -> (GtVmReportCountParameterFormatter labeled: 'Sweep loop iterations').
		29  -> (GtVmReportCountParameterFormatter labeled: 'Make Forward loop iterations').
		30  -> (GtVmReportCountParameterFormatter  labeled: 'Compact Move loop iterations').
		31  -> (GtVmReportCountParameterFormatter labeled: 'Grow memory requests').
		32  -> (GtVmReportCountParameterFormatter labeled: 'Shring memory requests').
		33  -> (GtVmReportCountParameterFormatter labeled: 'Root Table entries').
		34  -> (GtVmReportMemoryParameterFormatter labeled: 'Allocated memory since startup').
		35  -> (GtVmReportCountParameterFormatter labeled: 'Survivor objects count').
		36  -> (GtVmReportFixedParameterFormatter labeled: 'IGF/FGC completion milliseconds clock').
		37  -> (GtVmReportCountParameterFormatter labeled: 'Marked objects for roots').
		38  -> (GtVmReportFixedParameterFormatter labeled: 'Current IGC milliseconds').
		39  -> (GtVmReportCountParameterFormatter labeled: 'Finalization signals').
		40  -> (GtVmReportFixedParameterFormatter labeled: 'Bytes per oop').
		41  -> (GtVmReportFixedParameterFormatter labeled: 'Image format version').
		42  -> (GtVmReportFixedParameterFormatter labeled: 'Used stack pages').
		43  -> (GtVmReportFixedParameterFormatter labeled: 'Desired stack pages').
		44  -> (GtVmReportFixedMemoryParameterFormatter labeled: 'Eden size').
		45  -> (GtVmReportFixedMemoryParameterFormatter labeled: 'Desired new space size').
		46  -> (GtVmReportFixedMemoryParameterFormatter labeled: 'Machine code size').
		47  -> (GtVmReportFixedMemoryParameterFormatter labeled: 'Desired machine code size').
		48  -> (GtVmReportFixedParameterFormatter labeled: 'Header flags').
		49  -> (GtVmReportFixedParameterFormatter labeled: 'Max external semaphore table size').
		50  -> (GtVmReportFixedParameterFormatter labeled: '<not used>').
		51  -> (GtVmReportFixedParameterFormatter labeled: '<not used>').
		52  -> (GtVmReportCountParameterFormatter labeled: 'Root table capacity').
		53  -> (GtVmReportCountParameterFormatter labeled: 'Segments count').
		54  -> (GtVmReportMemoryParameterFormatter labeled: 'Free old space size').
		55  -> (GtVmReportFixedParameterFormatter labeled: 'Growth ratio').
		56  -> (GtVmReportCountParameterFormatter labeled: 'Process switches').
		57  -> (GtVmReportCountParameterFormatter labeled: 'IO process events').
		58  -> (GtVmReportCountParameterFormatter labeled: 'Force interrupt checks').
		59  -> (GtVmReportCountParameterFormatter labeled: 'Check event calls').
		60  -> (GtVmReportCountParameterFormatter labeled: 'Stack page overflows').
		61  -> (GtVmReportCountParameterFormatter labeled: 'Stack page divorces').
		62  -> (GtVmReportCountParameterFormatter labeled: 'Compiled code compactions count').
		63 -> (GtVmReportMillisecondsDurationParameterFormatter labeled: 'Compiled code compactions duration').
		64  -> (GtVmReportCountParameterFormatter labeled: 'Currently jitted methods').
		65  -> (GtVmReportFixedParameterFormatter labeled: 'VM features flag').
		66  -> (GtVmReportFixedMemoryParameterFormatter labeled: 'Stack page size').
		67  -> (GtVmReportFixedMemoryParameterFormatter labeled: 'Old space max allowed size').
		68  -> (GtVmReportCountParameterFormatter labeled: 'Average live page scans by GC').
		69  -> (GtVmReportFixedParameterFormatter labeled: 'Maximum live page scans by GC').
		70  -> (GtVmReportFixedParameterFormatter labeled: 'VM proxy major version').
		71  -> (GtVmReportFixedParameterFormatter labeled: 'VM proxy minor version').
		72 -> (GtVmReportMillisecondsDurationParameterFormatter labeled: 'GC mark total duration').
		73 -> (GtVmReportMillisecondsDurationParameterFormatter labeled: 'GC sweep total duration').
		74 -> (GtVmReportFixedParameterFormatter labeled: 'Segment allocation maximum pause').
		75  -> (GtVmReportCountParameterFormatter labeled: 'JIT compiled methods total count').
		76 -> (GtVmReportMillisecondsDurationParameterFormatter labeled: 'JIT compiled methods total duration').
		77  -> (GtVmReportCountParameterFormatter labeled: 'JIT compiled blocks total count').
		78  -> (GtVmReportMillisecondsDurationParameterFormatter labeled: 'JIT compiled blocks total duration').
		79  -> (GtVmReportFixedParameterFormatter labeled: 'Image version').
		}) asOrderedDictionary
		
]

{ #category : #printing }
GtVmReportVmSingleParameter >> descriptionOn: aStream [
	aStream 
		<< '#';
		print: index;
		<< ': '.
	
	super descriptionOn: aStream
]

{ #category : #accessing }
GtVmReportVmSingleParameter >> formattedParameterValue [
	^ self parameterFormater 
		ifNil: [ self parameterValue printString ] 
		ifNotNil: [ :aFormatter | 
			aFormatter formatValue: self parameterValue]
]

{ #category : #accessing }
GtVmReportVmSingleParameter >> index [
	^ index
]

{ #category : #accessing }
GtVmReportVmSingleParameter >> index: anInteger [
	index := anInteger
]

{ #category : #accessing }
GtVmReportVmSingleParameter >> label [
	^ self parameterFormater 
		ifNil: [''] 
		ifNotNil: [ :aFormatter |
			aFormatter label ifNil: [ '' ] ]
]

{ #category : #accessing }
GtVmReportVmSingleParameter >> parameterDetails [
	^ {'Index' -> self index}, super parameterDetails
]

{ #category : #accessing }
GtVmReportVmSingleParameter >> parameterFormater [
	^ (self class parameterFormattersPerIndex 
		at: self index
		ifAbsent: [ nil ])
]

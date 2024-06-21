Class {
	#name : #GtVmReportVmParameter,
	#superclass : #GtVmReportParameter,
	#instVars : [
		'index'
	],
	#category : #'GToolkit-Utility-SpaceTally'
}

{ #category : #serialization }
GtVmReportVmParameter class >> leJsonV4Name [

	^ #gtVmReportVmSingleParameter
]

{ #category : #accessing }
GtVmReportVmParameter class >> parameterSpecificationsPerIndex [
	^ ({
		1  -> (GtVmReportParameterSpecification labeled: 'Old space size')
					beMemoryComparableConfig.
		2  -> (GtVmReportParameterSpecification labeled: 'New space size')
					beMemoryComparableConfig.
		3  -> (GtVmReportParameterSpecification labeled: 'Heap size')
					beMemoryComparableConfig.
		4  -> (GtVmReportParameterSpecification labeled: '<not used>')
					beGenericFixedValue.
		5  -> (GtVmReportParameterSpecification labeled: '<not used>')
					beGenericFixedValue.
		6  -> (GtVmReportParameterSpecification labeled: 'Survivor count treshold')
					beGenericFixedValue. 
		7  -> (GtVmReportParameterSpecification labeled: 'Full GGc count')
					beNumericalComparableConfig.
		8  -> (GtVmReportParameterSpecification labeled: 'Full GCs duration')
					beMillisecondsDurationComparableConfig.
		9  -> (GtVmReportParameterSpecification labeled: 'Scavanges count')
					beNumericalComparableConfig.
		10 -> (GtVmReportParameterSpecification labeled: 'Scavanges duration')
					beMillisecondsDurationComparableConfig.
		11 -> (GtVmReportParameterSpecification labeled: 'Tenures count')
					beNumericalComparableConfig.
		12 -> (GtVmReportParameterSpecification labeled: '<not used>')
					beGenericFixedValue.
		16 -> (GtVmReportParameterSpecification  labeled: 'Milliseconds at idle')
					beMicrosecondsDurationComparableConfig.
		17 -> (GtVmReportParameterSpecification labeled: 'Fraction of code zone')
					beGenericFixedValue.
		18 -> (GtVmReportParameterSpecification labeled: 'Full GG compaction duration')
					beMillisecondsDurationComparableConfig.
		19 -> (GtVmReportParameterSpecification labeled: 'Scavange threshold')
					beGenericFixedValue.
		20 -> (GtVmReportParameterSpecification labeled: 'Time at startup')
					beGenericFixedValue.
		21 -> (GtVmReportParameterSpecification labeled: 'Root table size')
					beNumericalComparableConfig.
		22 -> (GtVmReportParameterSpecification  labeled: 'Root table overflows')
					beNumericalComparableConfig.
		23 -> (GtVmReportParameterSpecification  labeled: 'Extra VM buffers size')
					beMemoryComparableConfig.
		24 -> (GtVmReportParameterSpecification labeled: 'Memory shrinking threshold')
					beMemoryComparableConfig.
		25 -> (GtVmReportParameterSpecification labeled: 'Memory headroom')
					beMemoryComparableConfig.
		26 -> (GtVmReportParameterSpecification labeled: 'InterruptChecksEveryNms')
					beNumericalComparableConfig.
		27 -> (GtVmReportParameterSpecification labeled: 'Mark loop iterations')
					beNumericalComparableConfig.
		28 -> (GtVmReportParameterSpecification labeled: 'Sweep loop iterations')
					beNumericalComparableConfig.
		29 -> (GtVmReportParameterSpecification labeled: 'Make Forward loop iterations')
					beNumericalComparableConfig.
		30 -> (GtVmReportParameterSpecification  labeled: 'Compact Move loop iterations')
					beNumericalComparableConfig.
		31 -> (GtVmReportParameterSpecification labeled: 'Grow memory requests')
					beNumericalComparableConfig.
		32 -> (GtVmReportParameterSpecification labeled: 'Shring memory requests')
					beNumericalComparableConfig.
		33 -> (GtVmReportParameterSpecification labeled: 'Root Table entries')
					beNumericalComparableConfig.
		34 -> (GtVmReportParameterSpecification labeled: 'Allocated memory since startup')
					beMemoryComparableConfig.
		35 -> (GtVmReportParameterSpecification labeled: 'Survivor objects count')
					beNumericalComparableConfig.
		36 -> (GtVmReportParameterSpecification labeled: 'IGF/FGC completion milliseconds clock')
					beGenericFixedValue.
		37 -> (GtVmReportParameterSpecification labeled: 'Marked objects for roots')
					beNumericalComparableConfig.
		38 -> (GtVmReportParameterSpecification labeled: 'Current IGC milliseconds')
					beGenericFixedValue.
		39 -> (GtVmReportParameterSpecification labeled: 'Finalization signals')
					beNumericalComparableConfig.
		40 -> (GtVmReportParameterSpecification labeled: 'Bytes per oop')
					beGenericFixedValue.
		41 -> (GtVmReportParameterSpecification labeled: 'Image format version')
					beGenericFixedValue.
		42 -> (GtVmReportParameterSpecification labeled: 'Used stack pages')
					beGenericFixedValue.
		43 -> (GtVmReportParameterSpecification labeled: 'Desired stack pages')
					beGenericFixedValue.
		44 -> (GtVmReportParameterSpecification labeled: 'Eden size')
					beMemoryFixedValue.
		45 -> (GtVmReportParameterSpecification labeled: 'Desired new space size')
					beMemoryFixedValue.
		46 -> (GtVmReportParameterSpecification labeled: 'Machine code size')
					beMemoryFixedValue.
		47 -> (GtVmReportParameterSpecification labeled: 'Desired machine code size')
					beMemoryFixedValue.
		48 -> (GtVmReportParameterSpecification labeled: 'Header flags')
					beGenericFixedValue.
		49 -> (GtVmReportParameterSpecification labeled: 'Max external semaphore table size')
					beGenericFixedValue.
		50 -> (GtVmReportParameterSpecification labeled: '<not used>')
					beGenericFixedValue.
		51 -> (GtVmReportParameterSpecification labeled: '<not used>')
					beGenericFixedValue.
		52 -> (GtVmReportParameterSpecification labeled: 'Root table capacity')
					beNumericalComparableConfig.
		53 -> (GtVmReportParameterSpecification labeled: 'Segments count')
					beNumericalComparableConfig.
		54 -> (GtVmReportParameterSpecification labeled: 'Free old space size')
					beMemoryComparableConfig.
		55 -> (GtVmReportParameterSpecification labeled: 'Growth ratio')
					beGenericFixedValue.
		56 -> (GtVmReportParameterSpecification labeled: 'Process switches')
					beNumericalComparableConfig.
		57 -> (GtVmReportParameterSpecification labeled: 'IO process events')
					beNumericalComparableConfig.
		58 -> (GtVmReportParameterSpecification labeled: 'Force interrupt checks')
					beNumericalComparableConfig.
		59 -> (GtVmReportParameterSpecification labeled: 'Check event calls')
					beNumericalComparableConfig.
		60 -> (GtVmReportParameterSpecification labeled: 'Stack page overflows')
					beNumericalComparableConfig.
		61 -> (GtVmReportParameterSpecification labeled: 'Stack page divorces')
					beNumericalComparableConfig.
		62 -> (GtVmReportParameterSpecification labeled: 'Compiled code compactions count')
					beNumericalComparableConfig.
		63 -> (GtVmReportParameterSpecification labeled: 'Compiled code compactions duration')
					beMillisecondsDurationComparableConfig.
		64 -> (GtVmReportParameterSpecification labeled: 'Currently jitted methods')
					beNumericalComparableConfig.
		65 -> (GtVmReportParameterSpecification labeled: 'VM features flag')
					beGenericFixedValue.
		66 -> (GtVmReportParameterSpecification labeled: 'Stack page size')
					beMemoryFixedValue.
		67 -> (GtVmReportParameterSpecification labeled: 'Old space max allowed size')
					beMemoryFixedValue.
		68 -> (GtVmReportParameterSpecification labeled: 'Average live page scans by GC')
					beNumericalComparableConfig.
		69 -> (GtVmReportParameterSpecification labeled: 'Maximum live page scans by GC')
					beGenericFixedValue.
		70 -> (GtVmReportParameterSpecification labeled: 'VM proxy major version')
					beGenericFixedValue.
		71 -> (GtVmReportParameterSpecification labeled: 'VM proxy minor version')
					beGenericFixedValue.
		72 -> (GtVmReportParameterSpecification labeled: 'GC mark total duration')
					beMillisecondsDurationComparableConfig.
		73 -> (GtVmReportParameterSpecification labeled: 'GC sweep total duration')
					beMillisecondsDurationComparableConfig.
		74 -> (GtVmReportParameterSpecification labeled: 'Segment allocation maximum pause')
					beGenericFixedValue.
		75 -> (GtVmReportParameterSpecification labeled: 'JIT compiled methods total count')
					beNumericalComparableConfig.
		76 -> (GtVmReportParameterSpecification labeled: 'JIT compiled methods total duration')
					beMillisecondsDurationComparableConfig.
		77 -> (GtVmReportParameterSpecification labeled: 'JIT compiled blocks total count')
					beNumericalComparableConfig.
		78 -> (GtVmReportParameterSpecification labeled: 'JIT compiled blocks total duration')
					beMillisecondsDurationComparableConfig.
		79 -> (GtVmReportParameterSpecification labeled: 'Image version')
					beGenericFixedValue.
		}) asOrderedDictionary
		
]

{ #category : #printing }
GtVmReportVmParameter >> descriptionOn: aStream [
	aStream 
		<< '#';
		print: index;
		<< ': '.
	
	super descriptionOn: aStream
]

{ #category : #accessing }
GtVmReportVmParameter >> formattedParameterValue [
	^ self parameterSpecification 
		ifNil: [ self parameterValue printString ] 
		ifNotNil: [ :aFormatter | 
			aFormatter formatValue: self parameterValue]
]

{ #category : #accessing }
GtVmReportVmParameter >> index [
	^ index
]

{ #category : #accessing }
GtVmReportVmParameter >> index: anInteger [
	index := anInteger
]

{ #category : #accessing }
GtVmReportVmParameter >> label [
	^ self parameterSpecification 
		ifNil: [''] 
		ifNotNil: [ :aFormatter |
			aFormatter label ifNil: [ '' ] ]
]

{ #category : #accessing }
GtVmReportVmParameter >> parameterDetails [
	^ {'Index' -> self index}, super parameterDetails
]

{ #category : #accessing }
GtVmReportVmParameter >> parameterSpecification [
	^ (self class parameterSpecificationsPerIndex 
		at: self index
		ifAbsent: [ nil ])
]

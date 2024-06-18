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
		1  -> GtVmReportMemoryParameterFormatter.
		2  -> GtVmReportMemoryParameterFormatter.
		3  -> GtVmReportMemoryParameterFormatter.
		4  -> GtVmReportFixedParameterFormatter.
		5  -> GtVmReportFixedParameterFormatter.
		6  -> GtVmReportFixedParameterFormatter.
		7  -> GtVmReportCountParameterFormatter.
		8  -> GtVmReportMillisecondsDurationParameterFormatter.
		9  -> GtVmReportCountParameterFormatter.
		10 -> GtVmReportMillisecondsDurationParameterFormatter.
		11  -> GtVmReportCountParameterFormatter.
		12  -> GtVmReportFixedParameterFormatter.
		16 -> GtVmReportMicrosecondsDurationParameterFormatter.
		17  -> GtVmReportFixedParameterFormatter.
		18 -> GtVmReportMillisecondsDurationParameterFormatter.
		19  -> GtVmReportFixedParameterFormatter.
		20  -> nil.
		21  -> GtVmReportCountParameterFormatter.
		22  -> GtVmReportCountParameterFormatter.
		23  -> GtVmReportMemoryParameterFormatter.
		24  -> GtVmReportMemoryParameterFormatter.
		25  -> GtVmReportMemoryParameterFormatter.
		26  -> GtVmReportCountParameterFormatter.
		27  -> GtVmReportCountParameterFormatter.
		28  -> GtVmReportCountParameterFormatter.
		29  -> GtVmReportCountParameterFormatter.
		30  -> GtVmReportCountParameterFormatter.
		31  -> GtVmReportCountParameterFormatter.
		32  -> GtVmReportCountParameterFormatter.
		33  -> GtVmReportCountParameterFormatter.
		34  -> GtVmReportMemoryParameterFormatter.
		35  -> GtVmReportCountParameterFormatter.
		36  -> nil.
		37  -> GtVmReportCountParameterFormatter.
		38  -> nil.
		39  -> GtVmReportCountParameterFormatter.
		40  -> GtVmReportFixedParameterFormatter.
		41  -> GtVmReportFixedParameterFormatter.
		42  -> GtVmReportFixedParameterFormatter.
		43  -> GtVmReportFixedParameterFormatter.
		44  -> GtVmReportFixedMemoryParameterFormatter.
		45  -> GtVmReportFixedMemoryParameterFormatter.
		46  -> GtVmReportFixedMemoryParameterFormatter.
		47  -> GtVmReportFixedParameterFormatter.
		48  -> GtVmReportFixedParameterFormatter.
		49  -> GtVmReportFixedParameterFormatter.
		50  -> GtVmReportFixedParameterFormatter.
		51  -> GtVmReportFixedParameterFormatter.
		52  -> GtVmReportCountParameterFormatter.
		53  -> GtVmReportCountParameterFormatter.
		54  -> GtVmReportMemoryParameterFormatter.
		55  -> GtVmReportFixedParameterFormatter.
		56  -> GtVmReportCountParameterFormatter.
		57  -> GtVmReportCountParameterFormatter.
		58  -> GtVmReportCountParameterFormatter.
		59  -> GtVmReportCountParameterFormatter.
		60  -> GtVmReportCountParameterFormatter.
		61  -> GtVmReportCountParameterFormatter.
		62  -> GtVmReportCountParameterFormatter.
		63 -> GtVmReportMillisecondsDurationParameterFormatter.
		64  -> GtVmReportCountParameterFormatter.
		65  -> GtVmReportFixedParameterFormatter.
		66  -> GtVmReportFixedMemoryParameterFormatter.
		67  -> GtVmReportFixedMemoryParameterFormatter.
		68  -> GtVmReportCountParameterFormatter.
		69  -> GtVmReportFixedParameterFormatter.
		70  -> GtVmReportFixedParameterFormatter.
		71  -> GtVmReportFixedParameterFormatter.
		72 -> GtVmReportMillisecondsDurationParameterFormatter.
		73 -> GtVmReportMillisecondsDurationParameterFormatter.
		74 -> nil.
		75  -> GtVmReportCountParameterFormatter.
		76 -> GtVmReportMillisecondsDurationParameterFormatter.
		77  -> GtVmReportCountParameterFormatter.
		78  -> GtVmReportMillisecondsDurationParameterFormatter.
		79  -> GtVmReportFixedParameterFormatter.
		} collect: [ :assoc | assoc key -> (assoc value 	ifNotNil: [:aClass | aClass new ])]) asOrderedDictionary
		
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
GtVmReportVmSingleParameter >> parameterFormater [
	^ (self class parameterFormattersPerIndex 
		at: self index
		ifAbsent: [ nil ])
]

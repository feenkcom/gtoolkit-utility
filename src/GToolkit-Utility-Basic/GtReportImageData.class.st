Class {
	#name : #GtReportImageData,
	#superclass : #Object,
	#instVars : [
		'gtVersion',
		'gtReleaseTimestamp',
		'gtVmVersion',
		'pharoVmVersion',
		'pharoImageVersion'
	],
	#category : #'GToolkit-Utility-Basic'
}

{ #category : #'instance creation' }
GtReportImageData class >> current [
	^ self new recordCurrentValues

]

{ #category : #serialization }
GtReportImageData class >> leJsonV4Name [
	^ #gtReportImageData

]

{ #category : #accessing }
GtReportImageData >> gtReleaseTimestamp [
	^ gtReleaseTimestamp

]

{ #category : #accessing }
GtReportImageData >> gtReleaseTimestamp: aString [
	gtReleaseTimestamp := aString

]

{ #category : #'gt - extensions' }
GtReportImageData >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ self summaryAttributes ];
		column: 'Attribute' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]

]

{ #category : #accessing }
GtReportImageData >> gtVersion [
	^ gtVersion

]

{ #category : #accessing }
GtReportImageData >> gtVersion: aString [
	gtVersion := aString

]

{ #category : #accessing }
GtReportImageData >> gtVmVersion [
	^ gtVmVersion

]

{ #category : #accessing }
GtReportImageData >> gtVmVersion: aString [
	gtVmVersion := aString

]

{ #category : #initialization }
GtReportImageData >> initialize [
	super initialize.
	gtVersion := ''.
	gtReleaseTimestamp := ''.
	gtVmVersion := ''.
	pharoVmVersion := ''.
	pharoImageVersion := ''

]

{ #category : #accessing }
GtReportImageData >> pharoImageVersion [
	^ pharoImageVersion

]

{ #category : #accessing }
GtReportImageData >> pharoImageVersion: aString [
	pharoImageVersion := aString

]

{ #category : #accessing }
GtReportImageData >> pharoVmVersion [
	^ pharoVmVersion

]

{ #category : #accessing }
GtReportImageData >> pharoVmVersion: aString [
	pharoVmVersion := aString

]

{ #category : #printing }
GtReportImageData >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream
			nextPutAll: 'GT ';
			nextPutAll: gtVersion;
			nextPutAll: ', VM ';
			nextPutAll: gtVmVersion ]

]

{ #category : #initialization }
GtReportImageData >> recordCurrentValues [
	gtVersion := self valueOf: [ GtImage instance version versionString ].
	gtReleaseTimestamp := self valueOf: [ GtImage instance timestamp printString ].
	gtVmVersion := self valueOf: [ GtVirtualMachine new bundleVersion ].
	pharoVmVersion := self valueOf: [
		((STONJSON fromString: GtVirtualMachine new primitiveVirtualMachineInfo)
			at: 'build_info') at: 'version' ].
	pharoImageVersion := self valueOf: [ SystemVersion current imageVersionString ]

]

{ #category : #accessing }
GtReportImageData >> summaryAttributes [
	^ OrderedCollection new
		add: 'GT version' -> gtVersion;
		add: 'GT release timestamp' -> gtReleaseTimestamp;
		add: 'GT VM version' -> gtVmVersion;
		add: 'Pharo VM version' -> pharoVmVersion;
		add: 'Pharo image version' -> pharoImageVersion;
		yourself

]

{ #category : #private }
GtReportImageData >> valueOf: aBlock [
	^ aBlock on: Error do: [ :anError | 'unknown (' , anError messageText , ')' ]

]

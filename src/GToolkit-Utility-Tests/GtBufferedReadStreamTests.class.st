"
This class contains tests


"
Class {
	#name : #GtBufferedReadStreamTests,
	#superclass : #TestCase,
	#category : #'GToolkit-Utility-Tests'
}

{ #category : #testing }
GtBufferedReadStreamTests class >> shouldInheritSelectors [

	^true
]

{ #category : #tests }
GtBufferedReadStreamTests >> testSavingPositionDo [
	| data stream |
	data := String new: 200 streamContents: [ :out | 
		200 timesRepeat: [ out nextPut: 'abc' atRandom ] ].
	stream := GtBufferedReadStream on: data readStream.
	self deny: stream atEnd.
	self assert: stream position isZero.
	stream savingPositionDo: [
		self assert: stream upToEnd equals: data.
		self assert: stream atEnd.
		self assert: stream position equals: 200 ].
	self deny: stream atEnd.
	self assert: stream position isZero.
	self assert: stream upToEnd equals: data.
	self assert: stream atEnd.
	self assert: stream position equals: 200
]

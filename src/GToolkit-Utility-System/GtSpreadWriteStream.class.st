"
I am a write stream.
I write an output to several streams.
I am used by {{gtClass:GtSubprocessWithStreamOutput}}. 
"
Class {
	#name : #GtSpreadWriteStream,
	#superclass : #Object,
	#instVars : [
		'streams'
	],
	#category : #'GToolkit-Utility-System'
}

{ #category : #'instance creation' }
GtSpreadWriteStream class >> inMemoryAnd: aStream [
	^ self new streams: {String new writeStream. aStream}
]

{ #category : #accessing }
GtSpreadWriteStream >> contents [
	self streamsDo: [ :each | 
		(each respondsTo: #contents) 
			ifTrue: [ ^ each contents ] ].
	^ nil
]

{ #category : #streaming }
GtSpreadWriteStream >> nextPut: anObject [
	self streamsDo: [ :each | each nextPut: anObject ]
]

{ #category : #streaming }
GtSpreadWriteStream >> nextPutAll: aCollection [
	self streamsDo: [ :each | each nextPutAll: aCollection ]
]

{ #category : #accessing }
GtSpreadWriteStream >> streams [
	^ streams
]

{ #category : #accessing }
GtSpreadWriteStream >> streams: anObject [
	streams := anObject
]

{ #category : #private }
GtSpreadWriteStream >> streamsDo: aBlock [
	streams ifNil: [ ^ self ].
	streams do: aBlock
]

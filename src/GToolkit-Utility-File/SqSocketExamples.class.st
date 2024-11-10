Class {
	#name : #SqSocketExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'server',
		'client'
	],
	#category : #'GToolkit-Utility-File-Examples'
}

{ #category : #examples }
SqSocketExamples >> closeOnExec [
	"Check that closeOnExec is set by default in sockets,
	and that it can be cleared"
	<gtExample>
	<after: #closeSockets>
	server := Socket newTCP
		listenOn: 0
		backlogSize: 4
		interface: NetNameResolver loopBackAddress.
	client := Socket newTCP
		connectTo: NetNameResolver loopBackAddress
		port: server port.
	self assert: client closeOnExec
		description: 'Socket closeOnExec not set'.
	client closeOnExec: false.
	self deny: client closeOnExec
		description: 'Socket closeOnExec set'.
]

{ #category : #'private - helpers' }
SqSocketExamples >> closeSockets [

	client ifNotNil:
		[ client closeAndDestroy ].
	server ifNotNil:
		[ server closeAndDestroy ].
]

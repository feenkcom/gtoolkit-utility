"
A set of utilities.


"
Class {
	#name : #BaselineOfGToolkitUtility,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfGToolkitUtility
}

{ #category : #initialization }
BaselineOfGToolkitUtility class >> firstRunAfterSave [

	self postLoadExternalAddressChanges.
	SessionManager default unregisterClassNamed: self name.
]

{ #category : #initialization }
BaselineOfGToolkitUtility class >> postLoadExternalAddressChanges [

	ExternalAddress compile:
'copyFrom: startIndex to: endIndex
	"Answer a ByteArray containing the receiver''s contents from startIndex to endIndex"
	| result size |

	size := endIndex - startIndex + 1.
	result := ByteArray new: size.
	self 
		primitiveCopyFrom: self
		at: startIndex
		to: result
		at: 1
		size: size.
	^ result'
		classified: 'gt-extensions'.

	ExternalAddress compile:
'replaceFrom: start to: stop with: replacement startingAt: repStart
	"Replace the bytes in the receiver from start to stop with those from replacement, starting at repStart"
	| repSize |

	repSize := stop - start + 1.
	self
		primitiveCopyFrom: replacement
		at: repStart
		to: self
		at: start
		size: repSize.'
	classified: 'gt-extensions'.

	LibC compile:
'memCopy: src to: dest size: n
	"Copy n bytes from the src to the dest.
	Uses primitiveCopyFromAtToAtSize to minimise the need to pin objects in old space (which can be very slow).
	If you don''t need to pin dest, using the copy methods in ByteArray and ExternalAddress will be more efficient."

	ByteArray
		primitiveCopyFrom: src gtMemcpyAddress
		at: 1
		to: dest gtMemcpyAddress
		at: 1
		size: n.
	^ dest tfPointerAddress'
	classified: 'gt-extensions'.
]

{ #category : #accessing }
BaselineOfGToolkitUtility class >> startUp: resuming [

	resuming ifTrue:
	  [ self firstRunAfterSave ].
]

{ #category : #baseline }
BaselineOfGToolkitUtility >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec postLoadDoIt: #postLoadChanges:.
		spec 
			baseline: 'GToolkitAnnouncerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitBasicUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitAssertionUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitFileUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
			baseline: 'GToolkitSessionManagerUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ].
		spec 
			package: 'GToolkit-Utility-MessageTally';
			package: 'GToolkit-Utility-SpaceTally';
			package: 'GToolkit-Utility-StackOverflow';
			package: 'GToolkit-Utility-Streams';
			package: 'GToolkit-Utility-Tests' with: [
				spec requires: #('GToolkitFileUtility' ). ];
			package: 'GToolkit-Utility-Logging'  with: [
				spec requires: #('GToolkitFileUtility' ). ];
			package: 'GToolkit-Utility-Properties';
			package: 'GToolkit-Utility-ClassLoader';
			package: 'GToolkit-Utility-UndeclaredReferences';
			package: 'GToolkit-Utility-Git';
			package: 'GToolkit-Utility-GitHub';
			package: 'GToolkit-Utility-ExtensionMethodsAnalysis';
			package: 'GToolkit-Utility-Deprecation';
			package: 'GToolkit-Utility-Algorithms';
			package: 'GToolkit-Utility-RB';
			package: 'GToolkit-Utility-ProcessAnalysis';			
			package: 'GToolkit-Releaser-Logging-Analysis' with: [
				spec requires: #('GToolkit-Utility-Logging' ). ];
			package: 'GToolkit-Utility-ObjectConnections';
			package: 'GToolkit-Utility-Network' ].
]

{ #category : #accessing }
BaselineOfGToolkitUtility >> postLoadChanges: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].
		
	PostLoaded := true.
	SessionManager default
		registerUserClassNamed: self class name.
]

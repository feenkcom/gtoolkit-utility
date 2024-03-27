Class {
	#name : #GtNetworkNoProxySetSignal,
	#superclass : #GtNetworkProxySignal,
	#instVars : [
		'variableName',
		'variableValue',
		'exceptionsValue'
	],
	#category : #'GToolkit-Utility-Network'
}

{ #category : #accessing }
GtNetworkNoProxySetSignal >> exceptionsValue [
	^ exceptionsValue
]

{ #category : #accessing }
GtNetworkNoProxySetSignal >> exceptionsValue: anObject [
	exceptionsValue := anObject
]

{ #category : #printing }
GtNetworkNoProxySetSignal >> printOneLineContentsOn: stream [
	stream
		nextPutAll: self variableName asString;
		nextPut: $=;
		nextPutAll: self variableValue asString
]

{ #category : #accessing }
GtNetworkNoProxySetSignal >> variableName [
	^ variableName
]

{ #category : #accessing }
GtNetworkNoProxySetSignal >> variableName: anObject [
	variableName := anObject
]

{ #category : #accessing }
GtNetworkNoProxySetSignal >> variableValue [
	^ variableValue
]

{ #category : #accessing }
GtNetworkNoProxySetSignal >> variableValue: anObject [
	variableValue := anObject
]

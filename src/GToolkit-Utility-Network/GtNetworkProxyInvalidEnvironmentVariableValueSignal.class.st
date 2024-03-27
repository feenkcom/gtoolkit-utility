Class {
	#name : #GtNetworkProxyInvalidEnvironmentVariableValueSignal,
	#superclass : #GtNetworkProxySignal,
	#instVars : [
		'exception',
		'variableName',
		'variableValue'
	],
	#category : #'GToolkit-Utility-Network'
}

{ #category : #accessing }
GtNetworkProxyInvalidEnvironmentVariableValueSignal >> exception [
	^ exception
]

{ #category : #accessing }
GtNetworkProxyInvalidEnvironmentVariableValueSignal >> exception: anObject [
	exception := anObject
]

{ #category : #printing }
GtNetworkProxyInvalidEnvironmentVariableValueSignal >> printOneLineContentsOn: stream [
	stream
		nextPutAll: self variableName asString;
		nextPut: $=;
		nextPutAll: self variableValue asString;
		nextPutAll: ', ';
		print: self exception
]

{ #category : #accessing }
GtNetworkProxyInvalidEnvironmentVariableValueSignal >> variableName [
	^ variableName
]

{ #category : #accessing }
GtNetworkProxyInvalidEnvironmentVariableValueSignal >> variableName: anObject [
	variableName := anObject
]

{ #category : #accessing }
GtNetworkProxyInvalidEnvironmentVariableValueSignal >> variableValue [
	^ variableValue
]

{ #category : #accessing }
GtNetworkProxyInvalidEnvironmentVariableValueSignal >> variableValue: anObject [
	variableValue := anObject
]

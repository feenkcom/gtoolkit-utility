Class {
	#name : #GtNetworkProxyUndefinedEnvironmentVariableSignal,
	#superclass : #GtNetworkProxySignal,
	#instVars : [
		'variableName'
	],
	#category : #'GToolkit-Utility-Network'
}

{ #category : #printing }
GtNetworkProxyUndefinedEnvironmentVariableSignal >> printOneLineContentsOn: stream [
	stream nextPutAll: self variableName asString
]

{ #category : #accessing }
GtNetworkProxyUndefinedEnvironmentVariableSignal >> variableName [
	<return: #String>
	^ variableName
]

{ #category : #accessing }
GtNetworkProxyUndefinedEnvironmentVariableSignal >> variableName: aString [
	variableName := aString
]

Class {
	#name : #GtNetworkProxySetSignal,
	#superclass : #GtNetworkProxySignal,
	#instVars : [
		'variableName',
		'variableValue',
		'proxyUrl',
		'proxyPort',
		'proxyServer'
	],
	#category : #'GToolkit-Utility-Network'
}

{ #category : #printing }
GtNetworkProxySetSignal >> printOneLineContentsOn: stream [
	stream
		nextPutAll: self variableName asString;
		nextPut: $=;
		nextPutAll: self variableValue asString
]

{ #category : #accessing }
GtNetworkProxySetSignal >> proxyPort [
	^ proxyPort
]

{ #category : #accessing }
GtNetworkProxySetSignal >> proxyPort: anObject [
	proxyPort := anObject
]

{ #category : #accessing }
GtNetworkProxySetSignal >> proxyServer [
	^ proxyServer
]

{ #category : #accessing }
GtNetworkProxySetSignal >> proxyServer: anObject [
	proxyServer := anObject
]

{ #category : #accessing }
GtNetworkProxySetSignal >> proxyUrl [
	^ proxyUrl
]

{ #category : #accessing }
GtNetworkProxySetSignal >> proxyUrl: anObject [
	proxyUrl := anObject
]

{ #category : #accessing }
GtNetworkProxySetSignal >> variableName [
	^ variableName
]

{ #category : #accessing }
GtNetworkProxySetSignal >> variableName: anObject [
	variableName := anObject
]

{ #category : #accessing }
GtNetworkProxySetSignal >> variableValue [
	^ variableValue
]

{ #category : #accessing }
GtNetworkProxySetSignal >> variableValue: anObject [
	variableValue := anObject
]

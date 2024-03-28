"
I configure {{gtClass:NetworkSystemSettings}} based on OS environment variables.
I configure it on {{gtMethod:GtAutomaticNetworkProxySetter class >>startUp: | label=startup}}.
Possible proxy environment variables are: {{gtExample: GtAutomaticNetworkProxySetter>>#itself | noCode | previewShow=#gtProxyVariablesFor: | previewHeight=150}}
Possible no-proxy environment variables are:  {{gtExample: GtAutomaticNetworkProxySetter>>#itself | noCode | previewShow=#gtNoProxyVariablesFor: | previewHeight=100}}

"
Class {
	#name : #GtAutomaticNetworkProxySetter,
	#superclass : #Object,
	#classVars : [
		'IsAutomaticSetupEnabled'
	],
	#category : #'GToolkit-Utility-Network'
}

{ #category : #configuration }
GtAutomaticNetworkProxySetter class >> disable [
	IsAutomaticSetupEnabled := false
]

{ #category : #configuration }
GtAutomaticNetworkProxySetter class >> enable [
	IsAutomaticSetupEnabled := true
]

{ #category : #initialization }
GtAutomaticNetworkProxySetter class >> initialize [
	"Get notified on session starts so the network proxy can be set"

	SessionManager default registerUserClassNamed: self name
]

{ #category : #testing }
GtAutomaticNetworkProxySetter class >> isEnabled [
	^ IsAutomaticSetupEnabled ifNil: [ true ]
]

{ #category : #accessing }
GtAutomaticNetworkProxySetter class >> noProxyVariablePragmas [
	^ Pragma
		allNamed: #noProxyVariables:
		from: self
		to: GtAutomaticNetworkProxySetter
		sortedByArgument: 1
]

{ #category : #accessing }
GtAutomaticNetworkProxySetter class >> proxyVariablePragmas [
	^ Pragma
		allNamed: #proxyVariables:
		from: self
		to: GtAutomaticNetworkProxySetter
		sortedByArgument: 1
]

{ #category : #configuring }
GtAutomaticNetworkProxySetter class >> set [
	self new set
]

{ #category : #configuring }
GtAutomaticNetworkProxySetter class >> setIfEnabled [
	self new setIfEnabled
]

{ #category : #'system startup' }
GtAutomaticNetworkProxySetter class >> startUp: resuming [
	resuming ifFalse: [ ^ self ].
	self set
]

{ #category : #variables }
GtAutomaticNetworkProxySetter >> httpProxyVariables [
	<proxyVariables: 15>
	^ #('HTTP_PROXY' 'http_proxy')
]

{ #category : #variables }
GtAutomaticNetworkProxySetter >> httpsProxyVariables [
	<proxyVariables: 10>
	^ #('HTTPS_PROXY' 'https_proxy')
]

{ #category : #testing }
GtAutomaticNetworkProxySetter >> isEnabled [
	^ self class isEnabled
]

{ #category : #example }
GtAutomaticNetworkProxySetter >> itself [
	<gtExample>
	| isProxyEmpty isNoProxyEmpty |
	isProxyEmpty := isNoProxyEmpty := true.
	self proxyVariableNamesDo: [ :aName | isProxyEmpty := false ].
	self noProxyVariableNamesDo: [ :aName | isNoProxyEmpty := false ].

	self
		assert: isProxyEmpty not
		description: [ 'Possible proxy variable names are missing' ].
	self
		assert: isProxyEmpty not
		description: [ 'Possible no-proxy variable names are missing' ].

	^ self
]

{ #category : #building }
GtAutomaticNetworkProxySetter >> noProxyVariableNamesDo: aBlock [
	"Iterate over all possible environment variable names."

	self noProxyVariablePragmas
		do: [ :aPragma | 
			| aCollection |
			aCollection := self perform: aPragma methodSelector.
			aCollection do: [ :aVariableName | 
				aBlock cull: aVariableName cull: aPragma ] ]
]

{ #category : #accessing }
GtAutomaticNetworkProxySetter >> noProxyVariablePragmas [
	^ self class noProxyVariablePragmas
]

{ #category : #variables }
GtAutomaticNetworkProxySetter >> noProxyVariables [
	<noProxyVariables: 10>
	^ #('NO_PROXY' 'no_proxy')
]

{ #category : #building }
GtAutomaticNetworkProxySetter >> proxyVariableNamesDo: aBlock [
	"Iterate over all possible environment variable names."

	self proxyVariablePragmas
		do: [ :aPragma | 
			| aCollection |
			aCollection := self perform: aPragma methodSelector.
			aCollection do: [ :aVariableName | 
				aBlock cull: aVariableName cull: aPragma ] ]
]

{ #category : #accessing }
GtAutomaticNetworkProxySetter >> proxyVariablePragmas [
	^ self class proxyVariablePragmas
]

{ #category : #configuring }
GtAutomaticNetworkProxySetter >> set [
	self setProxy.
	self setNoProxy
]

{ #category : #configuring }
GtAutomaticNetworkProxySetter >> setIfEnabled [
	self isEnabled ifFalse: [ ^ self ].
	self set
]

{ #category : #configuring }
GtAutomaticNetworkProxySetter >> setNoProxy [
	self noProxyVariableNamesDo: [ :aName | 
		(self setNoProxyUsingVariableNamed: aName) ifTrue: [ ^ self ] ]
]

{ #category : #building }
GtAutomaticNetworkProxySetter >> setNoProxyUsingVariableNamed: aName [
	"If environment variable exists, set network proxy exceptions and return true. If the environment variable does not exist, return false."

	<return: #Boolean>
	| aValue anAdoptedValue |
	aValue := Smalltalk os environment
			at: aName
			ifAbsent: [ 
				GtNetworkProxyUndefinedEnvironmentVariableSignal new
					variableName: aName;
					emit.
				^ false ].

	anAdoptedValue := [ aValue copyReplaceAll: ',' with: ';' ]
			on: Error
			do: [ :anException | 
				anException emit.
				GtNetworkProxyInvalidEnvironmentVariableValueSignal new
					exception: anException;
					variableName: aName;
					variableValue: aValue;
					emit.
				^ false ].

	NetworkSystemSettings manageHttpProxyExceptions: anAdoptedValue.

	GtNetworkNoProxySetSignal new
		variableName: aName;
		variableValue: aValue;
		exceptionsValue: anAdoptedValue;
		emit.
	^ true
]

{ #category : #configuring }
GtAutomaticNetworkProxySetter >> setProxy [
	self proxyVariableNamesDo: [ :aName | 
		(self setProxyUsingVariableNamed: aName) ifTrue: [ ^ self ] ]
]

{ #category : #building }
GtAutomaticNetworkProxySetter >> setProxyUsingVariableNamed: aName [
	"If environment variable exists, set network proxy and return true. If the environment variable does not exist, return false."

	<return: #Boolean>
	| aValue anUrl |
	aValue := Smalltalk os environment
			at: aName
			ifAbsent: [ 
				GtNetworkProxyUndefinedEnvironmentVariableSignal new
					variableName: aName;
					emit.
				^ false ].

	anUrl := [ aValue asZnUrl ]
			on: Error
			do: [ :anException | 
				anException emit.
				GtNetworkProxyInvalidEnvironmentVariableValueSignal new
					exception: anException;
					variableName: aName;
					variableValue: aValue;
					emit.
				^ false ].

	NetworkSystemSettings
		useHTTPProxy: true;
		httpProxyPort: anUrl port;
		httpProxyServer: anUrl host.
		
	GtNetworkProxySetSignal new
		variableName: aName;
		variableValue: aValue;
		proxyUrl: anUrl;
		proxyPort: anUrl port;
		proxyServer: anUrl host;
		emit.
	^ true
]

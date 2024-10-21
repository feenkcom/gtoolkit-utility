"
{{gtClass:GtExtensionMethodsBaseImageOverridesReportBuilder}} provides an overview of extension methods that change  or override methods from a reference image. 

To perform this:
	- it detects all extensions methods added by a project using {{gtClass:GtExtensionMethodsProjectBuilder}}
	- it checks if any of those methods replaces or overrides a method in a reference image
"
Class {
	#name : #GtExtensionMethodsBaseImageOverridesReportBuilder,
	#superclass : #Object,
	#instVars : [
		'imageName',
		'imageUrl',
		'imageArchiveName'
	],
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

{ #category : #analysis }
GtExtensionMethodsBaseImageOverridesReportBuilder class >> forGToolkit [
	^ self new buildReportForGToolkit
]

{ #category : #analysis }
GtExtensionMethodsBaseImageOverridesReportBuilder >> buildReportForComparisonResult: aResult forExtensionMethods: aCollection inProject: aProject [ 
	aCollection withIndexDo: [ :aMethodWrapper :anIndex |
		aMethodWrapper changeType: (aResult at: anIndex) first.
		aMethodWrapper isOverrideOrReplace ifTrue: [
			aMethodWrapper previousSourceCode: (aResult 
				at: anIndex) second  ] ].
		
	^ GtExtensionMethodsProjectBuilder new 
		buildProjectWrapperForMethodWrappers: aCollection 
		inProject: aProject
]

{ #category : #analysis }
GtExtensionMethodsBaseImageOverridesReportBuilder >> buildReportForGToolkit [
	^ self buildReportForProject: BaselineOfGToolkit fullBaselineProject
]

{ #category : #analysis }
GtExtensionMethodsBaseImageOverridesReportBuilder >> buildReportForProject: aProject [
	| wrapperProject extensionMethods analysisCode analysisResult |
	
	wrapperProject := GtExtensionMethodsProjectBuilder new 
		buildReportForProject: aProject.
	
	extensionMethods := wrapperProject extensionMethods.
	analysisCode := self detectionCodeForMethods: extensionMethods.
	
	self ensureImageDownloaded.
	analysisResult := self comparisonResultsForAnalysisCode: analysisCode.
	
	^ self 
		buildReportForComparisonResult: analysisResult
		forExtensionMethods: extensionMethods
		inProject: aProject
]

{ #category : #utils }
GtExtensionMethodsBaseImageOverridesReportBuilder >> comparisonResultsForAnalysisCode: analysisSourceCode [
	| command newProcess arguments resultString |
	
	command := GtVirtualMachine instance 
		headlessExecutable resolve fullName.
	arguments := { 
		(self targetFolder / self imageName) resolve fullName.
		'eval'.
		analysisSourceCode }.

	newProcess := GtSubprocessWithInMemoryOutput new
		command: command;
		arguments: arguments;
		workingDirectory: self targetFolder  resolve fullName;
		terminateOnShutdown;
		yourself.
	
	newProcess	
		errorBlock: [ :ex | 
			self error: 'Unable to analyse extensions' ];
		runAndWait.
	
	resultString := newProcess stdout.
	
	^ self class compiler evaluate: resultString.  
]

{ #category : #utils }
GtExtensionMethodsBaseImageOverridesReportBuilder >> detectionCodeForMethods: aCollection [
	| expensionsData |
	
	expensionsData := aCollection asArray collect: [ :aMethod |
		{ aMethod methodClass name . aMethod selector asString } ].
	
	^ String streamContents: [ :aStream |
		aStream << '| expensionsData |'; lf.
		aStream << 'expensionsData := '; << expensionsData storeString; <<'.';lf.
		aStream << ([ :data | data collect: [ :array |
			| className isMeta |
			className := array first.
		
			isMeta := false.
			(className endsWith: ' class') ifTrue: [
				className := (className withoutSuffix: ' class') asSymbol.
				isMeta := true ].
			(className endsWith: ' classTrait') ifTrue: [
				className := (className withoutSuffix: ' classTrait') asSymbol.
				isMeta := true ].
		
			Smalltalk globals  
				at: className
				ifPresent: [ :aClass | 
					| targetClass|
					targetClass := aClass.				
					isMeta ifTrue: [
						targetClass := aClass classSide ].
					targetClass 
						classAndMethodFor: array second asSymbol
						do: [ :methodClas :foundMethod | 
							targetClass = methodClas
								ifTrue: [
									{
										#isReplacingMethodInClass. 
										foundMethod sourceCode
									}]
								ifFalse: [
									{
										#isOverridingSupperclassMethod. 
										foundMethod sourceCode
									} ] ]
						ifAbsent: [ {#isNewMethod} ] ]
				ifAbsent: [ {#isMissingClass} ] ]
			] sourceNode sourceCode).
		aStream << ' value: expensionsData' ]
]

{ #category : #utils }
GtExtensionMethodsBaseImageOverridesReportBuilder >> ensureImageDownloaded [
	| targetFolder |
	targetFolder := self targetFolder.
	(targetFolder / self imageName) exists 
		ifTrue: [ ^ self ].
	
	targetFolder ensureCreateDirectory.
	ZnClient new
		url: self imageUrl;
		signalProgress: true;
		downloadTo: targetFolder.
	(ZipArchive new readFrom: targetFolder / self imageArchiveName)
		extractAllTo: targetFolder.
]

{ #category : #accessing }
GtExtensionMethodsBaseImageOverridesReportBuilder >> imageArchiveName [ 
	^ imageArchiveName ifNil: [
		'Pharo10-SNAPSHOT.build.521.sha.14f5413.arch.64bit.zip' ]
]

{ #category : #accessing }
GtExtensionMethodsBaseImageOverridesReportBuilder >> imageArchiveName: anArchiveName [
	imageArchiveName := anArchiveName
]

{ #category : #accessing }
GtExtensionMethodsBaseImageOverridesReportBuilder >> imageName [ 
	^ imageName ifNil: [
		'Pharo10-SNAPSHOT-64bit-14f5413.image' ]
]

{ #category : #accessing }
GtExtensionMethodsBaseImageOverridesReportBuilder >> imageName: anImageName [
	imageName := anImageName
]

{ #category : #accessing }
GtExtensionMethodsBaseImageOverridesReportBuilder >> imageUrl [
	^ imageUrl ifNil: [
		'https://dl.feenk.com/pharo/', self imageArchiveName ]
]

{ #category : #accessing }
GtExtensionMethodsBaseImageOverridesReportBuilder >> imageUrl: anUrlString [
	imageUrl := anUrlString
]

{ #category : #accessing }
GtExtensionMethodsBaseImageOverridesReportBuilder >> targetFolder [
	^ FileLocator localDirectory / 'analysis-extension-methods'
]

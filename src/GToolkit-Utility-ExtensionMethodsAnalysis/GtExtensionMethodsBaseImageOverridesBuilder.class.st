"
{{gtClass:GtExtensionMethodsBaseImageOverridesBuilder}} provides an overview of extension methods that change  or override methods from a reference image. 

To perform this:
	- it detects all extensions methods added by a project using {{gtClass:GtExtensionMethodsProjectBuilder}}
	- it checks if any of those methods replaces or overrides a method in a reference image
"
Class {
	#name : #GtExtensionMethodsBaseImageOverridesBuilder,
	#superclass : #Object,
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

{ #category : #analysis }
GtExtensionMethodsBaseImageOverridesBuilder class >> forGToolkit [
	^ self new 
		buildWrapperForProject: BaselineOfGToolkit fullBaselineProject
]

{ #category : #analysis }
GtExtensionMethodsBaseImageOverridesBuilder >> buildWrapperForComparisonResult: aResult forExtensionMethods: aCollection inProject: aProject [ 
	| targetMethods |
	targetMethods := aCollection withIndexSelect: [ :aMethod :anIndex |
		aResult at: anIndex ].
		
	^ GtExtensionMethodsProjectBuilder new 
		buildProjectWrapperForMethods: targetMethods 
		inProject: aProject
]

{ #category : #analysis }
GtExtensionMethodsBaseImageOverridesBuilder >> buildWrapperForProject: aProject [
	| wrapperProject extensionMethods analysisCode analysisResult |
	
	wrapperProject := GtExtensionMethodsProjectBuilder new 
		buildWrapperForProject: aProject.
	
	extensionMethods := wrapperProject extensionMethods.
	analysisCode := self detectionCodeForMethods: extensionMethods.
	
	self ensureImageDownloaded.
	analysisResult := self comparisonResultsForAnalysisCode: analysisCode.
	
	^ self 
		buildWrapperForComparisonResult: analysisResult
		forExtensionMethods: extensionMethods
		inProject: aProject
]

{ #category : #utils }
GtExtensionMethodsBaseImageOverridesBuilder >> comparisonResultsForAnalysisCode: analysisSourceCode [
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
GtExtensionMethodsBaseImageOverridesBuilder >> detectionCodeForMethods: aCollection [
	| expensionsData |
	
	expensionsData := aCollection asArray collect: [ :aMethod |
		{aMethod methodClass name . aMethod selector asString } ].
	
	^ String streamContents: [ :aStream |
		aStream << '| expensionsData |'; lf.
		aStream << 'expensionsData := '; << expensionsData storeString; <<'.';lf.
		aStream << ([ :data | data collect: [ :array |
			| className isMeta |
			className := array first.
		
			isMeta := false.
			(className endsWith: ' class') ifTrue: [
				className := className withoutSuffix: ' class'.
				isMeta := true ].
			(className endsWith: ' classTrait') ifTrue: [
				className := className withoutSuffix: ' classTrait'.
				isMeta := true ].
		
			Smalltalk globals  
				at: className
				ifPresent: [ :aClass | 
					| targetClass|
					targetClass := aClass.				
					isMeta ifTrue: [
						targetClass := aClass classSide ].
					(targetClass canUnderstand: array second asSymbol) ]
				ifAbsent: [ false ] ]
			] sourceNode sourceCode).
		aStream << ' value: expensionsData' ]
]

{ #category : #utils }
GtExtensionMethodsBaseImageOverridesBuilder >> ensureImageDownloaded [
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
GtExtensionMethodsBaseImageOverridesBuilder >> imageArchiveName [ 
	^ 'Pharo10-SNAPSHOT.build.521.sha.14f5413.arch.64bit.zip'.
]

{ #category : #accessing }
GtExtensionMethodsBaseImageOverridesBuilder >> imageName [ 
	^ 'Pharo10-SNAPSHOT-64bit-14f5413.image'
]

{ #category : #accessing }
GtExtensionMethodsBaseImageOverridesBuilder >> imageUrl [
	^ 'https://dl.feenk.com/pharo/', self imageArchiveName
]

{ #category : #accessing }
GtExtensionMethodsBaseImageOverridesBuilder >> targetFolder [
	^ FileLocator localDirectory / 'analysis-extension-methods'
]

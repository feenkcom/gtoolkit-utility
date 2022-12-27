"
{{gtClass:GtExtensionMethodsRepositoryWrapper}}  provides an overview of extensions methods loaded by a baseline into the system.

It takes a baseline project and extracts all extension methods added by loaded packages to other packages not loaded by the baseline. It takes into account packages loaded directly from the baseline of any referenced baseline recursively.
"
Class {
	#name : #GtExtensionMethodsProjectBuilder,
	#superclass : #Object,
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

{ #category : #analysis }
GtExtensionMethodsProjectBuilder class >> forGToolkit [
	<gtExample>
		
	^ self new 
		buildWrapperForProject: BaselineOfGToolkit fullBaselineProject
]

{ #category : #analysis }
GtExtensionMethodsProjectBuilder class >> forGToolkitMethods: aCollection [
	| gtProject |
	gtProject := BaselineOfGToolkit fullBaselineProject.
	
	^ self new 
		buildProjectWrapperForMethods: aCollection 
		inProject: gtProject
]

{ #category : #accessing }
GtExtensionMethodsProjectBuilder >> allSystemPackages [
	^ RPackageOrganizer default  packages.
]

{ #category : #analysis }
GtExtensionMethodsProjectBuilder >> buildProjectWrapperForMethods: aCollection inProject: aProject [
	| packageWrappers repositoryWrappers |
	packageWrappers := self packageWrappersForMethods: aCollection.
	
	repositoryWrappers := self 
		repositoryWrappersForProject: aProject
		withPackageWrappers: packageWrappers.
		
	^ GtExtensionMethodsProjectWrapper new 
		project: aProject;
		repositoryWrappers: repositoryWrappers
]

{ #category : #analysis }
GtExtensionMethodsProjectBuilder >> buildWrapperForProject: aProject [
	| systemExtensions |
	systemExtensions := self extensionsToSystemClassesForProject:  aProject.
	
	^ self 
		buildProjectWrapperForMethods: systemExtensions 
		inProject: aProject
]

{ #category : #utils }
GtExtensionMethodsProjectBuilder >> extensionsToSystemClassesForProject: aProject [
	| projectPackages projectExtensionMethods nonProjectPackages |
	
	projectPackages := aProject allPPackages.
	nonProjectPackages := self allSystemPackages difference: projectPackages.
	
	projectExtensionMethods := projectPackages flatCollect: #extensionMethods.
	^ projectExtensionMethods select: [ :aMethod |
		nonProjectPackages includes: aMethod methodClass package ]
]

{ #category : #utils }
GtExtensionMethodsProjectBuilder >> packageWrappersForMethods: aCollection [
	| wrappersByName |
	wrappersByName := Dictionary new.

	(aCollection groupedBy: [ :aMethod | aMethod package ] )
		associations do: [ :assoc |
			wrappersByName 
				at: assoc key name
				put: (GtExtensionMethodsPackageWrapper new 
					packageName:  assoc key name;
					extensionMethods: assoc value) ].
	^ wrappersByName		
]

{ #category : #utils }
GtExtensionMethodsProjectBuilder >> repositoryWrappersForProject: aProject withPackageWrappers: packageWrappersByName [
	^ aProject  withAllRepositories 
		collect: [ :aRepository |
			| wrapper |
			wrapper := GtExtensionMethodsRepositoryWrapper new
				baselineRepository:  aRepository.
			aRepository containedPackages do: [ :aPackage | 
				packageWrappersByName 
					at: aPackage name
					ifPresent: [ :aPackageWrapper |
						wrapper addPackageWrapper: aPackageWrapper ] ].
			wrapper ]
]

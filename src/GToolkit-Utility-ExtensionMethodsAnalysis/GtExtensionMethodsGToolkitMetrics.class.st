"
{{gtClass:GtExtensionMethodsGToolkitMetrics}} provides an entry point for getting information about extension methods added from Glamorous Toolkit to the base Pharo image.

This object instantiates a {{gtClass:GtExtensionMethodsProjectWrapper}} for Glamorous Toolkit.
"
Class {
	#name : #GtExtensionMethodsGToolkitMetrics,
	#superclass : #Object,
	#instVars : [
		'gtoolkitProject',
		'gtoolkitProjectForPharoPatchMethods'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

{ #category : #accessing }
GtExtensionMethodsGToolkitMetrics class >> cleanUp [
	defaultInstance := nil
]

{ #category : #accessing }
GtExtensionMethodsGToolkitMetrics class >> defaultInstance [
	<gtExample>
	
	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #metrics }
GtExtensionMethodsGToolkitMetrics class >> extensionMethods [
	<gtExample>
	
	^ self gtoolkitProject extensionMethods
]

{ #category : #metrics }
GtExtensionMethodsGToolkitMetrics class >> gtoolkitProject [
	<gtExample>
	
	^ self defaultInstance gtoolkitProject
]

{ #category : #metrics }
GtExtensionMethodsGToolkitMetrics class >> gtoolkitProjectForPharoPatchMethods [
	<gtExample>
	
	^ self defaultInstance gtoolkitProjectForPharoPatchMethods
]

{ #category : #metrics }
GtExtensionMethodsGToolkitMetrics class >> packageWrappers [
	<gtExample>
	
	^ self gtoolkitProject packageWrappers
]

{ #category : #metrics }
GtExtensionMethodsGToolkitMetrics class >> packageWrappersForPharoPatchMethods [
	<gtExample>
	
	^ self gtoolkitProjectForPharoPatchMethods packageWrappers
]

{ #category : #metrics }
GtExtensionMethodsGToolkitMetrics class >> pharoPatchMethods [
	<gtExample>
	
	^ self gtoolkitProjectForPharoPatchMethods extensionMethods
]

{ #category : #metrics }
GtExtensionMethodsGToolkitMetrics class >> repositoryWrappersWithExtensions [
	<gtExample>
	
	^ self gtoolkitProject repositoryWrappersWithExtensions
]

{ #category : #metrics }
GtExtensionMethodsGToolkitMetrics >> gtoolkitProject [
	^ gtoolkitProject ifNil: [
		gtoolkitProject := GtExtensionMethodsProjectBuilder forGToolkit ]
]

{ #category : #metrics }
GtExtensionMethodsGToolkitMetrics >> gtoolkitProjectForPharoPatchMethods [
	^ gtoolkitProjectForPharoPatchMethods ifNil: [
		gtoolkitProjectForPharoPatchMethods := GtExtensionMethodsProjectBuilder forGTPharoPatchMethods ]
]

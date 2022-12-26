Class {
	#name : #GtExtensionMethodsGToolkitMetrics,
	#superclass : #Object,
	#instVars : [
		'gtoolkitProject'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-Utility-ExtensionMethodsAnalysis'
}

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
GtExtensionMethodsGToolkitMetrics class >> packageWrappers [
	<gtExample>
	
	^ self gtoolkitProject packageWrappers
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

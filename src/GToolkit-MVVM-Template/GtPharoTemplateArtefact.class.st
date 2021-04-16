Class {
	#name : #GtPharoTemplateArtefact,
	#superclass : #Object,
	#instVars : [
		'storageBehavior',
		'storageSelector',
		'storageProtocol'
	],
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #initialize }
GtPharoTemplateArtefact >> initialize [
	super initialize.

	storageBehavior := GtPharoCoderBehavior unspecified.
	storageSelector := nil.
	storageProtocol := 'templates'
]

{ #category : #accessing }
GtPharoTemplateArtefact >> storageBehavior [
	^ storageBehavior
]

{ #category : #initialize }
GtPharoTemplateArtefact >> storageBehavior: aBehavior selector: aSelector [
	storageBehavior := GtPharoCoderBehavior explicit: aBehavior.
	storageSelector := aSelector
]

{ #category : #initialize }
GtPharoTemplateArtefact >> storageMethod: aCompiledMethod [
	storageSelector := aCompiledMethod selector.
	storageBehavior := GtPharoCoderBehavior explicit: aCompiledMethod methodClass.
	storageProtocol := aCompiledMethod protocol
]

{ #category : #accessing }
GtPharoTemplateArtefact >> storageProtocol [
	^ storageProtocol
]

{ #category : #accessing }
GtPharoTemplateArtefact >> storageProtocol: anObject [
	storageProtocol := anObject
]

{ #category : #accessing }
GtPharoTemplateArtefact >> storageSelector [
	^ storageSelector
]

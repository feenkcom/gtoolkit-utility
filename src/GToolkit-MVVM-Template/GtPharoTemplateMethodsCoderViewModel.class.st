Class {
	#name : #GtPharoTemplateMethodsCoderViewModel,
	#superclass : #GtPharoMethodsCoderViewModel,
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #adding }
GtPharoTemplateMethodsCoderViewModel >> addNewCoderSelector: aSelector protocol: aProtocol [
	| aNewCoder |
	
	aNewCoder := self coder addNewCoderSelector: aSelector protocol: aProtocol.
	self
		expandCoder: aNewCoder;
		focusCoder: aNewCoder.
	^ aNewCoder
]

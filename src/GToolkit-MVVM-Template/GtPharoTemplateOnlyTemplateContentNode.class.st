Class {
	#name : #GtPharoTemplateOnlyTemplateContentNode,
	#superclass : #GtPharoTemplateOnlyProgramNode,
	#instVars : [
		'templateParts'
	],
	#category : #'GToolkit-MVVM-Template-Ast'
}

{ #category : #generated }
GtPharoTemplateOnlyTemplateContentNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateContent: self
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateContentNode >> compositeNodeVariables [
	^ #(#templateParts)
]

{ #category : #'generated-initialize-release' }
GtPharoTemplateOnlyTemplateContentNode >> initialize [
	super initialize.
	templateParts := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateContentNode >> templateParts [
	^ templateParts
]

{ #category : #generated }
GtPharoTemplateOnlyTemplateContentNode >> templateParts: anOrderedCollection [
	self setParents: self templateParts to: nil.
	templateParts := anOrderedCollection.
	self setParents: self templateParts to: self
]

"
{{gtClass:GtUndeclaredReferenceWrapper}} is a wrapper around an undeclared binding that adds specific views.
"
Class {
	#name : #GtUndeclaredReferenceWrapper,
	#superclass : #Object,
	#instVars : [
		'binding'
	],
	#category : #'GToolkit-Utility-UndeclaredReferences'
}

{ #category : #'instance creation' }
GtUndeclaredReferenceWrapper class >> forBinding: aBinding [
	^ self new 
		binding: aBinding
]

{ #category : #accessing }
GtUndeclaredReferenceWrapper >> binding [

	^ binding
]

{ #category : #accessing }
GtUndeclaredReferenceWrapper >> binding: anObject [

	binding := anObject
]

{ #category : #'gt - extensions' }
GtUndeclaredReferenceWrapper >> gtViewReferencesFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'References';
		priority: 10;
		object: [ self binding gtReferences ];
		view: #gtItemsFor:
]

{ #category : #accessing }
GtUndeclaredReferenceWrapper >> name [
	^ self binding key
]

{ #category : #printing }
GtUndeclaredReferenceWrapper >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [ 
		aStream << self binding key ]
]

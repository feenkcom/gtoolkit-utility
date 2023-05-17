"
{{gtClass:GtUndeclararedReferencesWrapper}} is a wrappper around the `Undeclared` global variable. It provides views for exploring undeclared variables.
"
Class {
	#name : #GtUndeclararedReferencesWrapper,
	#superclass : #Object,
	#category : #'GToolkit-Utility-UndeclaredReferences'
}

{ #category : #accessing }
GtUndeclararedReferencesWrapper class >> default [ 
	<gtExample>
	^ self new
]

{ #category : #accessing }
GtUndeclararedReferencesWrapper >> bindingsForUndeclaredAttributes [
	^ Undeclared associations 
		select: [ :assoc | assoc key first isLowercase ]
		thenCollect: [ :assoc | 
			GtUndeclaredReferenceWrapper forBinding: assoc ]
]

{ #category : #accessing }
GtUndeclararedReferencesWrapper >> bindingsForUndeclaredClasses [
	^ Undeclared associations 
		select: [ :assoc | assoc key first isUppercase ]
		thenCollect: [ :assoc | 
			GtUndeclaredReferenceWrapper forBinding: assoc ]
]

{ #category : #'gt - extensions' }
GtUndeclararedReferencesWrapper >> gtViewUndeclaredAttributesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Undeclared attributes';
		items: [ 
			self bindingsForUndeclaredAttributes
				sorted: [ :aBinding | aBinding name ] ascending ];
		itemText: [ :aBinding | aBinding name ]
]

{ #category : #'gt - extensions' }
GtUndeclararedReferencesWrapper >> gtViewUndeclaredClassessFor: aView [
	<gtView>
	
	^ aView list
		title: 'Undeclared classes';
		items: [ self bindingsForUndeclaredClasses
			sorted: [ :aBinding | aBinding name ] ascending ];
		itemText: [ :aBinding | aBinding name ]
]

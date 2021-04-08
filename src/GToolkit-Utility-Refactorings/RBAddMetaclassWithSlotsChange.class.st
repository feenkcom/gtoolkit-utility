Class {
	#name : #RBAddMetaclassWithSlotsChange,
	#superclass : #RBAddMetaclassChange,
	#category : #'GToolkit-Utility-Refactorings-Changes'
}

{ #category : #private }
RBAddMetaclassWithSlotsChange class >> definitionPatterns [
	^ #('`className class slots: `@slotsExpression'
		'`className class uses: `@traitComposition slots: `@slotsExpression')
]

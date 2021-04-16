Class {
	#name : #GtPharoTemplateMethodCoderViewModel,
	#superclass : #GtPharoSourceCoderViewModel,
	#category : #'GToolkit-MVVM-Template-Coder'
}

{ #category : #'api - coder model' }
GtPharoTemplateMethodCoderViewModel >> behavior [
	"Return a class (or trait) in the context of which the coder is opened"

	^ UndefinedObject
]

{ #category : #accessing }
GtPharoTemplateMethodCoderViewModel >> elementClass [
	^ GtExpandableSourceCoderElement
]

{ #category : #actions }
GtPharoTemplateMethodCoderViewModel >> save [
	<return: #Boolean>

	^ self coderModel saveInContext: self evaluationContext
]

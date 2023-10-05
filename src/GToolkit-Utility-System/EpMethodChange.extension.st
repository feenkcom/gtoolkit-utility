Extension { #name : #EpMethodChange }

{ #category : #'*GToolkit-Utility-System' }
EpMethodChange >> behaviorAffected [

	^ self methodAffected methodClass
]

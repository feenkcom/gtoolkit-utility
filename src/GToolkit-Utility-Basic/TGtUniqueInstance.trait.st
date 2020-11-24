Trait {
	#name : #TGtUniqueInstance,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Utility-Basic-Traits'
}

{ #category : #cleanup }
TGtUniqueInstance classSide >> cleanUniqueInstance [
	uniqueInstance ifNotNil: [ :anInstance | 
		self onRemoveUniqueInstance: anInstance ].
	uniqueInstance := nil.
]

{ #category : #cleanup }
TGtUniqueInstance classSide >> cleanUp [
	self cleanUniqueInstance
]

{ #category : #accessing }
TGtUniqueInstance classSide >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
TGtUniqueInstance classSide >> instance [
	^ self uniqueInstance
]

{ #category : #'private - hooks' }
TGtUniqueInstance classSide >> onRemoveUniqueInstance: anInstance [
	"Classes may perform some activities on a singleton that is about to be released"
]

{ #category : #accessing }
TGtUniqueInstance classSide >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

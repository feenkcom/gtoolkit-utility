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

{ #category : #'as yet unclassified' }
TGtUniqueInstance classSide >> gtInstanceButtonFor: anAction [
	<gtClassAction>
	^ anAction button
		tooltip: 'Inspect unique instance';
		priority: 10;
		icon: BrGlamorousVectorIcons playinspect;
		action: [ :aButton | aButton phlow spawnObject: self uniqueInstance]
]

{ #category : #testing }
TGtUniqueInstance classSide >> hasUniqueInstance [

	^ uniqueInstance isNotNil
]

{ #category : #accessing }
TGtUniqueInstance classSide >> instance [
	<gtExample>
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

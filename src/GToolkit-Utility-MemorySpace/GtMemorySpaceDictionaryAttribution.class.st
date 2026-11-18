"
I attribute a dictionary, its internal array, its associations and its keys to my object category, and the objects reachable from each value with the attribution of its key. Each key with its own attribution has a {{gtClass:GtMemorySpaceKeyRule}}, indexed by key. Keys without a rule use my attribution for other keys, which by default attributes them to my object category.

Only plain dictionaries (Dictionary and IdentityDictionary) are split by keys, as they keep keys and values in associations (see #canSplit:). Other objects, including method dictionaries, weak dictionaries and ordered dictionaries, are attributed entirely to my object category.
"
Class {
	#name : #GtMemorySpaceDictionaryAttribution,
	#superclass : #GtMemorySpaceAttribution,
	#instVars : [
		'objectCategory',
		'objectAttribution',
		'keyRules',
		'otherKeysAttribution'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #accessing }
GtMemorySpaceDictionaryAttribution >> attributionForKey: aKey [
	^ (self ruleForKey: aKey)
		ifNil: [ self otherKeysAttribution ]
		ifNotNil: [ :aRule | aRule attribution ]
]

{ #category : #testing }
GtMemorySpaceDictionaryAttribution >> canSplit: anObject [
	"Only plain dictionaries are split by keys: they keep their keys and values in associations in their array.
	Method dictionaries, weak dictionaries and other dictionaries are estimated as a whole."

	^ anObject class == Dictionary or: [ anObject class == IdentityDictionary ]
]

{ #category : #accessing }
GtMemorySpaceDictionaryAttribution >> categoriesDo: aBlock [
	aBlock value: objectCategory.
	keyRules do: [ :each | each attribution categoriesDo: aBlock ].
	self otherKeysAttribution categoriesDo: aBlock
]

{ #category : #estimating }
GtMemorySpaceDictionaryAttribution >> estimate: anObject with: anEstimator into: anEstimate [
	(self canSplit: anObject)
		ifFalse: [ ^ anEstimator
				estimate: anObject
				inCategory: objectCategory
				into: anEstimate ].
	(anEstimator shouldCountExplicitly: anObject) ifFalse: [ ^ self ].

	anEstimator
		estimateObject: anObject
		inCategory: objectCategory
		into: anEstimate.
	anEstimator
		estimateObject: (anObject instVarNamed: #array)
		inCategory: objectCategory
		into: anEstimate.
	anObject
		associationsDo: [ :anAssociation | 
			anEstimator
				estimateObject: anAssociation
				inCategory: objectCategory
				into: anEstimate.
			anEstimator
				estimate: anAssociation key
				inCategory: objectCategory
				into: anEstimate.
			(self attributionForKey: anAssociation key)
				estimate: anAssociation value
				with: anEstimator
				into: anEstimate ]
]

{ #category : #initialization }
GtMemorySpaceDictionaryAttribution >> initialize [
	super initialize.
	keyRules := OrderedDictionary new
]

{ #category : #declaring }
GtMemorySpaceDictionaryAttribution >> key: aKey by: anAttribution [
	"Attribute the objects reachable from the value of aKey with anAttribution"

	keyRules
		at: aKey
		put: (GtMemorySpaceKeyRule key: aKey attribution: anAttribution)
]

{ #category : #declaring }
GtMemorySpaceDictionaryAttribution >> key: aKey to: aCategory [
	"Attribute everything reachable from the value of aKey to aCategory"

	self key: aKey by: (GtMemorySpaceAttribution toCategory: aCategory)
]

{ #category : #accessing }
GtMemorySpaceDictionaryAttribution >> keyRules [
	"The rules of the keys with their own attribution (GtMemorySpaceKeyRule)"

	^ keyRules values
]

{ #category : #declaring }
GtMemorySpaceDictionaryAttribution >> keys: aCollectionOfKeys to: aCategory [
	| anAttribution |
	anAttribution := GtMemorySpaceAttribution toCategory: aCategory.
	aCollectionOfKeys do: [ :each | self key: each by: anAttribution ]
]

{ #category : #accessing }
GtMemorySpaceDictionaryAttribution >> objectAttribution [
	"Attributes everything to the category of the dictionary"

	^ objectAttribution
		ifNil: [ objectAttribution := GtMemorySpaceAttribution toCategory: objectCategory ]
]

{ #category : #accessing }
GtMemorySpaceDictionaryAttribution >> objectCategory [
	^ objectCategory
]

{ #category : #declaring }
GtMemorySpaceDictionaryAttribution >> objectCategory: aCategory [
	"The category of the dictionary, its internal array, its associations and keys"

	objectCategory := aCategory.
	objectAttribution := nil
]

{ #category : #accessing }
GtMemorySpaceDictionaryAttribution >> otherKeysAttribution [
	"By default, values of keys without an explicit attribution go to the category of the dictionary"

	^ otherKeysAttribution ifNil: [ self objectAttribution ]
]

{ #category : #declaring }
GtMemorySpaceDictionaryAttribution >> otherKeysBy: anAttribution [
	otherKeysAttribution := anAttribution
]

{ #category : #declaring }
GtMemorySpaceDictionaryAttribution >> otherKeysTo: aCategory [
	self otherKeysBy: (GtMemorySpaceAttribution toCategory: aCategory)
]

{ #category : #accessing }
GtMemorySpaceDictionaryAttribution >> ruleForKey: aKey [
	"The rule of the key, or nil if the key uses the attribution for other keys"

	^ keyRules at: aKey ifAbsent: nil
]

{ #category : #accessing }
GtMemorySpaceDictionaryAttribution >> rules [
	^ Array
		streamContents: [ :aStream | 
			aStream
				nextPut: (GtMemorySpaceRule
						label: 'the dictionary itself'
						attribution: self objectAttribution).
			aStream nextPutAll: self keyRules.
			aStream
				nextPut: (GtMemorySpaceRule label: 'other keys' attribution: self otherKeysAttribution) ]
]

{ #category : #accessing }
GtMemorySpaceDictionaryAttribution >> summary [
	^ 'split by keys, the dictionary to '
		, (GtMemorySpaceCategory nameOf: objectCategory)
]

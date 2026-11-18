"
An example of a {{gtClass:GtMemorySpaceDefinition}}: it estimates a collection of associations, attributing the associations, their keys and their values to separate categories. The category #unused is declared but nothing is attributed to it, to show that all categories appear in an estimate.

See {{gtClass:GtMemorySpaceEstimatorExamples}}.
"
Class {
	#name : #GtMemorySpaceExampleDefinition,
	#superclass : #GtMemorySpaceDefinition,
	#instVars : [
		'associationAttribution'
	],
	#category : #'GToolkit-Utility-MemorySpace'
}

{ #category : #initialization }
GtMemorySpaceExampleDefinition >> initialize [
	super initialize.
	self
		category: #associations
			named: 'Associations'
			description: 'The associations themselves';
		category: #keys
			named: 'Keys'
			description: 'The keys of the associations';
		category: #values
			named: 'Values'
			description: 'The values of the associations';
		category: #unused
			named: 'Unused'
			description: 'Declared, but nothing is attributed to it'.
	associationAttribution := GtMemorySpaceSlotsAttribution new
			objectCategory: (self category: #associations);
			slot: #key to: (self category: #keys);
			slot: #value to: (self category: #values);
			yourself
]

{ #category : #accessing }
GtMemorySpaceExampleDefinition >> rootsOf: aCollectionOfAssociations do: aBlock [
	aCollectionOfAssociations
		do: [ :each | aBlock value: each value: associationAttribution ]
]

{ #category : #accessing }
GtMemorySpaceExampleDefinition >> rules [
	^ {GtMemorySpaceRule label: 'Associations' attribution: associationAttribution}
]

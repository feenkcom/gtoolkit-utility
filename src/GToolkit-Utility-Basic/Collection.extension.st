Extension { #name : #Collection }

{ #category : #'*GToolkit-Utility-Basic' }
Collection >> collect: elementBlock separatedBy: separatorBlock [
	| newCollection |

	newCollection := OrderedCollection new.
	self
		do: [ :each | newCollection add: (elementBlock value: each)]
		separatedBy: [ newCollection add: (separatorBlock value) ].

	^ newCollection as: self species
]

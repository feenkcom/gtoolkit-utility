Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Utility-Basic' }
CompiledMethod >> gtIsGetter [
	^ self methodClass slots
		anySatisfy: [ :aSlot | 
			| matcher parseTree |
			matcher := RBParseTreeSearcher getterMethod: aSlot name.
			parseTree := self methodClass parseTreeForSelector: self selector.
			parseTree ifNotNil: [ matcher executeTree: self ast ].
			matcher answer notNil ]
]

{ #category : #'*GToolkit-Utility-Basic' }
CompiledMethod >> gtIsSetter [
	^ self methodClass slots
		anySatisfy: [ :aSlot | 
			| matcher parseTree |
			matcher := RBParseTreeSearcher setterMethod: aSlot name.
			parseTree := self methodClass parseTreeForSelector: self selector.
			parseTree ifNotNil: [ matcher executeTree: self ast ].
			matcher answer notNil ]
]

{ #category : #'*GToolkit-Utility-Basic' }
CompiledMethod >> gtSelfMethods [
	^ self selfMessages
		collectAsSet: [ :selector | self methodClass lookupSelector: selector ]
]

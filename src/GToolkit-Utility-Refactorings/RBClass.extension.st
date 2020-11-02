Extension { #name : #RBClass }

{ #category : #'*GToolkit-Utility-Refactorings' }
RBClass >> gtDefinitionString [
	^ String
		streamContents: [ :definitionStream | 
			definitionStream
				nextPutAll: self superclass printString;
				nextPutAll: ' subclass: #';
				nextPutAll: self name.
			self traitExpression
				ifNotNil: [ :exp | 
					definitionStream
						nextPutAll:
							'
	uses: ';
						nextPutAll: exp ].
			definitionStream
				nextPutAll:
					'
	instanceVariableNames: '''.
			self instanceVariableNames
				do: [ :each | 
					definitionStream
						nextPutAll: each;
						nextPut: $  ].
			definitionStream
				nextPutAll:
					'''
	classVariableNames: '''.
			self classVariableNames
				do: [ :each | 
					definitionStream
						nextPutAll: each;
						nextPut: $  ].
			definitionStream
				nextPutAll:
					'''
	poolDictionaries: '''.
			self sharedPoolNames
				do: [ :each | 
					definitionStream
						nextPutAll: each;
						nextPut: $  ].
			definitionStream
				nextPutAll:
					'''
	category: #'''.
			definitionStream nextPutAll: self category asString.
			definitionStream nextPut: $' ]
]

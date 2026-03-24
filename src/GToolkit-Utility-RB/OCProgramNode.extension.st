Extension { #name : #OCProgramNode }

{ #category : #'*GToolkit-Utility-RB' }
OCProgramNode >> / aNameOrClass [
	^ self asNodeQuery / aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB' }
OCProgramNode >> // aNameOrClass [
	^ self asNodeQuery // aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB' }
OCProgramNode >> \ aNameOrClass [
	^ self asNodeQuery \ aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB' }
OCProgramNode >> \\ aNameOrClass [
	^ self asNodeQuery \\ aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB' }
OCProgramNode >> asNodeQuery [
	^ GtRBNodeQuery nodes: {self}
]

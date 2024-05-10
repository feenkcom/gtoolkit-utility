Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Utility-RB' }
RBProgramNode >> / aNameOrClass [
	^ self asNodeQuery / aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB' }
RBProgramNode >> // aNameOrClass [
	^ self asNodeQuery // aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB' }
RBProgramNode >> \ aNameOrClass [
	^ self asNodeQuery \ aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB' }
RBProgramNode >> \\ aNameOrClass [
	^ self asNodeQuery \\ aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB' }
RBProgramNode >> asNodeQuery [
	^ GtRBNodeQuery nodes: {self}
]

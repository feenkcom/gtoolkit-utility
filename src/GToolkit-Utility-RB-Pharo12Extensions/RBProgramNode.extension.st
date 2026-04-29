Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Utility-RB-Pharo12Extensions' }
RBProgramNode >> / aNameOrClass [
	^ self asNodeQuery / aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB-Pharo12Extensions' }
RBProgramNode >> // aNameOrClass [
	^ self asNodeQuery // aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB-Pharo12Extensions' }
RBProgramNode >> \ aNameOrClass [
	^ self asNodeQuery \ aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB-Pharo12Extensions' }
RBProgramNode >> \\ aNameOrClass [
	^ self asNodeQuery \\ aNameOrClass
]

{ #category : #'*GToolkit-Utility-RB-Pharo12Extensions' }
RBProgramNode >> asNodeQuery [
	^ GtRBNodeQuery nodes: {self}
]

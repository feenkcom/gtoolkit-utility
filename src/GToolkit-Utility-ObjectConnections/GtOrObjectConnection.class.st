Class {
	#name : #GtOrObjectConnection,
	#superclass : #Object,
	#category : #'GToolkit-Utility-ObjectConnections'
}

{ #category : #accessing }
GtOrObjectConnection >> connectionKey [
	self subclassResponsibility
]

{ #category : #accessing }
GtOrObjectConnection >> fromObject [
	self subclassResponsibility
]

{ #category : #printing }
GtOrObjectConnection >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			print: self connectionKey;
			<< ' from "';
			print: self fromObject;
			<< '" to "';
			print:  self toObject;
			<< '"']
]

{ #category : #accessing }
GtOrObjectConnection >> toObject [
	self subclassResponsibility
]

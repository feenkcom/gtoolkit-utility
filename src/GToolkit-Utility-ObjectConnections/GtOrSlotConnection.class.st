Class {
	#name : #GtOrSlotConnection,
	#superclass : #GtOrObjectConnection,
	#instVars : [
		'targetObject',
		'slotName',
		'slotValue'
	],
	#category : #'GToolkit-Utility-ObjectConnections'
}

{ #category : #accessing }
GtOrSlotConnection >> connectionKey [
	^ self slotName
]

{ #category : #accessing }
GtOrSlotConnection >> fromObject [
	^ self targetObject
]

{ #category : #accessing }
GtOrSlotConnection >> slotName [
	^ slotName
]

{ #category : #accessing }
GtOrSlotConnection >> slotName: anObject [
	slotName := anObject
]

{ #category : #accessing }
GtOrSlotConnection >> slotValue [
	^ slotValue
]

{ #category : #accessing }
GtOrSlotConnection >> slotValue: anObject [
	slotValue := anObject
]

{ #category : #accessing }
GtOrSlotConnection >> targetObject [
	^ targetObject
]

{ #category : #accessing }
GtOrSlotConnection >> targetObject: anObject [
	targetObject := anObject
]

{ #category : #accessing }
GtOrSlotConnection >> toObject [
	^ self slotValue
]

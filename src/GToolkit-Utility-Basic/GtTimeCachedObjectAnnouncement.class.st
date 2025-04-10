Class {
	#name : #GtTimeCachedObjectAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'newValue',
		'cache'
	],
	#category : #'GToolkit-Utility-Basic-Cache'
}

{ #category : #'instance creation' }
GtTimeCachedObjectAnnouncement class >> newValue: anObject cache: aGtTimeCachedObject [

	^ self new initializeValue: anObject from: aGtTimeCachedObject
]

{ #category : #'as yet unclassified' }
GtTimeCachedObjectAnnouncement class >> value [
	^ self
]

{ #category : #accessing }
GtTimeCachedObjectAnnouncement >> cache [
	^ cache
]

{ #category : #initialization }
GtTimeCachedObjectAnnouncement >> initializeValue: anObject from: aGtTimeCachedObject [

	newValue := anObject.
	cache := aGtTimeCachedObject.
]

{ #category : #accessing }
GtTimeCachedObjectAnnouncement >> newValue [
	^ newValue
]

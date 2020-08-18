Class {
	#name : #GtAnnouncer,
	#superclass : #Announcer,
	#traits : 'TGtExtraSubscription',
	#classTraits : 'TGtExtraSubscription classTrait',
	#category : #'GToolkit-Utility-Announcer'
}

{ #category : #factory }
GtAnnouncer class >> null [
	^ GtNullAnnouncer
]

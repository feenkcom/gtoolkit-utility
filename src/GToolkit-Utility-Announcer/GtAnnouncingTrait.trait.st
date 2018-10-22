Trait {
	#name : #GtAnnouncingTrait,
	#category : #'GToolkit-Utility-Announcer-Traits'
}

{ #category : #announcer }
GtAnnouncingTrait >> announce: anAnnouncement [
	^ self announcer announce: anAnnouncement
]

{ #category : #announcer }
GtAnnouncingTrait >> announcer [
	<return: #Announcer>
	^ self explicitRequirement
]

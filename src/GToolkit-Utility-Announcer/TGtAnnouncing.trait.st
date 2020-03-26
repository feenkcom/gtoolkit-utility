Trait {
	#name : #TGtAnnouncing,
	#category : #'GToolkit-Utility-Announcer-Traits'
}

{ #category : #announcer }
TGtAnnouncing >> announce: anAnnouncement [
	^ self announcer announce: anAnnouncement
]

{ #category : #announcer }
TGtAnnouncing >> announcer [
	<return: #Announcer>
	^ self explicitRequirement
]

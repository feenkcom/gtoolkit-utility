Trait {
	#name : #TGtWithAnnouncer,
	#instVars : [
		'announcer'
	],
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#category : #'GToolkit-Utility-Announcer'
}

{ #category : #testing }
TGtWithAnnouncer classSide >> isDeprecated [
	^ true
]

{ #category : #announcer }
TGtWithAnnouncer >> announcer [

	<return: #Announcer>
	^ announcer ifNil: [ announcer := Announcer new ]
]

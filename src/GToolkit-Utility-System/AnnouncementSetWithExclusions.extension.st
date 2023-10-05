Extension { #name : #AnnouncementSetWithExclusions }

{ #category : #'*GToolkit-Utility-System' }
AnnouncementSetWithExclusions >> addExclusions: aCollection [
	"Add the supplied announcements as exclusions to me.
	I will explicitly not handle my exclusion announcements."

	(aCollection allSatisfy: [ :ann | ann inheritsFrom: Announcement ]) ifFalse:
		[ self error: 'The supplied collection contains items other than Announcements' ].
	^ exclusions addAll: aCollection
]

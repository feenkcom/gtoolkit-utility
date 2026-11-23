"
I am the role of the global FinalizationRegistry, the root from which weak subscriptions can be kept alive.
"
Class {
	#name : #GtAnnouncerGraphRootRole,
	#superclass : #GtAnnouncerGraphRole,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #accessing }
GtAnnouncerGraphRootRole >> color [
	^Color fromHexString: 'F4CCCC'
]

{ #category : #testing }
GtAnnouncerGraphRootRole >> isRoot [
	^true
]

{ #category : #accessing }
GtAnnouncerGraphRootRole >> meaning [
	^'FinalizationRegistry default, which holds an entry for every Pharo weak subscription'
]

{ #category : #accessing }
GtAnnouncerGraphRootRole >> title [
	^'global registry'
]

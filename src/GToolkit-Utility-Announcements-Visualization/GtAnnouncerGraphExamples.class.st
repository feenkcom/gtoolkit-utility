"
I build situations with a plain or a mixed subscription registry and draw them as {{gtClass:GtAnnouncerGraph}}s. The names start with plainRegistry or mixedRegistry and end with what the global FinalizationRegistry keeps alive. Three situations are built with both registries, so their names differ only in the start; the other examples show a situation with one registry only, such as a plain registry with only weak subscribers or an old-style weak subscription in a mixed registry. Each answers a {{gtClass:GtAnnouncerGraphScenario}}; the class-side view {{gtMethod:GtAnnouncerGraphExamples class>>#gtScenariosFor:}} lists all of them with their registry and what is kept alive.
"
Class {
	#name : #GtAnnouncerGraphExamples,
	#superclass : #Object,
	#category : #'GToolkit-Utility-Announcements-Visualization'
}

{ #category : #views }
GtAnnouncerGraphExamples class >> gtScenariosFor: aView [
	<gtView>
	<gtClassView>
	^(aView columnedList)
		title: 'Scenarios';
		priority: 1;
		items: [self new scenarios];
		column: 'Scenario' text: [:each | each title];
		column: 'Registry'
			text: [:each | each registryName]
			width: 220;
		column: 'Kept alive by the global registry'
			text: [:each | each graph keptAliveDescription]
			width: 260
]

{ #category : #private }
GtAnnouncerGraphExamples >> element [
	^GtAnnouncerGraphExampleObject named: 'an element'
]

{ #category : #private }
GtAnnouncerGraphExamples >> listener [
	^GtAnnouncerGraphExampleObject named: 'a long-lived listener'
]

{ #category : #examples }
GtAnnouncerGraphExamples >> mixedRegistryStrongAndWeakElementAndWeakListenerKeepsNothingAlive [
	"Mixed registry: anElement subscribes both strongly and weakly, and aListener adds a weak subscription, as in the plain registry case that leaks. Each weak subscriber has its own ephemeron inside the registry and nothing global points into the announcer. If anAnnouncer and anElement become nil while aListener is still referenced, both are collected by the next garbage collection. If only aListener becomes nil, it is collected after two garbage collections: the first fires its ephemeron and the registry drops its subscription, the second collects it. When all three become nil, they are collected by the next garbage collection."
	<gtExample>
	| anAnnouncer anElement aListener aGraph |
	anAnnouncer := Announcer new useMixedSubscriptionRegistry.
	anElement := self element.
	aListener := self listener.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aListener.
	aGraph := GtAnnouncerGraph forAnnouncer: anAnnouncer.
	self assert: (aGraph nodes contains: [:each | each isRoot]) not.
	self assert: aGraph highlightedEdges isEmpty.
	self
		assert: (aGraph nodes
				select: [:each | each object isKindOf: WeakKeyAssociation]) size
		equals: 2.
	^self
		scenario: 'Strong and weak element and weak listener: mixed registry'
		announcer: anAnnouncer
		element: anElement
		listener: aListener
]

{ #category : #examples }
GtAnnouncerGraphExamples >> mixedRegistryStrongElementAndOldStyleWeakListenerKeepsTheElementAlive [
	"An announcer switched to the mixed registry after aListener subscribed weakly keeps the old-style weak subscription and its global entry. As with the plain registry, if anAnnouncer and anElement become nil while aListener is still referenced, nothing is collected (the red chain). When aListener becomes nil too, all three are collected after two garbage collections."
	<gtExample>
	| anAnnouncer anElement aListener aGraph |
	anAnnouncer := Announcer new.
	anElement := self element.
	aListener := self listener.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aListener.
	anAnnouncer useMixedSubscriptionRegistry.
	aGraph := GtAnnouncerGraph forAnnouncer: anAnnouncer.
	self assert: anAnnouncer subscriptions hasLeakProneSubscriptionMix.
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: anElement).
	^self
		scenario: 'Strong element and old-style weak listener moved in: mixed registry'
		announcer: anAnnouncer
		element: anElement
		listener: aListener
]

{ #category : #examples }
GtAnnouncerGraphExamples >> mixedRegistryStrongElementAndThreeWeakListenerSubscriptionsKeepsNothingAlive [
	"Mixed registry: anElement subscribes strongly, aListener weakly three times, once with a block that captures aListener. All three weak subscriptions sit in the value of one ephemeron keyed on aListener, so the block does not keep aListener alive. If aListener becomes nil, it is collected after two garbage collections, and the registry drops all three subscriptions. If anAnnouncer and anElement become nil, both are collected by the next garbage collection while aListener is still referenced."
	<gtExample>
	| anAnnouncer anElement aListener aGraph |
	anAnnouncer := Announcer new useMixedSubscriptionRegistry.
	anElement := self element.
	aListener := self listener.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aListener.
	anAnnouncer weak when: JobEnd send: #onAnnouncement: to: aListener.
	anAnnouncer weak
		when: JobStart
		do: [:anAnnouncement | aListener onAnnouncement: anAnnouncement]
		for: aListener.
	aGraph := GtAnnouncerGraph forAnnouncer: anAnnouncer.
	self
		assert: (aGraph nodes
				select: [:each | each object isKindOf: WeakKeyAssociation]) size
		equals: 1.
	self assert: (aGraph nodes contains: [:each | each object isBlock]).
	self assert: aGraph highlightedEdges isEmpty.
	^self
		scenario: 'Strong element and three weak listener subscriptions: mixed registry'
		announcer: anAnnouncer
		element: anElement
		listener: aListener
]

{ #category : #examples }
GtAnnouncerGraphExamples >> mixedRegistryStrongElementAndWeakListenerKeepsNothingAlive [
	"Mixed registry: anElement subscribes strongly, aListener weakly. Nothing global points into the announcer. If anAnnouncer and anElement become nil, both are collected by the next garbage collection, while aListener is still referenced. If only aListener becomes nil, it is collected after two garbage collections: the first fires its ephemeron and the registry drops its subscriptions, the second collects it."
	<gtExample>
	| anAnnouncer anElement aListener aGraph |
	anAnnouncer := Announcer new useMixedSubscriptionRegistry.
	anElement := self element.
	aListener := self listener.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aListener.
	aGraph := GtAnnouncerGraph forAnnouncer: anAnnouncer.
	self assert: aGraph highlightedEdges isEmpty.
	self assert: (aGraph nodes contains: [:each | each isRoot]) not.
	^self
		scenario: 'Strong element and weak listener: mixed registry'
		announcer: anAnnouncer
		element: anElement
		listener: aListener
]

{ #category : #examples }
GtAnnouncerGraphExamples >> plainRegistryOnlyWeakSubscribersKeepsTheAnnouncerAlive [
	"Plain registry: anElement and aListener both subscribe weakly. If anElement becomes nil, it is collected after two garbage collections, even while aListener lives. If anAnnouncer becomes nil while aListener is still referenced, anAnnouncer is not collected: aListener's global entry keeps its weak subscription, which keeps anAnnouncer and its registry (the red chain). Only the announcer leaks, not the other subscribers. When aListener becomes nil too, everything is collected after two garbage collections."
	<gtExample>
	| anAnnouncer anElement aListener aGraph |
	anAnnouncer := Announcer new.
	anElement := self element.
	aListener := self listener.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aListener.
	aGraph := GtAnnouncerGraph forAnnouncer: anAnnouncer.
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: anAnnouncer).
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: anElement) not.
	^self
		scenario: 'Only weak subscribers: plain registry'
		announcer: anAnnouncer
		element: anElement
		listener: aListener
]

{ #category : #examples }
GtAnnouncerGraphExamples >> plainRegistryStrongAndWeakElementAndWeakListenerKeepsTheElementAlive [
	"Plain registry: anElement subscribes both strongly and weakly, which alone does not leak, and aListener adds a weak subscription. If anAnnouncer and anElement become nil while aListener is still referenced, nothing is collected: aListener's global entry keeps its weak subscription, which keeps anAnnouncer, whose strong subscription keeps anElement (the red chain). The global entry of anElement does not keep anElement alive, as its key is anElement itself. When aListener becomes nil too, all three are collected after two garbage collections."
	<gtExample>
	| anAnnouncer anElement aListener aGraph |
	anAnnouncer := Announcer new.
	anElement := self element.
	aListener := self listener.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aListener.
	aGraph := GtAnnouncerGraph forAnnouncer: anAnnouncer.
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: anAnnouncer).
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: anElement).
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: aListener) not.
	^self
		scenario: 'Strong and weak element and weak listener: plain registry'
		announcer: anAnnouncer
		element: anElement
		listener: aListener
]

{ #category : #examples }
GtAnnouncerGraphExamples >> plainRegistryStrongAndWeakElementKeepsTheAnnouncerAlive [
	"Plain registry: anElement subscribes both strongly and weakly. The global entry of anElement keeps its weak subscription and with it anAnnouncer alive for as long as anElement lives (the red chain), but it does not keep anElement itself alive, as anElement is its key. When anAnnouncer and anElement become nil, both are collected after two garbage collections: the first fires the entry, the second collects everything. If only anAnnouncer becomes nil, it stays alive as long as anElement does."
	<gtExample>
	| anAnnouncer anElement aGraph |
	anAnnouncer := Announcer new.
	anElement := self element.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: anElement.
	aGraph := GtAnnouncerGraph forAnnouncer: anAnnouncer.
	self assert: (aGraph nodes contains: [:each | each isRoot]).
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: anAnnouncer).
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: anElement) not.
	^GtAnnouncerGraphScenario
		title: 'Strong and weak element: plain registry'
		announcer: anAnnouncer
		participants: (Array with: anElement)
]

{ #category : #examples }
GtAnnouncerGraphExamples >> plainRegistryStrongElementAndThreeWeakListenerSubscriptionsKeepsTheElementAlive [
	"Plain registry: anElement subscribes strongly, aListener weakly three times, once with a block that captures aListener, as in the mixed registry case. Each weak subscription has its own global entry keyed on aListener. If anAnnouncer and anElement become nil while aListener is still referenced, nothing is collected (the red chain). Unlike with the mixed registry, if only aListener becomes nil it is not collected either: the registry holds the block subscription strongly and the block captures aListener, so the announcer keeps aListener alive. When all three become nil, they are collected after two garbage collections."
	<gtExample>
	| anAnnouncer anElement aListener aGraph |
	anAnnouncer := Announcer new.
	anElement := self element.
	aListener := self listener.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aListener.
	anAnnouncer weak when: JobEnd send: #onAnnouncement: to: aListener.
	anAnnouncer weak
		when: JobStart
		do: [:anAnnouncement | aListener onAnnouncement: anAnnouncement]
		for: aListener.
	aGraph := GtAnnouncerGraph forAnnouncer: anAnnouncer.
	self
		assert: (aGraph nodes
				select: [:each | each object isKindOf: FinalizationRegistryEntry]) size
		equals: 3.
	self assert: (aGraph edges
				contains: [:each | each isBackReference and: [each target object == aListener]]).
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: anElement).
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: aListener) not.
	^self
		scenario: 'Strong element and three weak listener subscriptions: plain registry'
		announcer: anAnnouncer
		element: anElement
		listener: aListener
]

{ #category : #examples }
GtAnnouncerGraphExamples >> plainRegistryStrongElementAndWeakListenerKeepsTheElementAlive [
	"Plain registry: anElement subscribes strongly, aListener weakly. If anAnnouncer and anElement become nil while aListener is still referenced, nothing is collected: aListener's global entry keeps its weak subscription, which keeps anAnnouncer, whose strong subscription keeps anElement (the red chain). When aListener becomes nil too, all three are collected after two garbage collections: the first fires the entry, the second collects. If only aListener becomes nil, it alone is collected, also after two garbage collections."
	<gtExample>
	| anAnnouncer anElement aListener aGraph |
	anAnnouncer := Announcer new.
	anElement := self element.
	aListener := self listener.
	anAnnouncer when: JobStart send: #onAnnouncement: to: anElement.
	anAnnouncer weak when: JobStart send: #onAnnouncement: to: aListener.
	aGraph := GtAnnouncerGraph forAnnouncer: anAnnouncer.
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: anAnnouncer).
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: anElement).
	self assert: (aGraph isKeptAliveByTheGlobalRegistry: aListener) not.
	^self
		scenario: 'Strong element and weak listener: plain registry'
		announcer: anAnnouncer
		element: anElement
		listener: aListener
]

{ #category : #private }
GtAnnouncerGraphExamples >> scenario: aString announcer: anAnnouncer element: anElement listener: aListener [
	^GtAnnouncerGraphScenario
		title: aString
		announcer: anAnnouncer
		participants: (Array with: anElement with: aListener)
]

{ #category : #accessing }
GtAnnouncerGraphExamples >> scenarios [
	^(self class gtExamples asArray collect: [:each | each run returnValue])
		sorted: [:first :second | first title <= second title]
]

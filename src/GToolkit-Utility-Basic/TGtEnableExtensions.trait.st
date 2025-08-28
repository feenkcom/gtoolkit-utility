"
I am a trait for singletons to manage whether extensions (eg gtActions and gtViews) are enabled or not).


"
Trait {
	#name : #TGtEnableExtensions,
	#instVars : [
		'extensionsEnabled'
	],
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Utility-Basic-Configuration'
}

{ #category : #'instance creation' }
TGtEnableExtensions classSide >> gtExtensionEnablingMenuFor: anAction [
	<gtClassAction>
	^ anAction dropdown
		icon: BrGlamorousVectorIcons hamburger;
		priority: 20;
		tooltip: 'ONHome Menu';
		content: [ :aButton | 
			BrGlamorousSimpleContextMenuContent new
				items: {'Enable extensions' -> [ self uniqueInstance enableExtensions ].
						'Disable extensions' -> [ self uniqueInstance disableExtensions ]};
				yourself ]
]

{ #category : #accessing }
TGtEnableExtensions >> disableExtensions [
	extensionsEnabled := false
]

{ #category : #accessing }
TGtEnableExtensions >> enableExtensions [
	extensionsEnabled := true
]

{ #category : #accessing }
TGtEnableExtensions >> extensionsEnabled [
	^ extensionsEnabled
]

{ #category : #initialization }
TGtEnableExtensions >> initialize [
	"The initialize method should perform one of:
		self enableExtensions
		self disableExtensions
	"
	self explicitRequirement
]

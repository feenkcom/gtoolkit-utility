Class {
	#name : #GtBulkShiftClassInstaller,
	#superclass : #ShiftClassInstaller,
	#classVars : [
		'Instances'
	],
	#category : #'GToolkit-Utility-ClassLoader'
}

{ #category : #installing }
GtBulkShiftClassInstaller class >> finishBulkInstaller [
	| todo |
	todo := Instances.
	Instances := nil.
	
	ProtoObject class removeSelector: #classInstaller.
	((todo collect: [ :each | each builder newClass ]) groupedBy: #superclass)
		keysAndValuesDo: [ :key :value | key notNil ifTrue: [ key subclasses: key subclasses , value asArray ] ].
	ShSmalltalkGlobalsEnvironment new organization
		bulkClassify:
			(todo
				collect:
					[ :each | 
					{each builder category.
						each builder newClass name} ]).
	
	todo do: [ :each | SystemAnnouncer uniqueInstance classAdded: each builder newClass inCategory: each builder category ].
	todo do: [ :each | each notifyChanges ].
	ProtoObject class removeSelector: #category
]

{ #category : #installing }
GtBulkShiftClassInstaller class >> startBulkInstaller [
	Instances := OrderedCollection new.
	
	ProtoObject class compile: 'classInstaller ^' , self name.
	ProtoObject class compile: 'category ^self basicCategory'.
]

{ #category : #building }
GtBulkShiftClassInstaller >> installSubclassInSuperclass: newClass [
	Instances isNil 
		ifTrue: [ super installSubclassInSuperclass: newClass ] 
		ifFalse: [ Instances add: self ]
]

{ #category : #notifications }
GtBulkShiftClassInstaller >> notifyChanges [
	Instances isNil ifTrue: [ super notifyChanges ]
]

{ #category : #notifications }
GtBulkShiftClassInstaller >> recategorize: newClass to: category [
	Instances isNil ifTrue: [ super recategorize: newClass to: category ] ifFalse: [ newClass basicCategory: category asSymbol ]
]

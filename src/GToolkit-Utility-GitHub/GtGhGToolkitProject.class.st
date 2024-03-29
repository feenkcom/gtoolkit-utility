"
{{gtClass:name=GtGhGToolkitProject}} models the gtoolkit repository from feenk GitHub organisation.
"
Class {
	#name : #GtGhGToolkitProject,
	#superclass : #GtGhProjectWithBaseline,
	#classInstVars : [
		'default'
	],
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #examples }
GtGhGToolkitProject class >> baselineDependencies [ 
	<gtExample>
	<noTest>
	
	^ self default baselineDependencies
]

{ #category : #examples }
GtGhGToolkitProject class >> baselinePackages [ 
	<gtExample>
	<noTest>
	
	^ self default baselinePackages
]

{ #category : #examples }
GtGhGToolkitProject class >> baselineProjects [ 
	<gtExample>
	<noTest>
	
	^ self default baselineProjects
]

{ #category : #examples }
GtGhGToolkitProject class >> baselineRepositories [ 
	<gtExample>
	<noTest>
	
	^ self default baselineRepositories
]

{ #category : #accessing }
GtGhGToolkitProject class >> default [
	<gtExample>
	
	^ default ifNil: [ 
		default := self new ]
]

{ #category : #examples }
GtGhGToolkitProject class >> externalRepositories [ 
	<gtExample>
	<noTest>
	
	^ self default externalRepositories
]

{ #category : #examples }
GtGhGToolkitProject class >> feenkForkedRepositories [ 
	<gtExample>
	<noTest>
	
	^ self default forkedRepositories
]

{ #category : #examples }
GtGhGToolkitProject class >> feenkOwnedRepositories [ 
	<gtExample>
	<noTest>
	
	^ self default ownedRepositories
]

{ #category : #cleaning }
GtGhGToolkitProject class >> resetDefault [ 
	default := nil
]

{ #category : #accessing }
GtGhGToolkitProject >> initialize [
	super initialize.
	
	organisation := GtGhFeenkOrganisation create.
	baselineModel := BaselineOfGToolkit 
		gtRlProjectWithRepository: BaselineOfGToolkit gtoolkitRepositorySpec.
]

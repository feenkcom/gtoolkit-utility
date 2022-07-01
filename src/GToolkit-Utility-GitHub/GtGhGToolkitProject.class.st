Class {
	#name : #GtGhGToolkitProject,
	#superclass : #Object,
	#instVars : [
		'feenkOrganisation',
		'baselineModel'
	],
	#classInstVars : [
		'default'
	],
	#category : #'GToolkit-Utility-GitHub'
}

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
	
	^ self default feenkForkedRepositories
]

{ #category : #examples }
GtGhGToolkitProject class >> feenkOwnedRepositories [ 
	<gtExample>
	<noTest>
	
	^ self default feenkOwnedRepositories
]

{ #category : #'instance creation' }
GtGhGToolkitProject class >> forGitHubOrganization: aFeenkOrganization [ 
	^ self new 
		feenkOrganisation: aFeenkOrganization
]

{ #category : #cleaning }
GtGhGToolkitProject class >> resetDefault [ 
	default := nil
]

{ #category : #accessing }
GtGhGToolkitProject >> baselineModel [

	^ baselineModel ifNil: [ 
		baselineModel := BaselineOfGToolkit 
			gtRlProjectWithRepository: BaselineOfGToolkit gtoolkitRepositorySpec ]
]

{ #category : #accessing }
GtGhGToolkitProject >> baselineRepositories [
	^ self baselineModel withAllRepositories
]

{ #category : #accessing }
GtGhGToolkitProject >> baselineRepositories2 [
	| organisationRepositories |

	organisationRepositories := self feenkOrganisation repositories.

	^ self baselineModel withAllRepositories collect: [ :aBaselineRepository |
			GtGhRepositoryWithBaseline new 
				gitHubRepository:1;
				baselineRepository: aBaselineRepository ]
]

{ #category : #accessing }
GtGhGToolkitProject >> externalRepositories [
	^ self baselineRepositories reject: [ :aRepository | 
		aRepository ownerName = 'feenkcom' ]
]

{ #category : #accessing }
GtGhGToolkitProject >> feenkForkedRepositories [
	| forkedGitHubRepositories |

	forkedGitHubRepositories := self feenkOrganisation forkedRepositories.
	^ self feenkRepositories select: [ :aRepository | 
		forkedGitHubRepositories 
			anySatisfy: [ :aGitHubRepository | 
				aGitHubRepository name = aRepository repositoryName ] ]	
]

{ #category : #accessing }
GtGhGToolkitProject >> feenkOrganisation [

	^ feenkOrganisation ifNil: [ 
		feenkOrganisation := GtGhFeenkOrganisation create ]
]

{ #category : #accessing }
GtGhGToolkitProject >> feenkOrganisation: anOrganisation [
	feenkOrganisation := anOrganisation 
]

{ #category : #accessing }
GtGhGToolkitProject >> feenkOwnedRepositories [
	| ownedGitHubRepositories |

	ownedGitHubRepositories := self feenkOrganisation ownedRepositories.
	^ self feenkRepositories select: [ :aRepository | 
		ownedGitHubRepositories 
			anySatisfy: [ :aGitHubRepository | 
				aGitHubRepository name = aRepository repositoryName ] ]	
]

{ #category : #accessing }
GtGhGToolkitProject >> feenkRepositories [
	^ self baselineRepositories select: [ :aRepository | 
		aRepository ownerName = 'feenkcom' ]
]

{ #category : #'gt - extensions' }
GtGhGToolkitProject >> gtViewExternalRepositoriesFor: aView [
	<gtView>
	
	^ aView list 
		title: 'External Repositories';
		priority: 20;
		items: [ self externalRepositories ]
]

{ #category : #'gt - extensions' }
GtGhGToolkitProject >> gtViewFeenkRepositoriesFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Feenk Repositories';
		priority: 10;
		items: [ self feenkOwnedRepositories ]
]

{ #category : #'gt - extensions' }
GtGhGToolkitProject >> gtViewForkedRepositoriesFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Forked Repositories';
		priority: 15;
		items: [ self feenkForkedRepositories ]
]

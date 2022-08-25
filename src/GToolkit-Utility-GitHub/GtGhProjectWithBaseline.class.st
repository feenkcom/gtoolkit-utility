"
{{gtClass:name=GtGhProjectWithBaseline}}  is currently the main entry point for exploring repositories loaded by a baseline using GitHub data. 

It can classify repositories loaded by the project into three main categorties:
- 
"
Class {
	#name : #GtGhProjectWithBaseline,
	#superclass : #Object,
	#instVars : [
		'organisation',
		'baselineModel'
	],
	#category : #'GToolkit-Utility-GitHub'
}

{ #category : #'instance creation' }
GtGhProjectWithBaseline class >> forGitHubOrganization: anOrganization [ 
	^ self new 
		gitHubOrganisation: anOrganization
]

{ #category : #'accessing - repositories' }
GtGhProjectWithBaseline >> baselineDependencies [
	^ self baselinePackages flatCollect: #outgoingDependencies
]

{ #category : #accessing }
GtGhProjectWithBaseline >> baselineModel [

	^ baselineModel
]

{ #category : #'accessing - repositories' }
GtGhProjectWithBaseline >> baselinePackages [
	^ self baselineModel allPackages 
]

{ #category : #'accessing - repositories' }
GtGhProjectWithBaseline >> baselineProjects [
	^ self baselineModel withAllChildProjects 
]

{ #category : #'accessing - repositories' }
GtGhProjectWithBaseline >> baselineRepositories [
	| organisationRepositoriesByFullName |

	organisationRepositoriesByFullName := (self gitHubOrganisation repositories
		collect: [ :aGitHubRepository | 
			aGitHubRepository fullName -> aGitHubRepository ]) asOrderedDictionary.

	^ self baselineModel withAllRepositories collect: [ :aBaselineRepository |
			GtGhRepositoryWithBaseline new 
				gitHubRepository: (organisationRepositoriesByFullName
					at: aBaselineRepository ownerName, '/', aBaselineRepository repositoryName
					ifAbsent: [ nil ]);
				baselineRepository: aBaselineRepository ]
]

{ #category : #'accessing - repositories' }
GtGhProjectWithBaseline >> externalRepositories [
	"Loaded repositories external to the organization containing the project."
	
	^ self baselineRepositories reject: [ :aRepository | 
		aRepository ownerName = self gitHubOrganisation loginName ]
]

{ #category : #'accessing - repositories' }
GtGhProjectWithBaseline >> forkedRepositories [
	"Loaded repositories forked in the organization containing the project."
	| forkedGitHubRepositories |

	forkedGitHubRepositories := self gitHubOrganisation forkedRepositories.
	^ self organizationRepositories select: [ :aRepository | 
		forkedGitHubRepositories 
			anySatisfy: [ :aGitHubRepository | 
				aGitHubRepository name = aRepository repositoryName ] ]	
]

{ #category : #accessing }
GtGhProjectWithBaseline >> gitHubOrganisation [

	^ organisation
]

{ #category : #accessing }
GtGhProjectWithBaseline >> gitHubOrganisation: anOrganization [

	organisation := anOrganization
]

{ #category : #'gt - extensions' }
GtGhProjectWithBaseline >> gtViewExternalRepositoriesFor: aView [
	<gtView>
	
	^ aView list 
		title: 'External Repositories';
		priority: 20;
		items: [ self externalRepositories ];
		itemText: [ :aRepository | aRepository loadSpecString ]
]

{ #category : #'gt - extensions' }
GtGhProjectWithBaseline >> gtViewForkedRepositoriesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Forked Repositories';
		priority: 15;
		items: [ self forkedRepositories ];
		column: 'Repo' text: [ :aRepository |
			aRepository loadSpecString ];
		column: 'Description' text: [ :aRepository | 
			aRepository gitHubDescription ]
]

{ #category : #'gt - extensions' }
GtGhProjectWithBaseline >> gtViewForkedRepositoriesStatusFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Forks Status';
		priority: 25;
		items: [ self forkedRepositories ];
		column: 'Repo' text: [ :aRepository |
			aRepository gitHubRepository fullName ];
		column: 'Parent' text: [ :aRepository |
			aRepository gitHubRepository forkedRepository fullName ];
		column: 'Loaded Branch'
			text: [ :aRepository | aRepository loadedBranchName ]
			width: 120;
		column: 'Parent Branch'
			text: [ :aRepository | aRepository defautBranchNameInParent ]
			width: 120;
		column: 'Status' do: [ :aColumn |
			aColumn 
				width: 100;
				cellStencil: [ 
					BrHorizontalPane new
						hMatchParent; 
						vFitContent;
						alignCenter ];
				dataBinder: [ :itemElement :aRepository | 
					| nodeIcon |
					nodeIcon := ((#(diverged behind) includes: aRepository branchDiffFromSelfToParent reverseStatus)
						ifTrue: [ BrGlamorousIcons redcircle ]
						ifFalse: [ BrGlamorousIcons greencircle ]).
					 
					itemElement
						removeChildren;
						addChild: nodeIcon asElement;
						addChild: (BrLabel new
							aptitude: BrGlamorousListLabelAptitude;
							text: aRepository branchDiffFromSelfToParent reverseStatus;
							alignCenterLeft;
							hMatchParent;
							vFitContent) ] ];
		column: 'Branch Change' text: [ :aRepository |
			aRepository branchDiffFromSelfToParent reverseDescription ]		
]

{ #category : #'gt - extensions' }
GtGhProjectWithBaseline >> gtViewOwnedRepositoriesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Owned Repositories';
		priority: 10;
		items: [ self ownedRepositories ];
		column: 'Repo' text: [ :aRepository |
			aRepository loadSpecString ];
		column: 'Description' text: [ :aRepository | 
			aRepository gitHubDescription ]
]

{ #category : #'accessing - repositories' }
GtGhProjectWithBaseline >> organizationRepositories [
	^ self baselineRepositories select: [ :aRepository | 
		aRepository ownerName = self gitHubOrganisation loginName ]
]

{ #category : #'accessing - repositories' }
GtGhProjectWithBaseline >> ownedRepositories [
	"Loaded repositories owned by the organization containing the project."
	| ownedGitHubRepositories |

	ownedGitHubRepositories := self gitHubOrganisation ownedRepositories.
	^ self organizationRepositories select: [ :aRepository | 
		ownedGitHubRepositories 
			anySatisfy: [ :aGitHubRepository | 
				aGitHubRepository name = aRepository repositoryName ] ]	
]

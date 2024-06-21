"
GtGitPullAndLoad will pull the latest code in to the repository and load it in to the image, discarding any changes that are in the image.

Typical usage:

```
GtGitPullAndLoad new
	ownerName: 'feenkcom';
	repositoryName: '<repository name>';
	mainBranchName: 'main';
	transport: #git;
	recover.
```
"
Class {
	#name : #GtGitPullAndLoad,
	#superclass : #GtGitRecovery,
	#instVars : [
		'ownerName',
		'transport',
		'repositoryDirectory'
	],
	#category : #'GToolkit-Utility-Git'
}

{ #category : #private }
GtGitPullAndLoad >> ensureRepository [
	| iceCreator newRepository dirExists |

	dirExists := self repositoryDirectory exists.
	dirExists ifTrue:
		[ IceRepository registry
			detect: [ :repo | repo location = self repositoryDirectory ]
			ifFound: [ :repo | repo origin url = self repositoryUrl
				ifTrue: [ ^ repo ]
				ifFalse: [ self error: 'Repository origin and location mismatch' ] ]
			ifNone: [] ].
	iceCreator := IceRepository repositoryClass creatorClass new
					remote: (IceGitRemote url: self repositoryUrl);
					location: self repositoryDirectory.
	newRepository := dirExists ifTrue: 
		[ iceCreator addLocalRepository ]
	ifFalse: 
		[ self unregisterCurrentRepository.
		iceCreator createRepository ].
	newRepository register.
	^ newRepository
]

{ #category : #initialize }
GtGitPullAndLoad >> initialize [

	super initialize.
	transport := #git.
]

{ #category : #accessing }
GtGitPullAndLoad >> ownerName [
	<return: #String>

	^ ownerName
]

{ #category : #accessing }
GtGitPullAndLoad >> ownerName: aString [

	ownerName := aString
]

{ #category : #actions }
GtGitPullAndLoad >> recover [
	"Move to the latest commit"

	"Retrieving the repository has the side-effect of creating it if required"
	self repository.
	"Don't worry about merge warnings, we'll be overwriting everything anyway."
	[ self mainBranch pull ]
		on: IceExperimentalFeature
		do: [ :ex | ex resume ].
	self mainBranch checkout.
]

{ #category : #accessing }
GtGitPullAndLoad >> repository [

	^ repository ifNil: [ repository := self ensureRepository ]
]

{ #category : #accessing }
GtGitPullAndLoad >> repositoryDirectory [

	^ repositoryDirectory ifNil: 
		[ repositoryDirectory := IceLibgitRepository repositoriesLocation
			/ ownerName
			/ repositoryName ]
]

{ #category : #accessing }
GtGitPullAndLoad >> repositoryUrl [

	^ String streamContents: [ :stream | 
		stream << (transport = #git
			ifTrue: [ 'git@github.com:' ]
			ifFalse: [ transport = #https
				ifTrue: [ 'https://github.com/' ]
				ifFalse: [ self error: 'unknown transport' ] ]).
		stream
			<< ownerName;
			nextPut: $/;
			<< repositoryName;
			<< '.git' ]
]

{ #category : #accessing }
GtGitPullAndLoad >> transport [
	<return: #Symbol>

	^ transport
]

{ #category : #accessing }
GtGitPullAndLoad >> transport: aSymbol [

	self
		assert: (#(https git) includes: aSymbol)
		description: 'transport is one of #https or #git'.

	transport := aSymbol
]

{ #category : #private }
GtGitPullAndLoad >> unregisterCurrentRepository [

	IceRepository registry
		detect: [ :repo | repo name = repositoryName ]
		ifFound: [ :repo | IceRepository registry remove: repo ]
		ifNone: []
]

Extension { #name : #TAsyncFuture }

{ #category : #'*GToolkit-Utility-StackOverflowFuture' }
TAsyncFuture >> processStackOverflowChecker [
	^ AsyncProcessStackOverflowCheckerFuture future: self
]

{ #category : #'*GToolkit-Utility-StackOverflowFuture' }
TAsyncFuture >> processStackOverflowCheckerDepth: anInteger [
	^ AsyncProcessStackOverflowCheckerFuture future: self depth: anInteger
]

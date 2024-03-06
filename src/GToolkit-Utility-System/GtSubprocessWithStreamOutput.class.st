"
I am a {{gtClass:GtSubprocessWithInMemoryOutput}}. 
I am a convenience wrapper to write an output in a memory and also to another stream, e.g., `stdout` and `stderr`.
I am useful for cases when we need to see an execution output also in a terminal, for example in a context of `CI` builds. 
"
Class {
	#name : #GtSubprocessWithStreamOutput,
	#superclass : #GtSubprocessWithInMemoryOutput,
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
GtSubprocessWithStreamOutput >> initializeStdStreams [
	stdoutStream ifNil: [ stdoutStream := String new writeStream ].
	stderrStream ifNil: [ stderrStream := String new writeStream ]
]

{ #category : #accessing }
GtSubprocessWithStreamOutput >> stderrStream: aWriteStream [
	stderrStream := aWriteStream
]

{ #category : #accessing }
GtSubprocessWithStreamOutput >> stdoutStream: aWriteStream [
	stdoutStream := aWriteStream
]

{ #category : #'initialization ' }
GtSubprocessWithStreamOutput >> withInMemoryAndNonInteractiveTranscript [
	self
		stdoutStream: (GtSpreadWriteStream inMemoryAnd: NonInteractiveTranscript stdout);
		stderrStream: (GtSpreadWriteStream inMemoryAnd: NonInteractiveTranscript stderr)
]

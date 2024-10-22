Class {
	#name : #GtOsSystemInfoExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Utility-System-Examples'
}

{ #category : #examples }
GtOsSystemInfoExamples >> findPing [
	"Demonstrate using {{gtMethod:GtOsSystemInfo>>findExecutable:}}.
	Ping is usually available on Linux, Mac and Windows"
	<gtExample>
	| ping |

	ping := GtOsSystemInfo current findExecutable: 'ping'.
	self assert: (ping basename asLowercase includesSubstring: 'ping')
]

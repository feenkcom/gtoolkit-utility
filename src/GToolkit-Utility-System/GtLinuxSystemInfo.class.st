Class {
	#name : #GtLinuxSystemInfo,
	#superclass : #GtOsSystemInfo,
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
GtLinuxSystemInfo class >> platformName [

	^ 'unix'
]

{ #category : #'process info' }
GtLinuxSystemInfo >> currentProcessId [

	^ LibC uniqueInstance currentProcessId
]

{ #category : #'cpu info' }
GtLinuxSystemInfo >> freeMemory [
	"Answer the free RAM of the host"

	^ (self colonSeparatedGet: 'MemFree' fromFile: '/proc/meminfo') asNumber * 1024
]

{ #category : #'cpu info' }
GtLinuxSystemInfo >> numberOfCores [
	"Answer the number of cores on the host"

	"/proc/cpuinfo may not contain information about an amount of `cpu cores`.
	therefore we fallback to 1"
	^ [ (self
		colonSeparatedGet: 'cpu cores'
		fromFile: '/proc/cpuinfo') asNumber ]
	on: KeyNotFound do: [ :anError | 1 ]
]

{ #category : #'cpu info' }
GtLinuxSystemInfo >> physicalMemory [
	"Answer the RAM capacity of the host in bytes"

	^ (self colonSeparatedGet: 'MemTotal' fromFile: '/proc/meminfo') asNumber * 1024
]

{ #category : #'as yet unclassified' }
GtLinuxSystemInfo >> userName [

	^ OSEnvironment current 
		at: 'USERNAME'
		ifAbsent: [ nil ]
]

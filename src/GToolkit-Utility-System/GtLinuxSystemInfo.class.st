Class {
	#name : #GtLinuxSystemInfo,
	#superclass : #GtOsSystemInfo,
	#category : #'GToolkit-Utility-System'
}

{ #category : #accessing }
GtLinuxSystemInfo class >> platformName [

	^ #unix
]

{ #category : #'cpu info' }
GtLinuxSystemInfo >> freeMemory [
	"Answer the free RAM of the host"

	^ (self colonSeparatedGet: 'MemFree' from: '/proc/meminfo') asNumber * 1024
]

{ #category : #'cpu info' }
GtLinuxSystemInfo >> numberOfCores [
	"Answer the number of cores on the host"

	^ (self colonSeparatedGet: 'cpu cores' from: '/proc/cpuinfo') asNumber
]

{ #category : #'cpu info' }
GtLinuxSystemInfo >> physicalMemory [
	"Answer the RAM capacity of the host in bytes"

	^ (self colonSeparatedGet: 'MemTotal' from: '/proc/meminfo') asNumber * 1024
]
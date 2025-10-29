Extension { #name : #CompiledCode }

{ #category : #'*GToolkit-Utility-Basic' }
CompiledCode >> gtAccessedSlots [
	^ self methodClass allSlots select: [ :aSlot | self accessesSlot: aSlot ]
]

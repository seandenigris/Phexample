Extension { #name : #CompiledMethod }

{ #category : #'*phexample' }
CompiledMethod >> messageSendBeforeLastShouldCurrentPc: currentPc [
	"If the next instruction to be executed is currentPC, then this method
	 walks back to the last should and finds the call before. For example,
	 consider the method
		Stack new isEmpty should be true.
	 Here, we're trying to find isEmpty, given that currentPc points to the execution of true."
	| scanner sends |
	scanner := InstructionStream on: self.
	sends := Stack new.
	scanner scanFor: [ :bytecode | 
		sends push: scanner selectorToSendOrSelf.
		scanner pc >= currentPc ].
	[	sends isEmpty ifTrue: [ ^nil ].
		sends pop == #should ] whileFalse.
	sends top isSymbol ifFalse: [ ^nil ].
	sends top p.
	^sends top.
]

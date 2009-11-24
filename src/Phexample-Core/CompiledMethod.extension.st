Extension { #name : #CompiledMethod }

{ #category : #'*Phexample' }
CompiledMethod >> messageSendBeforeLastShouldCurrentPc: currentPc [
	"If the next instruction to be executed is currentPC, then this method
	 walks back to the last should and finds the call before. For example,
	 consider the method
		Stack new isEmpty should be true.
	 Here, we're trying to find isEmpty, given that currentPc points to the execution of true."
	| scanner queue|
	scanner := InstructionStream on: self.
	queue := OrderedCollection new.
	scanner scanFor: [ :bytecode | 
		| last prelast |
		scanner pc = currentPc ifTrue: [|msg|
			  msg := queue fourth = #should ifTrue: [queue fifth ] ifFalse: [queue fourth].
			  ^ msg = scanner ifTrue: [^nil] ifFalse: [msg]  ].
		queue addFirst: scanner selectorToSendOrSelf.
		false	"keep scanning" ].
	^ self error: 'Couldn''t find it.'
]

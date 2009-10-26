Extension { #name : #BlockClosure }

{ #category : #'*Phexample-Core' }
BlockClosure >> shouldRaise: errorClass [

	self on: Exception do: [ :error |
		error should be isKindOf: errorClass.
	]
	

]

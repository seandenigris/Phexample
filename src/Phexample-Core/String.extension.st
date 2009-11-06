Extension { #name : #String }

{ #category : #'*Phexample' }
String >> asSentence [
	^ String streamContents: [:s |
		self do: [:ch |
			ch isUppercase ifTrue: [ s space ].
			s nextPut: ch asLowercase.
		]]
]

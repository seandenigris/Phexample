Extension { #name : #Object }

{ #category : #'*PhexamplePharo' }
Object >> phAsText [
	^ (self respondsTo: #asText)
		ifTrue: [ self asText ]
		ifFalse: [ self asString asText ]
]

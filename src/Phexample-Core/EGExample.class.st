Class {
	#name : #EGExample,
	#superclass : #TestCase,
	#category : #'Phexample-Core'
}

{ #category : #accessing }
EGExample class >> allTestSelectors [
	|selectors|
	
	selectors := self allSelectors clone .
	selectors removeAll: TestCase allSelectors.
	^ selectors select: [:each | 
		('should*' match: each) and: [each numArgs isZero]]
			
]

{ #category : #dependencies }
EGExample >> given: anExampleName [ 
	^self perform: anExampleName
]

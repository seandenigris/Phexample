Class {
	#name : #TestExample,
	#superclass : #TestCase,
	#category : #'Phexample-Core'
}

{ #category : #accessing }
TestExample class >> allTestSelectors [
	|selectors|
	
	selectors := self allSelectors clone .
	selectors removeAll: TestCase allSelectors.
	^ selectors select: [:each | 
		('should*' match: each) and: [each numArgs isZero]]
			
]

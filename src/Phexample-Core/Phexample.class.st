"
Phexample, because well designed tests expand on one another.

Examples see ForExampleStack. 

by Adrian Kuhn and Niko Schwarz  
"
Class {
	#name : #Phexample,
	#superclass : #TestCase,
	#instVars : [
		'givenNotGiven'
	],
	#category : #'Phexample-Core'
}

{ #category : #accessing }
Phexample class >> allTestSelectors [
	|selectors|
	selectors := self allSelectors clone.
	selectors removeAll: Phexample allSelectors.
	^ selectors select: [:each | 
		('should*' match: each) and: [each numArgs isZero]]
			
]

{ #category : #private }
Phexample >> cleanUpInstanceVariables [
	| names |
	names := self class allInstVarNames asOrderedCollection.
	names removeAll: Phexample allInstVarNames.
	names do: [ :name | self instVarNamed: name put: nil ]
]

{ #category : #dependencies }
Phexample >> given: anExampleName [ 
	self should respondTo: anExampleName.
	^ [ self perform: anExampleName ] 
		on: Exception
		do: [ :ex | 
			givenNotGiven := true.
			ex signal ]
]

{ #category : #private }
Phexample >> shouldPass [
	^ super shouldPass and: [ (givenNotGiven = true) not ]
]

"
Phexample, because well designed tests expand on one another.

Examples see ForExampleStack.

by Adrian Kuhn and Niko Schwarz  
"
Class {
	#name : #Phexample,
	#superclass : #TestCase,
	#instVars : [
		'shouldNotPass'
	],
	#category : #'Phexample-Core'
}

{ #category : #accessing }
Phexample class >> allTestSelectors [
	|selectors|
	selectors := self allSelectors clone.
	selectors removeAll: EGExample allSelectors.
	^ selectors select: [:each | 
		('should*' match: each) and: [each numArgs isZero]]
			
]

{ #category : #private }
Phexample >> cleanUpInstanceVariables [
	| names |
	names := self class allInstVarNames asOrderedCollection.
	names removeAll: EGExample allInstVarNames.
	names do: [ :name | self instVarNamed: name put: nil ]
]

{ #category : #dependencies }
Phexample >> given: anExampleName [	
	^[ self perform: anExampleName ] on: Exception do: [ :ex | 
		shouldNotPass := true.
		ex signal ]
]

{ #category : #private }
Phexample >> shouldPass [
	
	^super shouldPass and: [ (shouldNotPass = true) not ]
]

Class {
	#name : #EGExample,
	#superclass : #TestCase,
	#instVars : [
		'shouldNotPass',
		'cache'
	],
	#category : #'PhExample-Core'
}

{ #category : #accessing }
EGExample class >> allTestSelectors [
	|selectors|
	selectors := self allSelectors clone.
	selectors removeAll: EGExample allSelectors.
	^ selectors select: [:each | 
		('should*' match: each) and: [each numArgs isZero]]
			
]

{ #category : #private }
EGExample >> cleanUpInstanceVariables [
	| names |
	names := self class allInstVarNames asOrderedCollection.
	names removeAll: EGExample allInstVarNames.
	names do: [ :name | self instVarNamed: name put: nil ]
]

{ #category : #dependencies }
EGExample >> given: anExampleName [ 
	|cached|
	cache
		at: anExampleName
		ifAbsent: [|result| result := ( [self perform: anExampleName]
				on: Exception
				do: [:ex | 
					shouldNotPass := true.
					cache at: anExampleName put: cache.
					ex signal]).
				cache at: anExampleName put: result.
				^ result clone
				].
	cached := cache at: anExampleName.
	cached == cache ifTrue: [shouldNotPass := true. self error: 'Producer failed!'].
	^ cached clone.
	
]

{ #category : #private }
EGExample >> setUp [
	super setUp.
	cache := Dictionary new.
]

{ #category : #private }
EGExample >> shouldPass [
	
	^super shouldPass and: [ (shouldNotPass = true) not ]
]

{ #category : #private }
EGExample >> tearDown [
	super tearDown.
	cache := nil.
]

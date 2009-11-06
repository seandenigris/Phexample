Class {
	#name : #TestMethod,
	#superclass : #Object,
	#instVars : [
		'testCase',
		'selector',
		'result'
	],
	#category : #'Phexample-Glamour'
}

{ #category : #accessing }
TestMethod >> = anObject [
	^(anObject respondsTo: #selector) and: [
		self selector = anObject selector ]
]

{ #category : #'as yet unclassified' }
TestMethod >> allProducers [
	|set block|
	set := Set new.
	block := [:p | set add: p. p collectProducers: block ].
	self collectProducers: block.
	^set
]

{ #category : #accessing }
TestMethod >> collectProducers: aBlock [ 
	RBParseTreeSearcher new
		matches: '`@object given: `#symbol'
		do: [ :node :answer | 
			aBlock value: (TestMethod new
				testCase: self testCase;
				selector: node arguments first value) ];
		executeTree: self parseTree initialAnswer: nil.
]

{ #category : #accessing }
TestMethod >> hash [
	^ self selector hash
]

{ #category : #accessing }
TestMethod >> parseTree [
	^ (self testCase methodDict at: self selector) parseTree 
]

{ #category : #accessing }
TestMethod >> printOn: aStream [
|sentence split|
sentence := self selector asSentence.
split:='\ ' asRegex split: sentence.
split first = 'test' ifTrue: [sentence := ' ' join: (split last: split size-1 ) ].
aStream nextPutAll: sentence
]

{ #category : #'as yet unclassified' }
TestMethod >> producers [
	|set|
	set := Set new.
	self collectProducers: [ :p | set add: p ].
	^set
]

{ #category : #accessing }
TestMethod >> result [
	^ result
]

{ #category : #accessing }
TestMethod >> result: anObject [
	result := anObject
]

{ #category : #accessing }
TestMethod >> run [
	|tc tr|
	tc := testCase new.
	tr := TestResult new.
	tc setTestSelector: self selector.
	tr runCase: tc.
	^ tr
]

{ #category : #accessing }
TestMethod >> run: aTestResult [
	|tc tr|
	tr := aTestResult.
	tc := testCase new.
	tc setTestSelector: self selector.
	tr runCase: tc.
	^ tr
]

{ #category : #accessing }
TestMethod >> selector [
	^ selector
]

{ #category : #accessing }
TestMethod >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
TestMethod >> testCase [
	^ testCase
]

{ #category : #accessing }
TestMethod >> testCase: anObject [
	testCase := anObject
]

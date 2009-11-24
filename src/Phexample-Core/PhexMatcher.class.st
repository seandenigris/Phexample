"
A PhexMatcher is the sort of thing that works out if your example behaves properly or not. Most of the magic happens in expect:using:. 

Please notice that = works unlike in most classes. Therefore, do not store me in a collection!

Instance Variables
	state:		the items matched so far
	value:		

state
	- xxxxx

value
	- xxxxx

"
Class {
	#name : #PhexMatcher,
	#superclass : #Object,
	#instVars : [
		'value',
		'state'
	],
	#category : #'Phexample-Core'
}

{ #category : #documentation }
PhexMatcher class >> rewriteRules [
	^RBParseTreeRewriter new
		replace: 'self assert: [ `@expression ]' with: 'self assert: `@expression';
		replace: 'self deny: `@expression' with: 'self assert: `@expression not';
		replace: 'self assert: `@value = `@expected' with: '`@value should = `@expected';
		replace: 'self assert: `@value ~= `@expected' with: '`@value should not = `@expected';
		replace: 'self assert: `@value > `@expected' with: '`@value should > `@expected';
		replace: 'self assert: `@value < `@expected' with: '`@value should < `@expected';
		replace: 'self assert: `@value >= `@expected' with: '`@value should >= `@expected';
		replace: 'self assert: `@value <= `@expected' with: '`@value should <= `@expected';
		replace: 'self assert: (`@value isKindOf: `@type)' with: '`@value should beKindOf: `@type';
		replace: 'self assert: `@expression isNil' with: '`@expression should be isNil';
		replace: 'self assert: `@expression notNil' with: '`@expression should be notNil';
		replace: 'self assert: `@expression `test not' with: '`@expression should not be `test'
			when: [:node | node arguments first receiver selector matchesRegex: '(is|has|not).+|atEnd' ];
		replace: 'self assert: `@expression `test' with: '`@expression should be `test'
			when: [:node | node arguments first selector matchesRegex: '(is|has|not).+|atEnd' ];
		replace: 'self assert: (`@collection includes: `@element) not' with: '`@collection should not be includes: `@element';
		replace: 'self assert: (`@collection includes: `@element)' with: '`@collection should be includes: `@element';
		yourself.
	

]

{ #category : #creation }
PhexMatcher class >> with: anObject [ 
	^ self new setValue: anObject
]

{ #category : #expecting }
PhexMatcher >> < expected [
	^self expect: expected using: #<
]

{ #category : #expecting }
PhexMatcher >> <= expected [
	^self expect: expected using: #<=
]

{ #category : #expecting }
PhexMatcher >> = expected [
	self expect: expected using: #=.
	self isShould ifTrue: [ self expectSameHash: expected ].
	^nil
	
]

{ #category : #expecting }
PhexMatcher >> > expected [
	^self expect: expected using: #>
]

{ #category : #expecting }
PhexMatcher >> >= expected [
	^self expect: expected using: #>=
]

{ #category : #'expecting-boolean' }
PhexMatcher >> be [
	state := state copyWith: #be
]

{ #category : #'expecting-boolean' }
PhexMatcher >> beFalse [
	^self be false
]

{ #category : #'expecting-reflection' }
PhexMatcher >> beKindOf: expectedClass [ 
	^self 
		expect: [ value isKindOf: expectedClass ]
		describeShould: 
			[ 'expected kind of <1p> but got instance of <2p> (using isKindOf)' 
				expandMacrosWith: expectedClass
				with: value class ]
		describeShouldNot: 
			[ 'expected not to get kind of <1p> but got instance of <2p> (using isKindOf)' 
				expandMacrosWith: expectedClass
				with: value class ]
]

{ #category : #'expecting-boolean' }
PhexMatcher >> beTrue [
	^self be true
]

{ #category : #'expecting-string' }
PhexMatcher >> beginWith: aPrefix [
	^self expect: aPrefix using: #beginsWith: 
	
]

{ #category : #'expecting-change' }
PhexMatcher >> change: aBlock [ 
	| before after |
	before := aBlock value.
	value value.
	after := aBlock value.
	before should not = after.	
]

{ #category : #'expecting-change' }
PhexMatcher >> change: aBlock from: before to: after [
	aBlock value should = before.
	value value.
	aBlock value should = after.
]

{ #category : #'expecting-string' }
PhexMatcher >> endWith: aSuffix [
	^self expect: aSuffix using: #endsWith: 
	
]

{ #category : #private }
PhexMatcher >> expect: aBlock describeShould: shouldBlock describeShouldNot: shouldNotBlock [
	self isShould ifTrue: [
		aBlock value ifFalse: [TestFailure signal: shouldBlock value].
		^nil ].
	self isShouldNot ifTrue: [
		aBlock value ifTrue: [TestFailure signal: shouldNotBlock value].
		^nil ].
	self error: 'illegal state ', state asString
]

{ #category : #private }
PhexMatcher >> expect: expected using: aSymbol [
	^self expect: [ value perform: aSymbol with: expected ]
  		describeShould: [ ('expected <1p> but got <2p> (using <3s>)'
								expandMacrosWith: expected
								with: value
								with: aSymbol) ]
  		describeShouldNot: [ ('expected not to get <1p> but got <2p> (using <3s>)'
								expandMacrosWith: expected
								with: value
								with: aSymbol) ]

]

{ #category : #private }
PhexMatcher >> expectSameHash: expected [
	value hash = expected hash ifFalse: [
		TestFailure signal: ('expected same hash for <1p> and <2p> (using hash implied by =)'
			expandMacrosWith: value
			with: expected) ].
	^nil
]

{ #category : #private }
PhexMatcher >> expectedUnknownMessageToReturn: expected [ 
	state := state copyWithout: #be.
	^self expect: [ value = expected ]
		describeShould: [ 'expected #<1s> to be <2p>' 
				expandMacrosWith: self findNameOfUnknownMessage
				with: expected ]
		describeShouldNot: [ 'did not expect #<1s> to be <2p>' 
				expandMacrosWith: self findNameOfUnknownMessage
				with: expected ]
	
]

{ #category : #'expecting-boolean' }
PhexMatcher >> false [
	state = #(be) ifTrue: [ ^self expectedUnknownMessageToReturn: false].
	state = #(not be) ifTrue: [ ^self expectedUnknownMessageToReturn: false ].
	Error signal: 'Illegal state ', state asString
]

{ #category : #private }
PhexMatcher >> findNameOfUnknownMessage [
	"	1. walk up the stack until we are outside of this instance.
		2. collect all sent message from bytecode up to program counter.
		3. drop messages until #should and return previous. "
	| context scanner sends |
	context := thisContext.
	[	context := context sender. 
		context receiver == self ] whileTrue.
	scanner := InstructionStream on: context method.
	sends := Stack new.
	scanner scanFor: [ :bytecode | 
		sends push: scanner selectorToSendOrSelf.
		scanner pc >= context pc ].
	[	sends isEmpty ifTrue: [ ^'<unknown>' ].
		sends pop == #should ] whileFalse.
	sends top isSymbol ifFalse: [ ^'<unknown>' ].
	^sends top
]

{ #category : #private }
PhexMatcher >> hash [
	self error: 'Don''t put a matcher into a dictionary. It does not behave ordinarily on ='
]

{ #category : #private }
PhexMatcher >> initialize [ 
 state := #()
]

{ #category : #private }
PhexMatcher >> isShould [
	^state = #()
]

{ #category : #private }
PhexMatcher >> isShouldNot [
	^state = #(not)
]

{ #category : #'expecting-string' }
PhexMatcher >> matchRegex: regexString [
	
	^self expect: regexString using: #matchesRegex:
]

{ #category : #expecting }
PhexMatcher >> not [
	state := state copyWith: #not
]

{ #category : #'expecting-reflection' }
PhexMatcher >> respondTo: aSelector [
	^self 
		expect: [ value respondsTo: aSelector ]
		describeShould: 
			[ 'expected <1p> to respond to <2p> (using respondsTo:)' 
				expandMacrosWith: value 
			   with: aSelector ]
		describeShouldNot: 
			[ 'expected <1p> not to respond to <2p> (using respondsTo:)' 
				expandMacrosWith: value 
			   with: aSelector ]
]

{ #category : #'expecting-performance' }
PhexMatcher >> runWithin: aDuration [ 
	^ self
		expect: [[value value.
			true]
				valueWithin: aDuration
				onTimeout: [false]]
		describeShould: ['expected to run within <1p> but took longer' expandMacrosWith: aDuration]
		describeShouldNot: ['expected to take longer then <1p> but was faster' expandMacrosWith: aDuration]
]

{ #category : #private }
PhexMatcher >> setValue: anObject [
	value := anObject 
]

{ #category : #'expecting-error' }
PhexMatcher >> signal: errorClass [ 
	
	value on: Exception do: [ :ex |
		^ex should beKindOf: errorClass ].
	TestFailure signal: ('Should raise <1p> but was none' expandMacrosWith: errorClass).
]

{ #category : #'expecting-error' }
PhexMatcher >> signal: errorClass withMessageText: message [

	value on: Exception do: [ :ex | 
		ex should beKindOf: errorClass.
		^message isBlock 
			ifTrue: [ message value: ex messageText ]
			ifFalse: [ ^ex messageText should = message ]].
	TestFailure signal: ('Should raise <1p> but was none' expandMacrosWith: errorClass).
]

{ #category : #'expecting-boolean' }
PhexMatcher >> true [
	state = #(be) ifTrue: [ ^self expectedUnknownMessageToReturn: true].
	state = #(not be) ifTrue: [ ^self expectedUnknownMessageToReturn: true ].
	Error signal: 'Illegal state ', state asString
]

{ #category : #expecting }
PhexMatcher >> ~= expected [
	self expect: expected using: #~=.
	self isShouldNot ifTrue: [ self expectSameHash: expected ].
	^nil
	
	
]

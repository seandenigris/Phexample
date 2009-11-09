Class {
	#name : #PhexMatcher,
	#superclass : #Object,
	#instVars : [
		'value',
		'state'
	],
	#category : #'Phexample-Core'
}

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
	^self expect: expected using: #=
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

{ #category : #private }
PhexMatcher >> doesNotUnderstand: aMessage [
	state = #(be) ifTrue: [
		TestCase new assert: (aMessage sendTo: value) equals: true.
		^self ].
	state = #(not be) ifTrue: [
		TestCase new assert: (aMessage sendTo: value) equals: false.
		^self ].
	super doesNotUnderstand: aMessage
	
]

{ #category : #'expecting-string' }
PhexMatcher >> endWith: aSuffix [
	^self expect: aSuffix using: #endsWith: 
	
]

{ #category : #private }
PhexMatcher >> expect: aBlock describeShould: shouldBlock describeShouldNot: shouldNotBlock [
	state = #() ifTrue: [
		aBlock value ifFalse: [TestFailure signal: shouldBlock value].
		^nil ].
	state = #(not) ifTrue: [
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

{ #category : #'expecting-boolean' }
PhexMatcher >> false [
	state = #(be) ifTrue: [ state := #(). ^self = false ].
	state = #(not be) ifTrue: [ state := #(). ^self ~= false ].
	Error signal: 'Illegal state ', state asString
]

{ #category : #private }
PhexMatcher >> initialize [ 
 state := #()
]

{ #category : #'expecting-string' }
PhexMatcher >> matchRegex: regexString [
	
	^self expect: regexString using: #matchesRegex:
]

{ #category : #expecting }
PhexMatcher >> not [
	state := state copyWith: #not
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
	state = #(be) ifTrue: [ state := #(). ^self = true ].
	state = #(not be) ifTrue: [ state := #(). ^self ~= true ].
	Error signal: 'Illegal state ', state asString
]

{ #category : #expecting }
PhexMatcher >> ~= expected [
	^self expect: expected using: #~=
]

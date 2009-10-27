Class {
	#name : #EGMatcher,
	#superclass : #Object,
	#instVars : [
		'value',
		'state'
	],
	#category : #'Phexample-Core'
}

{ #category : #creation }
EGMatcher class >> with: anObject [ 
	^ self new setValue: anObject
]

{ #category : #testing }
EGMatcher >> < expected [
	^self expect: expected using: #<
]

{ #category : #testing }
EGMatcher >> <= expected [
	^self expect: expected using: #<=
]

{ #category : #testing }
EGMatcher >> = expected [
	^self expect: expected using: #=
]

{ #category : #testing }
EGMatcher >> > expected [
	^self expect: expected using: #>
]

{ #category : #testing }
EGMatcher >> >= expected [
	^self expect: expected using: #>=
]

{ #category : #testing }
EGMatcher >> be [
	state := state copyWith: #be
]

{ #category : #testing }
EGMatcher >> beKindOf: aClass [
	
	self privateAssert: (value isKindOf: aClass) 
		ifError: [ 'Expected class <1p> but was <2p>' expandMacrosWith: aClass with: value class ]  
	
]

{ #category : #private }
EGMatcher >> doesNotUnderstand: aMessage [
  state = #(be) ifTrue: [
		TestCase new assert: (aMessage sendTo: value) equals: true.
		^self ].
  state = #(not be) ifTrue: [
		TestCase new assert: (aMessage sendTo: value) equals: false.
		^self ].
	super doesNotUnderstand: aMessage
	
]

{ #category : #private }
EGMatcher >> expect: expected using: aSelector [ 
	^self 
		expect: expected 
		usingBlock: [ :a :b | a perform: aSelector with: b ] 
		description: aSelector 
	
]

{ #category : #private }
EGMatcher >> expect: expected usingBlock: aComparison description: aString [  
	(aComparison value: value value: expected)
		ifTrue: [state = #(#not )
				ifTrue: [TestFailure
						signal: ('did not expect <1p> but was <2p> (using negated <3s>)'
								expandMacrosWith: expected
								with: value
								with: aString)]]
		ifFalse: [state = #()
				ifTrue: [TestFailure
						signal: ('expected <1p> but was <2p> (using <3s>)'
								expandMacrosWith: expected
								with: value
								with: aString)]].
	^nil
]

{ #category : #testing }
EGMatcher >> false [
	state = #(be) ifTrue: [ state := #(). ^self = false ].
	state = #(not be) ifTrue: [ state := #(). ^self ~= false ].
	Error signal: 'Illegal state ', state asString
]

{ #category : #private }
EGMatcher >> initialize [ 
 state := #()
]

{ #category : #testing }
EGMatcher >> match: regexString [
	^self 
		expect: regexString 
		usingBlock: [ :a :b | a matchesRegex: regexString ] 
		description: 'regex match' 
]

{ #category : #testing }
EGMatcher >> not [
	state := state copyWith: #not
]

{ #category : #private }
EGMatcher >> privateAssert: aBoolean ifError: errorMessageBlock [

	aBoolean ifFalse: [ TestFailure signal: errorMessageBlock value ].
	^nil "cannot return self since we are a proto-object only"
]

{ #category : #private }
EGMatcher >> setValue: anObject [
	value := anObject 
]

{ #category : #testing }
EGMatcher >> signal: errorClass [ 
	
	value on: Exception do: [ :ex |
		^ex should beKindOf: errorClass ].
	TestFailure signal: ('Should raise <1p> but was none' expandMacrosWith: errorClass).
]

{ #category : #testing }
EGMatcher >> signal: errorClass withMessageText: message [

	value on: Exception do: [ :ex | 
		ex should beKindOf: errorClass.
		^message isBlock 
			ifTrue: [ message value: ex messageText ]
			ifFalse: [ ^ex messageText should = message ]].
	TestFailure signal: ('Should raise <1p> but was none' expandMacrosWith: errorClass).
]

{ #category : #testing }
EGMatcher >> true [
	state = #(be) ifTrue: [ state := #(). ^self = true ].
	state = #(not be) ifTrue: [ state := #(). ^self ~= true ].
	Error signal: 'Illegal state ', state asString
]

{ #category : #testing }
EGMatcher >> ~= expected [
	^self expect: expected using: #~=
]

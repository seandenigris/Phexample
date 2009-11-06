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

{ #category : #testing }
PhexMatcher >> < expected [
	^self expect: expected using: #<
]

{ #category : #testing }
PhexMatcher >> <= expected [
	^self expect: expected using: #<=
]

{ #category : #testing }
PhexMatcher >> = expected [
	^self expect: expected using: #=
]

{ #category : #testing }
PhexMatcher >> > expected [
	^self expect: expected using: #>
]

{ #category : #testing }
PhexMatcher >> >= expected [
	^self expect: expected using: #>=
]

{ #category : #testing }
PhexMatcher >> be [
	state := state copyWith: #be
]

{ #category : #testing }
PhexMatcher >> beKindOf: aClass [
	
	self privateAssert: (value isKindOf: aClass) 
		ifError: [ 'Expected class <1p> but was <2p>' expandMacrosWith: aClass with: value class ]  
	
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

{ #category : #private }
PhexMatcher >> expect: expected using: aSelector [ 
	^self 
		expect: expected 
		usingBlock: [ :a :b | a perform: aSelector with: b ] 
		description: aSelector 
	
]

{ #category : #private }
PhexMatcher >> expect: expected usingBlock: aComparison description: aString [  
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
PhexMatcher >> false [
	state = #(be) ifTrue: [ state := #(). ^self = false ].
	state = #(not be) ifTrue: [ state := #(). ^self ~= false ].
	Error signal: 'Illegal state ', state asString
]

{ #category : #private }
PhexMatcher >> initialize [ 
 state := #()
]

{ #category : #testing }
PhexMatcher >> match: regexString [
	^self 
		expect: regexString 
		usingBlock: [ :a :b | a matchesRegex: regexString ] 
		description: 'regex match' 
]

{ #category : #testing }
PhexMatcher >> not [
	state := state copyWith: #not
]

{ #category : #private }
PhexMatcher >> privateAssert: aBoolean ifError: errorMessageBlock [

	aBoolean ifFalse: [ TestFailure signal: errorMessageBlock value ].
	^nil "cannot return self since we are a proto-object only"
]

{ #category : #private }
PhexMatcher >> setValue: anObject [
	value := anObject 
]

{ #category : #testing }
PhexMatcher >> signal: errorClass [ 
	
	value on: Exception do: [ :ex |
		^ex should beKindOf: errorClass ].
	TestFailure signal: ('Should raise <1p> but was none' expandMacrosWith: errorClass).
]

{ #category : #testing }
PhexMatcher >> signal: errorClass withMessageText: message [

	value on: Exception do: [ :ex | 
		ex should beKindOf: errorClass.
		^message isBlock 
			ifTrue: [ message value: ex messageText ]
			ifFalse: [ ^ex messageText should = message ]].
	TestFailure signal: ('Should raise <1p> but was none' expandMacrosWith: errorClass).
]

{ #category : #testing }
PhexMatcher >> true [
	state = #(be) ifTrue: [ state := #(). ^self = true ].
	state = #(not be) ifTrue: [ state := #(). ^self ~= true ].
	Error signal: 'Illegal state ', state asString
]

{ #category : #testing }
PhexMatcher >> ~= expected [
	^self expect: expected using: #~=
]

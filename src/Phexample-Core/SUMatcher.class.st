Class {
	#name : #SUMatcher,
	#superclass : #ProtoObject,
	#instVars : [
		'value',
		'state'
	],
	#category : #'Phexample-Core'
}

{ #category : #creation }
SUMatcher class >> with: anObject [ 
	^ self new setValue: anObject
]

{ #category : #testing }
SUMatcher >> = expected [
	state = #(not) ifTrue: [ 
		^self privateAssert: value ~= expected
		ifError: [ 'Did not expect <1p> but was <2p>.' expandMacrosWith: expected with: value ]].
	state = #() ifTrue: [ 
		^self privateAssert: value = expected
		ifError: [ 'Expected <1p> but was <2p>.' expandMacrosWith: expected with: value ]].
	Error signal: 'Illegal state: ', state asString
]

{ #category : #testing }
SUMatcher >> be [
	state := state copyWith: #be
]

{ #category : #private }
SUMatcher >> comparingStringBetween: expected and: actual [
	^String streamContents: [:stream |
		stream
			nextPutAll: 'Expected ';
			nextPutAll: (expected printStringLimitedTo: 10);
			nextPutAll: ' but was ';
			nextPutAll: (actual printStringLimitedTo: 10);
			nextPutAll: '.'
		]
]

{ #category : #private }
SUMatcher >> doesNotUnderstand: aMessage [
  state = #(be) ifTrue: [
		TestCase new assert: (aMessage sendTo: value) equals: true.
		^self ].
  state = #(not be) ifTrue: [
		TestCase new assert: (aMessage sendTo: value) equals: false.
		^self ].
	super doesNotUnderstand: aMessage
	
]

{ #category : #private }
SUMatcher >> initialize [ 
 state := #()
]

{ #category : #testing }
SUMatcher >> not [
	state := state copyWith: #not
]

{ #category : #private }
SUMatcher >> privateAssert: aBoolean ifError: errorMessageBlock [

	aBoolean ifFalse: [ AssertionFailure signal: errorMessageBlock value ].
	^nil "cannot return self since we are a proto-object only"
]

{ #category : #private }
SUMatcher >> setValue: anObject [
	value := anObject 
]

{ #category : #testing }
SUMatcher >> signal: errorClass [ 
	
	value on: Exception do: [ :error |
		error should be isKindOf: errorClass ]
]

{ #category : #testing }
SUMatcher >> signal: errorClass withMessageText: aString [ 
	value 
		on: Exception
		do: 
			[ :error | 
			error should be isKindOf: errorClass.
			error messageText should = aString ]
]

{ #category : #testing }
SUMatcher >> ~= expected [
	self not; = expected
]

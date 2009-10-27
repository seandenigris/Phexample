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
EGMatcher >> = expected [
	state = #(not) ifTrue: [ 
		^self privateAssert: value ~= expected
		ifError: [ 'Did not expect <1p> but was <2p>' expandMacrosWith: expected with: value ]].
	state = #() ifTrue: [ 
		^self privateAssert: value = expected
		ifError: [ 'Expected <1p> but was <2p>' expandMacrosWith: expected with: value ]].
	Error signal: 'Illegal state: ', state asString
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
EGMatcher >> comparingStringBetween: expected and: actual [
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
EGMatcher >> doesNotUnderstand: aMessage [
  state = #(be) ifTrue: [
		TestCase new assert: (aMessage sendTo: value) equals: true.
		^self ].
  state = #(not be) ifTrue: [
		TestCase new assert: (aMessage sendTo: value) equals: false.
		^self ].
	super doesNotUnderstand: aMessage
	
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
EGMatcher >> signal: errorClass withMessageText: aString [ 

	value on: Exception do: [ :ex | 
		ex should beKindOf: errorClass.
		^ex messageText should = aString ].
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
	self not; = expected
]

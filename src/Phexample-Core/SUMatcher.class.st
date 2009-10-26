Class {
	#name : #SUMatcher,
	#superclass : #Object,
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

{ #category : #comparing }
SUMatcher >> = expected [
  TestCase new assert: value equals: expected.
]

{ #category : #testing }
SUMatcher >> be [
	state := state copyWith: #be
]

{ #category : #testing }
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
SUMatcher >> setValue: anObject [
	value := anObject 
]

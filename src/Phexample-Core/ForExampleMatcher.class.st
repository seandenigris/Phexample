Class {
	#name : #ForExampleMatcher,
	#superclass : #EGExample,
	#category : #'PhExample-Core'
}

{ #category : #examples }
ForExampleMatcher >> shouldBeEmpty [
  |set|
	set := Set new. 
	set should be isEmpty.
	^set
]

{ #category : #examples }
ForExampleMatcher >> shouldBeEven [
  4 should be even
]

{ #category : #examples }
ForExampleMatcher >> shouldBeOdd [
  5 should be odd
]

{ #category : #examples }
ForExampleMatcher >> shouldEqualFive [
	(2 + 3) should = 5
]

{ #category : #examples }
ForExampleMatcher >> shouldIncludeFoo [
  |set|
	set := #(foo bar qux). 
	set should be includes: #foo.
	^set
]

{ #category : #examples }
ForExampleMatcher >> shouldNotBeEven [ 
  5 should not be even
]

{ #category : #examples }
ForExampleMatcher >> shouldNotBeOdd [
  6 should not be odd
]

{ #category : #examples }
ForExampleMatcher >> shouldNotEqualSeven [
	(2 + 3) should not = 7
]

{ #category : #examples }
ForExampleMatcher >> shouldSignal [

	[ 5 should = 6 ] should signal: TestFailure.
]

{ #category : #examples }
ForExampleMatcher >> shouldSignalIfFiveShouldNotEqualFive [

	[ 5 should not = 5 ] should signal: TestFailure.
]

{ #category : #examples }
ForExampleMatcher >> shouldSignalIfSignalMissing [

	[ [ 5 should = 5 ] should signal: TestFailure ] should 
		signal: TestFailure 
		withMessageText: 'Should raise TestFailure but was none'
]

{ #category : #examples }
ForExampleMatcher >> shouldSignalIfSignalWrong [

	[ [ self error ] should signal: TestFailure ] should 
		signal: TestFailure 
		withMessageText: 'Expected class TestFailure but was Error'
]

{ #category : #examples }
ForExampleMatcher >> shouldSignalWithMessage [
	
	[ 5 should = 6 ] should 
		signal: TestFailure
		withMessageText: 'Expected 6 but was 5'
]

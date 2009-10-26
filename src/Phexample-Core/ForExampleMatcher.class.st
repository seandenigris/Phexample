Class {
	#name : #ForExampleMatcher,
	#superclass : #TestExample,
	#category : #'Phexample-Core'
}

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldBeEmpty [
  |set|
	set := Set new. 
	set should be isEmpty.
	^set
]

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldBeEven [
  4 should be even
]

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldBeOdd [
  5 should be odd
]

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldEqualFive [
	(2 + 3) should = 5
]

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldIncludeFoo [
  |set|
	set := #(foo bar qux). 
	set should be includes: #foo.
	^set
]

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldNotEqualSeven [
	(2 + 3) should not = 7
]

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldSignal [

	[ 5 should = 6 ] should signal: AssertionFailure.
]

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldSignalIfFiveShouldNotEqualFive [

	[ 5 should not = 5 ] should signal: AssertionFailure.
]

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldSignalWithMessage [
	[ 5 should = 6 ] should 
		signal: AssertionFailure
		withMessageText: 'Expected 6 but was 5.'
]

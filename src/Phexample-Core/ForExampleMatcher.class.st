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
ForExampleMatcher >> shouldBeFive [
	(2+3) should = 5
]

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldBeOdd [
  5 should be odd
]

{ #category : #'as yet unclassified' }
ForExampleMatcher >> shouldIncludeFoo [
  |set|
	set := #(foo bar qux). 
	set should includes: #foo.
	^set
]

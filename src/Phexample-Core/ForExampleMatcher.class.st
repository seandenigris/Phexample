Class {
	#name : #ForExampleMatcher,
	#superclass : #Phexample,
	#category : #'Phexample-Test'
}

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldBeEmpty [
  |set|
	set := Set new. 
	set should be isEmpty.
	^set
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldBeEmpty2 [
  |set|
	set := Set new. 
	set isEmpty should be true.
	^set
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldBeEven [
  4 should be even
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldBeFalse [
  |set|
	set := Set with: 42. 
	set isEmpty should be false.
	^set
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldBeKindOf [
	'hello' should beKindOf: String
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldBeKindOfSuperclass [
	'hello' should beKindOf: Collection
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldBeOdd [
  5 should be odd
]

{ #category : #'examples-expecting-string' }
ForExampleMatcher >> shouldBeginWith [
	'abcdef' should beginWith: 'abc'.
]

{ #category : #'examples-expecting-change' }
ForExampleMatcher >> shouldChange [
	| list |
	list := OrderedCollection new.
	[ list add: nil ] should change: [ list size ]
]

{ #category : #'examples-expecting-change' }
ForExampleMatcher >> shouldChangeFromTo [
	| list |
	list := OrderedCollection new add: nil; add: nil; yourself.
	[ list add: nil ] should change: [ list size ] from: 2 to: 3.
]

{ #category : #'examples-expecting-string' }
ForExampleMatcher >> shouldEndWith [
	'abcdef' should endWith: 'def'.
]

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldEqualFive [
	(2 + 3) should = 5
]

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldGreaterThan [
  6 should > 5 
]

{ #category : #examples }
ForExampleMatcher >> shouldHaveTestsInThisClass [
	self class allTestSelectors should not be isEmpty.
	self class allTestSelectors size should > 20.
	
	
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldIncludeFoo [
  |set|
	set := #(foo bar qux). 
	set should be includes: #foo.
	^set
]

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldLesserThan [
  5 should < 6
]

{ #category : #'examples-expecting-string' }
ForExampleMatcher >> shouldMatchRegex [
	'aaa' should matchRegex: 'a*'.
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldNotBeEmpty [
  |set|
	set := Set new. 
	set isEmpty should be true.
	^set
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldNotBeEven [
  5 should not be even
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldNotBeFalse [
  |set|
	set := Set new. 
	set isEmpty should not be false.
	^set
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldNotBeKindOfSubclass [
	'hello' should not beKindOf: Symbol
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldNotBeOdd [
  6 should not be odd
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldNotBeTrue [
  |set|
	set := Set with: 42. 
	set isEmpty should not be true.
	^set
]

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldNotEqualSeven [
	(2 + 3) should not = 7
]

{ #category : #examples }
ForExampleMatcher >> shouldNotHaveTestsInEGExample [
	Phexample allTestSelectors should be isEmpty.
	
	
]

{ #category : #'examples-expecting-string' }
ForExampleMatcher >> shouldNotMatchRegex [
	'aaa' should not matchRegex: 'ba*'.
]

{ #category : #examples }
ForExampleMatcher >> shouldReturnNilWhenTesting [
	(5 should = 5) isNil should be true

]

{ #category : #'examples-expecting-performance' }
ForExampleMatcher >> shouldRunWithin [
	[ "makes the Kessel Run in less than twelve parsecs" ] should runWithin: 10 milliSeconds 
]

{ #category : #'examples-expecting-error' }
ForExampleMatcher >> shouldSignal [

	[ 5 should = 6 ] should signal: TestFailure.
]

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldSignalIfFiveShouldNotEqualFive [

	[ 5 should not = 5 ] should signal: TestFailure.
]

{ #category : #'examples-expecting-error' }
ForExampleMatcher >> shouldSignalIfSignalMissing [

	[ [ 5 should = 5 ] should signal: TestFailure ] should 
		signal: TestFailure 
		withMessageText: 'Should raise TestFailure but was none'
]

{ #category : #'examples-expecting-error' }
ForExampleMatcher >> shouldSignalIfSignalWrong [

	[ [ self error ] should signal: TestFailure ] should 
		signal: TestFailure 
		"withMessageText: 'Expected class TestFailure but was Error'"
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldSignalWhenBeKindOfFails [
	[ 'hello' should beKindOf: Number ] should signal: TestFailure
]

{ #category : #'examples-expecting-string' }
ForExampleMatcher >> shouldSignalWhenBeginsWithFails [
	[ 'abcdef' should beginWith: 'abcX' ] should 
		signal: TestFailure 
		withMessageText: 'expected ''abcX'' but got ''abcdef'' (using beginsWith:)' 
]

{ #category : #'examples-expecting-string' }
ForExampleMatcher >> shouldSignalWhenEndWithFails [
	[ 'abcdef' should endWith: 'Xdef' ] should 
		signal: TestFailure 
		withMessageText: 'expected ''Xdef'' but got ''abcdef'' (using endsWith:)' 
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldSignalWhenFalseIsNotFalse [
  |set|
	set := Set with: 42. 
	[ set isEmpty should not be false ] should signal: TestFailure.
	^set
]

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldSignalWhenGreaterThanFails [
  [ 5 should > 6 ] should signal: TestFailure withMessageText: 'expected 6 but got 5 (using >)'.
  [ 4 should > 4 ] should signal: TestFailure withMessageText: 'expected 4 but got 4 (using >)'.
]

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldSignalWhenLesserThanFails [
  [ 6 should < 5 ] should signal: TestFailure withMessageText: 'expected 5 but got 6 (using <)'.
  [ 4 should < 4 ] should signal: TestFailure withMessageText: 'expected 4 but got 4 (using <)'.
]

{ #category : #'examples-expecting-string' }
ForExampleMatcher >> shouldSignalWhenMatchRegexFails [
	[ 'aaa' should matchRegex: 'ba*' ] should 
		signal: TestFailure 
		withMessageText: 'expected ''ba*'' but got ''aaa'' (using matchesRegex:)'
]

{ #category : #'examples-expecting-string' }
ForExampleMatcher >> shouldSignalWhenNotMatchRegexFails [
	[ 'aaa' should not matchRegex: 'a*' ] should 
		signal: TestFailure 
		withMessageText: 'expected not to get ''a*'' but got ''aaa'' (using matchesRegex:)'
]

{ #category : #'examples-expecting-performance' }
ForExampleMatcher >> shouldSignalWhenRunWithinFails [
	[ [ (Delay forMilliseconds: 20) wait ] should runWithin: 10 milliSeconds ] should signal: TestFailure
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldSignalWhenTrueIsNotTrue [
  |set|
	set := Set new. 
	[ set isEmpty should not be true ] should signal: TestFailure.
	^set
]

{ #category : #'examples-expecting-error' }
ForExampleMatcher >> shouldSignalWithMessage [
	
	[ 5 should = 6 ] should 
		signal: TestFailure
		withMessageText: 'expected 6 but got 5 (using =)'
]

{ #category : #'examples-expecting-error' }
ForExampleMatcher >> shouldSignalWithMessageBlock [
	
	[ 5 should = 6 ] should 
		signal: TestFailure
		withMessageText: [ :m | 
			m should beKindOf: String.
			m isEmpty should not be true.
			m should = 'expected 6 but got 5 (using =)'.
		]
]

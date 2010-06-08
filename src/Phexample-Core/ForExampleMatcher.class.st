Class {
	#name : #ForExampleMatcher,
	#superclass : #Phexample,
	#category : #'Phexample-Test'
}

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldBeFalse [
  (Set with: 42) isEmpty should beFalse.
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldBeKindOf [
	'hello' should beKindOf: String
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldBeKindOfSuperclass [
	'hello' should beKindOf: Collection
]

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldBeSame [
	[ self should beSameAs: self ] value should = nil.
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldBeTrue [
	Set new isEmpty should beTrue.

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

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldContainNameOfBooleanPropertyInMessageTextWhenFailing [
	[ nil notNil should beTrue ] should
		signal: TestFailure
		withMessageText: 'expected #notNil to be true'
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

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldHandlePathologicCaseOfBooleanPropertyWhenFailing [
	[ nil should beTrue ] should
		signal: TestFailure
		withMessageText: 'expected #<unknown> to be true'
]

{ #category : #examples }
ForExampleMatcher >> shouldHaveTestsInThisClass [
	self class allTestSelectors isEmpty should not be true.
	self class allTestSelectors size should > 20.
	
	
]

{ #category : #'examples-expecting-collections' }
ForExampleMatcher >> shouldInclude [
	#(foo bar) should include: #foo
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldIncludeFoo [
	(#(foo bar qux) includes: #foo) should beTrue.

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
ForExampleMatcher >> shouldNotBeTrue [
  	(Set with: 42) isEmpty should not beTrue.
]

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldNotEqualSeven [
	(2 + 3) should not = 7
]

{ #category : #'examples-expecting-collections' }
ForExampleMatcher >> shouldNotInclude [
	#(foo bar) should not include: #qux
]

{ #category : #'examples-expecting-string' }
ForExampleMatcher >> shouldNotMatchRegex [
	'aaa' should not matchRegex: 'ba*'.
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldNotOffByOneWhenFindingNameOfUnknownMessage [
	[ #() isEmpty should be false should ] " kinda artifical example, 
		but exercises the off-by-one nature of the PC which points after
		#false when looking for the message name, ie we must  make sure
		that we dont search to far which would yield #false instead of
		the correct #isEmpty message."
		should signal: TestFailure
		withMessageText: 'expected #isEmpty to be false'
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldNotRespondTo [
	Object new should not respondTo: #zork
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldRespondTo [
	Object new should respondTo: #yourself
]

{ #category : #examples }
ForExampleMatcher >> shouldReturnNilWhenTesting [
	[ 5 should = 5 ] value should = nil 
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

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldSignalWhenBeFalseFails [
	[ Set new isEmpty should beFalse ] should
		signal: TestFailure
		withMessageText: 'expected #isEmpty to be false'
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldSignalWhenBeKindOfFails [
	[ 'hello' should beKindOf: Number ] should signal: TestFailure
]

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldSignalWhenBeSameFails [
	[ 'string' copy should beSameAs: 'string' copy ] 
		should signal: TestFailure 
		withMessageText: 'expected ''string'' but got ''string'' (using ==)'
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldSignalWhenBeTrueFails [
	[ (Set with: 42) isEmpty should beTrue ] should
		signal: TestFailure
		withMessageText: 'expected #isEmpty to be true'
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

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldSignalWhenGreaterThanFails [
  [ 5 should > 6 ] should signal: TestFailure withMessageText: 'expected 6 but got 5 (using >)'.
  [ 4 should > 4 ] should signal: TestFailure withMessageText: 'expected 4 but got 4 (using >)'.
]

{ #category : #'examples-expecting-collections' }
ForExampleMatcher >> shouldSignalWhenIncludeFails [
	[ #(foo bar) should include: #qux ] should signal: TestFailure
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

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldSignalWhenNotBeFalseFails [
	[ (Set with: 42) isEmpty should not beFalse ] should
		signal: TestFailure
		withMessageText: 'did not expect #isEmpty to be false'
]

{ #category : #'examples-expecting-boolean' }
ForExampleMatcher >> shouldSignalWhenNotBeTrueFails [
	[ Set new isEmpty should not beTrue ] should
		signal: TestFailure
		withMessageText: 'did not expect #isEmpty to be true'
]

{ #category : #'examples-expecting-collections' }
ForExampleMatcher >> shouldSignalWhenNotIncludeFails [
	[ #(foo bar) should not include: #foo ] should signal: TestFailure
]

{ #category : #'examples-expecting-string' }
ForExampleMatcher >> shouldSignalWhenNotMatchRegexFails [
	[ 'aaa' should not matchRegex: 'a*' ] should 
		signal: TestFailure 
		withMessageText: 'expected not to get ''a*'' but got ''aaa'' (using matchesRegex:)'
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldSignalWhenNotRespondToFails [
	[ Object new should not respondTo: #yourself ] should
		signal: TestFailure
		withMessageText: 'expected an Object not to respond to #yourself (using respondsTo:)' 
]

{ #category : #'examples-expecting-reflection' }
ForExampleMatcher >> shouldSignalWhenRespondToFails [
	[ Object new should respondTo: #zork ] should
		signal: TestFailure
		withMessageText: 'expected an Object to respond to #zork (using respondsTo:)' 
]

{ #category : #'examples-expecting-performance' }
ForExampleMatcher >> shouldSignalWhenRunWithinFails [
	[ [ (Delay forMilliseconds: 20) wait ] should runWithin: 10 milliSeconds ] should signal: TestFailure
]

{ #category : #'examples-expecting-error' }
ForExampleMatcher >> shouldSignalWhenSignalWithMessageTextFails [
	[ [ self error: 'foo' ] should 
		signal: Error 
		withMessageText: 'bar' ] on: TestFailure
		do: [ :ex | 
			ex messageText should = 'expected ''bar'' but got ''foo'' (using =)' ]
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

{ #category : #'examples-expecting' }
ForExampleMatcher >> shouldTestForSameHashWhenExpectingEqualValues [
	| factory probe p |
	factory := ClassFactoryForTestCase new.
	probe := factory 
		newSubclassOf: Object 
		instanceVariableNames: 'counter'
		classVariableNames: ''.
	probe compile: 'initialize counter := 0'.
	probe compile: 'hash ^counter := counter + 1'.
	probe compile: 'printOn: stream stream nextPutAll: ''probe'''.
	p := probe new.
	p hash should = 1.
	p hash should = 2.
	p hash should = 3.
	[ p should = p ] should signal: TestFailure
		withMessageText: 'expected same hash for probe and probe (using hash implied by =)'.
	[ p should not ~= p ] should signal: TestFailure 
		withMessageText: 'expected same hash for probe and probe (using hash implied by =)'.
	factory cleanUp.


]

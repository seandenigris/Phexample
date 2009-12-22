Class {
	#name : #PhexampleTest,
	#superclass : #TestCase,
	#category : #'Phexample-Test'
}

{ #category : #'as yet unclassified' }
PhexampleTest class >> allTestSelectors [ 
	^self selectors select: [ :each | each beginsWith: 'should' ] 
]

{ #category : #examples }
PhexampleTest >> shouldExecuteExampleMethod [
	| factory class testcase hasRun result |
	factory := ClassFactoryForTestCase new.
	class := factory newSubclassOf: Phexample instanceVariableNames: 'action' classVariableNames: ''.
	class compile: 'shouldRun action value'.
	class compile: 'action: aBlock action := aBlock'.
	testcase := class selector: #shouldRun.
	testcase action: [ hasRun := true ].
	result := testcase run. 
	result tests size should = 1.
	result passed size should = 1.
	hasRun should be true.
]

{ #category : #examples }
PhexampleTest >> shouldHaveGivenAsResource [
	Phexample resources should include: Given 
]

{ #category : #examples }
PhexampleTest >> shouldNotHaveTestsInPhexample [
	Phexample allTestSelectors isEmpty should be true.
	
	
]

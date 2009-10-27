Class {
	#name : #ForExampleStack,
	#superclass : #EGExample,
	#category : #'Phexample-Core'
}

{ #category : #examples }
ForExampleStack >> shouldBeEmpty [
	|ary|
	ary := Stack new.
	ary should be isEmpty.
	ary size should = 0.
	^ary
]

{ #category : #examples }
ForExampleStack >> shouldFailWhenPopEmpty [
	| stack |
	stack := self given: #shouldBeEmpty.
	[ stack pop ] should signal: Error withMessageText: 'this stack is empty'.
]

{ #category : #examples }
ForExampleStack >> shouldPopElement [
	| stack |
	stack := self given: #shouldPushElement.
	stack pop should = 42.
	stack should be isEmpty.
	stack size should = 0.
]

{ #category : #examples }
ForExampleStack >> shouldPushElement [
	| stack |
	stack := self given: #shouldBeEmpty.
	stack push: 42.
	stack should not be isEmpty.
	stack size should = 1.
	stack top should = 42.
	^ stack
]

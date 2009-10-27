Class {
	#name : #ForExampleStack,
	#superclass : #EGExample,
	#category : #'Phexample-Core'
}

{ #category : #examples }
ForExampleStack >> shouldBeEmpty [
	| stack |
	stack := Stack new.
	stack should be isEmpty.
	stack size should = 0.
	^ stack
]

{ #category : #examples }
ForExampleStack >> shouldFailWhenPopEmpty [
	| stack |
	stack := self given: #shouldBeEmpty.
	[ stack pop ] should signal: Error withMessageText: 'this stack is empty'.
]

{ #category : #examples }
ForExampleStack >> shouldLastInFirstOut [
	| stack |
	stack := self given: #shouldPushMoreElements.
	stack pop should = 13.
	stack pop should = 7.
	stack pop should = 42.
	stack should be isEmpty.
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

{ #category : #examples }
ForExampleStack >> shouldPushMoreElements [
	| stack |
	stack := self given: #shouldPushElement.
	stack push: 7.
	stack push: 13.
	stack should not be isEmpty.
	stack size should = 3.
	stack top should = 13.
	^stack
]

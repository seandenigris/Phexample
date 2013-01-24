Class {
	#name : #PhexampleTodoTest,
	#superclass : #Phexample,
	#category : #'Phexample-Test'
}

{ #category : #'as yet unclassified' }
PhexampleTodoTest >> shouldSupportTodo [
	self should do: 'a real test'.
	self should testFor: 'something'.
]

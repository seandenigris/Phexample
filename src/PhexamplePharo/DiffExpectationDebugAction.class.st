Class {
	#name : #DiffExpectationDebugAction,
	#superclass : #DebugAction,
	#category : #PhexamplePharo
}

{ #category : #registration }
DiffExpectationDebugAction class >> actionType [
	<debuggingAction>
]

{ #category : #testing }
DiffExpectationDebugAction >> appliesToDebugger: aDebugger [
	^ aDebugger session context methodClass = PhexMatcher
]

{ #category : #accessing }
DiffExpectationDebugAction >> defaultLabel [

	^  'Diff'
]

{ #category : #accessing }
DiffExpectationDebugAction >> defaultOrder [

	^ 1
]

{ #category : #actions }
DiffExpectationDebugAction >> executeAction [
	
	| expected actual |
	expected := self interruptedContext sender arguments first.
	actual := self interruptedContext receiver value.
	(DiffMorph from: expected phAsText to: actual phAsText) openInWindow.
]

{ #category : #accessing }
DiffExpectationDebugAction >> id [

	^ #diffExpectation
]

Class {
	#name : #Given,
	#superclass : #TestResource,
	#instVars : [
		'cache'
	],
	#category : #'Phexample-Core'
}

{ #category : #dependencies }
Given >> at: testMethod ifAbsentPut: resultBlock [
	^(cache h includesKey: testMethod)
		ifTrue: [ cache removeKey: testMethod ]
		ifFalse: [ cache at: testMethod put: resultBlock value ]

]

{ #category : #dependencies }
Given >> consumeReturnValueAt: testMethod [
	^(cache includesKey: testMethod)
		ifTrue: [ cache removeKey: testMethod ]
		ifFalse: [ testMethod perform: testMethod selector ]
]

{ #category : #dependencies }
Given >> produceReturnValueAt: testMethod [
	cache at: testMethod ifAbsentPut: [ testMethod perform: testMethod selector ]
]

{ #category : #fixture }
Given >> setUp [
	cache := Dictionary new.
]

{ #category : #fixture }
Given >> tearDown [
    cache := nil
]

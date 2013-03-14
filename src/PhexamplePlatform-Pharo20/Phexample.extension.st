Extension { #name : #Phexample }

{ #category : #'*PhexamplePlatform-Pharo20' }
Phexample classSide >> selectorIncludesShould: aSelector [
	^ aSelector includesSubstring: 'should' caseSensitive: false
]

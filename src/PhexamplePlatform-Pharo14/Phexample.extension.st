Extension { #name : #Phexample }

{ #category : #'*PhexamplePlatform-Pharo14' }
Phexample classSide >> selectorIncludesShould: aSelector [
	^ aSelector includesSubString: 'should' caseSensitive: false
]

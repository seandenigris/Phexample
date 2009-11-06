Extension { #name : #GLMSTPackage }

{ #category : #'*Phexample-Glamour' }
GLMSTPackage classSide >> testPackagesOn: anEnvironment [
	|set|
	set:= ((anEnvironment categories collect: [:name | name readStream upTo: $-]) asSet asSortedCollection) .
	set := set select: [:name | |p| p:=PackageInfo named: name. p classes anySatisfy: [:e | e inheritsFrom: TestCase]].
	^ set
			collect: [:name | self named: name environment: anEnvironment]
]

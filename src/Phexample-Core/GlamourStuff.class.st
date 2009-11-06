Class {
	#name : #GlamourStuff,
	#superclass : #Object,
	#category : #'Phexample-Glamour'
}

{ #category : #'as yet unclassified' }
GlamourStuff class >> doStuff [
|browser|
browser := GLMTableLayoutBrowser new.
browser row: [:row|row column: #packages ;
	column: #classes ;
	column: #tests ].
	browser row:  #testResults.
browser title: 'TestRunner'.
browser showOn: #classes; 
	from: #packages ;
	using: [
		browser list 
			display: [:package | 
				package allClasses collect: [:el | 
					Smalltalk at: el name] thenSelect: [:el | el inheritsFrom: TestCase ]]]. 
browser showOn: #tests ; from: #classes ; using: [ 
	browser list 
		beMultiple;
		display: [:class |  
			class allTestSelectors collect: [:e | 
				TestMethod new testCase: class ; selector: e
			] ]].
browser showOn: #testResults ; from: #tests ; using: [
	browser text 
		display: [:testMethods ||tr| tr := TestResult new. testMethods do: [:el|el run: tr].tr ];
		title: 'Results'.
	browser mondrian
		painting: [:view :testMethods  | |p| 
			p:=Set withAll: testMethods.
			testMethods do: [:el|p addAll: el allProducers]. 
			view shape label text: [:each| each asString].
			view nodes: p . 
			view edges: p from: [:each | each ] toAll: [:each | each producers].
			view dominanceTreeLayout ];
		title: 'Dependencies'
		].	
(browser openOn: (GLMSTPackage testPackagesOn: GLMSTModel defaultEnvironment)) 
]

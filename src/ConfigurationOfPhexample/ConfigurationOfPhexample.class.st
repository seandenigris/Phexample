"
(ConfigurationOfPhexample project version: #stable) load
"
Class {
	#name : #ConfigurationOfPhexample,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfPhexample
}

{ #category : #'development support' }
ConfigurationOfPhexample class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfPhexample class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfPhexample class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfPhexample class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemtalksystems.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfPhexample class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfPhexample class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfPhexample class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfPhexample class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfPhexample class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfPhexample class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfPhexample >> baseline10: spec [
	<version: '1.0-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://www.smalltalkhub.com/mc/Phexample/Phexample/main'.
		spec package: 'Phexample'. ].

]

{ #category : #baselines }
ConfigurationOfPhexample >> baseline12: spec [
	<version: '1.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://www.smalltalkhub.com/mc/Phexample/Phexample/main'.
		spec package: 'Phexample' ].

	spec for: #squeak do: [
		spec package: 'Phexample' with: [spec requires: 'Regex-Core'].
		spec package: 'PhexamplePlatform-Pharo14' with: [spec requires: 'Phexample'].
		spec package: 'Pharo-Compatibility' with: [
			spec repository: 'http://ss3.gemstone.com/ss/Scratchpad-fbs'].
		spec package: 'Regex-Core' with: [
			spec repository: 'http://ss3.gemstone.com/ss/Pharo20']].

	spec for: #'pharo1.x' do: [
		spec package: 'PhexamplePlatform-Pharo14' with: [spec requires: 'Phexample'] ].
	
	spec for: #'pharo2.x' do: [
		spec package: 'PhexamplePlatform-Pharo20' with: [spec requires: 'Phexample'] ].
]

{ #category : #accessing }
ConfigurationOfPhexample >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfPhexample >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.2-baseline'.

]

{ #category : #accessing }
ConfigurationOfPhexample >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfPhexample >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '2.1'.

]

{ #category : #versions }
ConfigurationOfPhexample >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'initial version working well for Pharo 2.0'.
		spec author: 'StefanMarr'.
		spec timestamp: '2/8/2013 11:46'.
		spec package: 'Phexample' with: 'Phexample-StefanMarr.67'. ].

]

{ #category : #versions }
ConfigurationOfPhexample >> version11: spec [
	<version: '1.1' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'initial version working well for Pharo 1.4'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '2/10/2013 17:46'.
		spec package: 'Phexample' with: 'Phexample-StephaneDucasse.68'. ].

]

{ #category : #versions }
ConfigurationOfPhexample >> version12: spec [
	<version: '1.2' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'separated out platform-specific code'.
		spec author: 'StefanMarr'.
		spec timestamp: '3/14/2013 13:55'.
		spec package: 'Phexample' with: 'Phexample-StefanMarr.70'. ].

	spec for: #squeak do: [
		spec package: 'PhexamplePlatform-Pharo14' with: 'PhexamplePlatform-Pharo14-StefanMarr.1'.
		spec package: 'Pharo-Compatibility' with: 'Pharo-Compatibility-fbs.2'.
		spec package: 'Regex-Core' with: 'Regex-Core-MarcusDenker.22'].

	spec for: #'pharo1.x' do: [
		spec package: 'PhexamplePlatform-Pharo14' with: 'PhexamplePlatform-Pharo14-StefanMarr.1'].
	
	spec for: #'pharo2.x' do: [
		spec package: 'PhexamplePlatform-Pharo20' with: 'PhexamplePlatform-Pharo20-StefanMarr.1'
	].

]

{ #category : #versions }
ConfigurationOfPhexample >> version20: spec [
	<version: '2.0' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.0'.
		spec author: 'SeanDeNigris'.
		spec timestamp: '9/25/2014 15:41'.
		spec package: 'Phexample' with: 'Phexample-SeanDeNigris.73'. ].

	spec for: #'squeak' do: [
		spec 
			package: 'Phexample';
			package: 'PhexamplePlatform-Pharo14';
			package: 'Pharo-Compatibility';
			package: 'Regex-Core'. ].

	spec for: #'pharo1.x' do: [
		spec package: 'PhexamplePlatform-Pharo14'. ].

	spec for: #'pharo2.x' do: [
		spec package: 'PhexamplePlatform-Pharo20'. ].

]

{ #category : #versions }
ConfigurationOfPhexample >> version21: spec [
	<version: '2.1' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.1'.
		spec author: 'SeanDeNigris'.
		spec timestamp: '5/27/2015 23:27'.
		spec package: 'Phexample' with: 'Phexample-SeanDeNigris.74'. ].

	spec for: #'squeak' do: [
		spec 
			package: 'Phexample';
			package: 'PhexamplePlatform-Pharo14';
			package: 'Pharo-Compatibility';
			package: 'Regex-Core'. ].

	spec for: #'pharo1.x' do: [
		spec package: 'PhexamplePlatform-Pharo14'. ].

	spec for: #'pharo2.x' do: [
		spec package: 'PhexamplePlatform-Pharo20'. ].

]

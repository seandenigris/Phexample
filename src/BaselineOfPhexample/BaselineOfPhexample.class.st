Class {
	#name : #BaselineOfPhexample,
	#superclass : #BaselineOf,
	#category : #BaselineOfPhexample
}

{ #category : #baselines }
BaselineOfPhexample >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec baseline: 'StateSpecs' with: [ spec repository: 'github://dionisiydk/StateSpecs:v4.0.2' ].
			spec package: 'Phexample' with: [ spec requires: #('StateSpecs') ] ].
		
	spec
		for: #squeak
		do: [
			spec package: 'Phexample' with: [ spec requires: 'Regex-Core' ].
			spec package: 'PhexamplePlatform-Pharo14' with: [ spec requires: 'Phexample' ].
			spec package: 'Pharo-Compatibility' with: [ spec repository: 'http://ss3.gemstone.com/ss/Scratchpad-fbs' ].
			spec package: 'Regex-Core' with: [ spec repository: 'http://ss3.gemstone.com/ss/Pharo20' ] ].
		
	spec for: #'pharo1.x' do: [ spec package: 'PhexamplePlatform-Pharo14' with: [ spec requires: 'Phexample' ] ].
	
	spec for: #'pharo2.x' do: [ spec package: 'PhexamplePlatform-Pharo20' with: [ spec requires: 'Phexample' ] ].
	
	spec for: #('pharo1.x' 'pharo2.x' 'pharo3.x' 'pharo4.x' 'pharo5.x') do: [
			spec
				project: 'StateSpecs'
				with: [ spec
						className: 'ConfigurationOfStateSpecs';
						version: #development;
						repository: 'http://www.smalltalkhub.com/mc/dionisiy/StateSpecs/main' ] ]
]

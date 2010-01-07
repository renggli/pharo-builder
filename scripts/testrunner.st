Object subclass: #HudsonTestReport
	instanceVariableNames: 'testResult'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'HudsonBuildTools'!

!HudsonTestReport class methodsFor: 'reporting' stamp: 'yc 1/3/2010 19:54'!
findClassesForCategories: aCollection
	| items |
	items := aCollection gather: [ :category |
		((Smalltalk organization listAtCategoryNamed: category)
			collect: [ :each | Smalltalk at: each ])
			select: [ :each | (each includesBehavior: TestCase) and: [ each isAbstract not ] ] ].
	^ items asSet! !

!HudsonTestReport class methodsFor: 'reporting' stamp: 'yc 1/3/2010 19:54'!
findClassesForPackages: aCollection
    | items |
    items := aCollection gather: [ :category |
        (PackageInfo named: category) classes
            select: [ :each | (each includesBehavior: TestCase) and: [ each isAbstract not ] ] ].
    ^ items asSet! !

!HudsonTestReport class methodsFor: 'instance creation' stamp: 'yc 12/30/2009 21:17'!
on: aTestResult
	^ self new initializeOn: aTestResult! !

!HudsonTestReport class methodsFor: 'reporting' stamp: 'yc 1/3/2010 20:01'!
reportTestsInPackages: aCollectionOfPackages
    aCollectionOfPackages do: [:each | | testResult |
        testResult := self runTestCases: (self findClassesForPackages: (Array with: each)).
        (self on: testResult) writeReport: each in: SmalltalkImage current imagePath.
        ]! !

!HudsonTestReport class methodsFor: 'reporting' stamp: 'yc 1/3/2010 20:01'!
reportTestsInCategories: aCollectionOfCategories
	aCollectionOfCategories do: [:each | | testResult |
		testResult := self runTestCases: (self findClassesForCategories: (Array with: each)).
		(self on: testResult) writeReport: each in: SmalltalkImage current imagePath.
		]! !

!HudsonTestReport class methodsFor: 'reporting' stamp: 'yc 1/3/2010 19:53'!
reportTestsInCategories: aCollectionOfCategories reportInDir: reportsDir
	aCollectionOfCategories do: [:each | | testResult |
		testResult := self runTestCases: (self findClassesForCategories: (Array with: each)).
		(self on: testResult) writeReport: each in: reportsDir.
		]! !

!HudsonTestReport class methodsFor: 'reporting' stamp: 'yc 1/3/2010 20:04'!
runTestCases: aCollectionOfTestClasses
	^ (TestSuite new in: [ :suite | 
		aCollectionOfTestClasses do: [ :testClass |
			testClass isAbstract ifFalse: [ testClass addToSuiteFromSelectors: suite ] ].
		suite ]) run! !

!HudsonTestReport class methodsFor: 'reporting' stamp: 'yc 1/3/2010 20:04'!
runTests: aCollectionOfTestClassNames
	^ self runTestCases: 
		(aCollectionOfTestClassNames collect:  [ :each | Smalltalk classNamed: each])! !

!HudsonTestReport methodsFor: 'initialization' stamp: 'yc 12/30/2009 21:18'!
initializeOn: aTestResult
	testResult := aTestResult! !

!HudsonTestReport methodsFor: 'accessing' stamp: 'yc 12/30/2009 21:52'!
testResult
	^ testResult! !

!HudsonTestReport methodsFor: 'reporting' stamp: 'YanniChiu 1/3/2010 14:17'!
writeReport: category in: testReportsDir
	| s |
	testReportsDir size > 0
		ifTrue: [ | dir |
			dir := FileDirectory on: testReportsDir.
			s := dir forceNewFileNamed: category, '.xml' ]
		ifFalse: [
			s := StandardFileStream forceNewFileNamed: category, '.xml' ].
	self writeXmlOn: s suiteName: category.
	s close! !

!HudsonTestReport methodsFor: 'reporting' stamp: 'yc 1/3/2010 21:28'!
writeXmlOn: aStream suiteName: suiteName
	aStream nextPutAll: '<?xml version="1.0" encoding="UTF-8"?>'; cr.
	aStream nextPutAll: '<testsuite name="', suiteName, '">'; cr.
	self testResult expectedPasses do:
		[ :each | self writeXmlOn: aStream suiteName: suiteName testCase: each result: true ].
	self testResult failures do:
		[ :each | self writeXmlOn: aStream suiteName: suiteName testCase: each result: false ].
	self testResult unexpectedErrors do:
		[ :each | self writeXmlOn: aStream suiteName: suiteName testCase: each result: false ].
	aStream nextPutAll: '</testsuite>'; cr! !

!HudsonTestReport methodsFor: 'reporting' stamp: 'yc 1/3/2010 21:27'!
writeXmlOn: aStream suiteName: suiteName testCase: aTestCase result: passed
	| testName className |
	"Hudson knows about Java package naming conventions,
	and extracts the package name from the class name in order
	to group the test results by package. Use the class category
	(i.e. suiteName), for this purpose"
	className := suiteName, '.', aTestCase class name asString.
	testName := aTestCase selector asString.

	passed
		ifTrue: [aStream tab; nextPutAll: '<testcase name="', testName, '" time="0" classname="', className, '" />'; cr.]
		ifFalse: [ | assertionText stackTrace |
			assertionText := 'TODO: assertion message for ', aTestCase printString.
			stackTrace := 'TODO: stack trace for ', aTestCase printString.
			aStream tab; nextPutAll: '<testcase name="', testName, '" time="0" classname="', className, '">'; cr.
			aStream tab; tab; nextPutAll: '<failure message="', assertionText, '">'; cr.
			aStream nextPutAll: stackTrace; cr.
			aStream tab; tab; nextPutAll: '</failure>'; cr.
			aStream tab; nextPutAll: '</testcase>'; cr.
			]! !

HudsonTestReport name " required to load properly "

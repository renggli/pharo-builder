"These tests kill the image"
MethodContextTest removeSelector: #testClosureRestart.
!
"Run all tests in the image"
HDTestReport runCategories: Smalltalk organization categories.

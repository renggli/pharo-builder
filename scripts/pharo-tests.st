"These tests kill the image"
MethodDictionaryTest removeFromSystem.
MethodContextTest removeFromSystem.
AllocationTest removeFromSystem.
!
"Deprecated tests use a custom error handler that breaks the test runner"
(Smalltalk organization classesInCategory: #'Zinc-HTTP-Deprecated')
  do: [ :each | each removeFromSystem ]
!
"Run all tests in the image"
HDTestReport runCategories: Smalltalk organization categories.

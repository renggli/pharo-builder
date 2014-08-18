"Shrinks the image by getting rid of duplicate strings."
"Makes sure there are no two strings in the image that are equal."
"!!! use at your own risk !!!"

| b d m |
b := Bag new.
d := OrderedCollection new.
m := Dictionary new.
"count all string instances"
String allSubInstancesDo: [ :s |
    s isSymbol ifFalse: [
        b add: s ] ].
"find the ones that have no duplicates or are likely buffers"
b doWithOccurrences: [ :s :i |
    (i = 1 or: [ s anySatisfy: [ :c | c codePoint = 0 ] ]) ifTrue: [
        d add: s -> i ] ].
"remove the ones that have no duplicates or are likely buffers"
d do: [ :a |
    a value timesRepeat: [
        b remove: a key ]  ].
"map all duplicate strings to their duplicates"
String allSubInstancesDo: [ :s |
    s isSymbol ifFalse: [
        (b includes: s) ifTrue: [
            | l |
            l := m at: s ifAbsentPut: [ OrderedCollection new ].
            l add: s  ] ].
"remove the duplicates"
m keysAndValues do [ :k :v |
    | f |
    f := v at: 1.
    2 to: v size do: [ :i |
        (v at: i) becomeForward: f ] ]
!

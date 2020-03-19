"((?i)^[ \t]{0,5}[c])(?<=^.{59}).*"

"(?i)^[ \t]{0,5}[(c<=\\?).*]"

// Matches everthing after [cC]
"(?<=c)[^\\]]+"

// Matches everything after col 59
"(?<=(.{59}))[^\\]]+"

// Get C at column 5
"((?<=^.{5}).)"


// Match C in col 5 nothing before it
"(?i)^[ \t]{0,5}[(c<=\\?).*]"



((?<=(.{59}))[^\]]+)

// match c and before
(^[ \t]{0,5}[(c<=\\?).*])



(?<=((?<=^[\s]{5}[c])[\s\S]{53}))[\s\S]+
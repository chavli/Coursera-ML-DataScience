# traceback() - prints the call stack after an error occurs
mean(foo) # foo undefined
traceback()

lm(foo ~ bar) # foo, bar undefined
traceback()

# ------------------------------------------------------------------------------

# debug() - allows you to step through a function line by line
debug(lm) 
debug(max)

# this will put you in browser mode for debugging. the env changes
# to the functions env. 'n' = step over
lm(foo ~ bar) 


# browser() - suspends execution and puts the function in debug mode can be placed
#  anywhere

# ------------------------------------------------------------------------------

# trace() - allows you to insert debugging code into a function

# ------------------------------------------------------------------------------

# recover() - allows you to modify error behavior
options(error = recover)
read.csv("not_a_file.err")

# this lets you explore the env spaces of each call in the call stack
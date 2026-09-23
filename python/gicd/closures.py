# Closures
# A closure is an object that acts like a function, but also has an environment of variables
# that persist after the function returns. When you write a function that returns a function,
# you are (usually) creating a closure. For example, consider this code:
def make_adder(n):
    def adder(x):
        return x + n
    return adder

add3 = make_adder(3)
print(add3(4)) # = 7

add5 = make_adder(5)
print(add5(4)) # = 9

print(add3(add5(2))) # = 10

# make_adder(n) returns a closure that adds n to its argument. This is interesting because
# the variable n is not local to adder, and is not passed as a param. Yet, when adder is called, it
# can use the value of n that was passsed to make_adder. Python makes this work by storing the
# value of n in an enviornment with the function, and together, the function and its environment,
# form a closure.

# Here's another example. make_counter returns a function that returns the amount of times
# it has been called:
def make_counter():
    n = 0
    def counter():
        nonlocal n
        n+=1
        return n
    return counter

counter = make_counter()

print(counter()) # 1
print(counter()) # 2
print(counter()) # 3

# The situation is a bit different here. The variable n is being MODIFIED by the counter function.
# In this case, Python requires that n be marked as nonlocal so that Python knows to use the 
# variable from the enclosing scope.
# Generalizing this, here is a function that returns three closures that set, get, and increment
# a counter. All three closures share the same variable n:
def make_counter2():
    n = 0
    def set_n(x):
        nonlocal n
        n = x
    def get_n():
        nonlocal n
        return n
    def increment():
        nonlocal n
        n += 1
    return set_n, get_n, increment

set_n, get_n, increment = make_counter2()

print(get_n()) # 0
increment()
print(get_n()) # 1
increment()
print(get_n()) # 2
set_n(10)
print(get_n()) # 10

# Treat closures like objects, being
# closure = <f, environment>
# set_n() ,get_n(), and increment() all share the same environment?
# Idk possibly because they're all defined in the same larger func
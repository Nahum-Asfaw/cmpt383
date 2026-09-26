# It's common in python to want both the indicies and value of the element of a list.
# You can get those like this:
list = ['a', 'b', 'c']
for i in range(len(list)):
    print(i, list[i])

# Output:
# 0 a
# 1 b
# 2 c

# This is common enough that python provide enumerate:
for i, value in enumerate(list):
    print(i, value)

# This is a little shorter and more readable than the first version
# You could use it to find the smallest element in a list and it's index:
def get_min(list):
    """Returns the smallest element and its index in lst.
    """
    min_value = list[0]
    min_index = 0
    for i, value in enumerate(list):
        if value < min_value:
            min_value = value
            min_index = i
        return min_value, min_index

print(get_min([3, 2, 4, 1, 5])) # (1, 3)

# In general, an iterator is an object that retuns values. In practice, it is often uesd
# to give sequential access to the objects in a collection (like a list, or a tree)

# Let's buid our own iterator as an example (we'll see shortly how to make it an offical python iterator)

class Counter:
    def __init__(self):
        self.value = 0
    def next(self):
        self.value += 1
        return self.value

# This store a single interge value, and has a next method that increments the value and returns it.
# We can use it like this:
counter = Counter()
print(counter.next()) # 1
print(counter.next()) # 2
print(counter.next()) # 3

# Here's an iterator that iterates over the letters of a given string s:
class Letters:
    def __init__(self, s):
        self.s = s
        self.index = 0

    def next(self):
        self.index += 1
        return self.s[self.index -1] # crashes if there are no more letters!

# To use it:
letters = Letters("cat")
print(letters.next()) # 'c'
print(letters.next()) # 'a'
print(letters.next()) # 't'
print(letters.next()) # crashes!

# Letters is useful as long as there are more letters to iterate over. But when all the letters
# have returned, it crashes. And crashing is never a good thing!

# Note that Counter doesn't crash: it has no end. Counter is an example of an endless iterator, or
# infinite iterator

# To deal with iterators that do stop (i.e., have no more elements to return), python uses the StopIteration
# exception. The idea is that if next is called when the iterator is done, it raises a StopIteration exception.
# We can modify Letters like this:
class Letters:
    def __init__(self, s):
        self.s = s
        self.index = 0

    def next(self):
        if self.index < len(self.s):
            self.index += 1
            return self.s[self.index - 1]
        else: 
            raise StopIteration

# Then:
letters = Letters("cat")
print(letters.next()) # 'c'
print(letters.next()) # 'a'
print(letters.next()) # 't'
print(letters.next()) # StopIteration exception

# It still crashes, but in a controlled manner by raising StopIteration.

# Python has built-in suport for iterators called the iterator protocol. A python object is an iterator if it
# conforms to the iterator protocol. That mean it must have these two methods:
# - __next__() returns the next value from the iterator, and riases StopIteration if there are no more values. 
# Python calls it __next__() instead of next() since it is a python convention to use double underscores for 
# special methods
# - __iter__() returns the iterator object itself. This usually just returns self, i.e., the object itself. But
# container objects, such as a list, have __iter__ so that you can get an iterator object for the container.

# The idea is that calling __iter__() gets you an iterator object that is guaranteed to have a __next__ method.
# So let's update Letters to make it an official Python iterator:
class Letters:
    def __init__(self, s):
        self.s = s
        self.index = 0

    def __iter__(self):
        return self
    def __next__(self):
        if self.index < len(self.s):
            self.index += 1
            return self.s[self.index -1]
        else:
            raise StopIteration

# We can still use this as before, using the __next__ method:
letters = Letters("cat")
print(letters.__next__()) # 'c'
print(letters.__next__()) # 'a'
print(letters.__next__()) # 't'
print(letters.__next__()) # StopIteration exception

# But now we can
letters = Letters("cat")
print(next(letters)) # 'c'
print(next(letters)) # 'a'
print(next(letters)) # 't'
print(next(letters)) # StopIteration exception

# And we can use it in a for loop:
letters = Letters("cat")
for c in letters:
    print(c)

# Or:
for c in Letters("cat"):
    print(c)

# This for-looop is pretty nice: it's short, readable, and doesn't require any knowledge of the iterator
# protocol. The for-loop takes care of the messy details.
# Python already provides an iterator like Letters for strings. We can iterate directly over strings like this:
for c in "cat":
    print(c)

# This works because python strings implement the __iter__ method, which returns an iterator object that has
# a __next__ method. Strings themselves are not iterators, but you can always get an iterator object for them
# by calling __iter__. For example:

it = iter("cat")
for c in it:
    print(c)

# But as we've seen, we can just write this:
for c in "cat":
    print(c)

# This shows us something important: for works with an object that has __iter__ method. When the for-loop runs,
# it calls __iter__ to get an iterator object, and then calls __next__ on that iterator object to get the values.

# In python terminology, we say that strings are iterable (but they aren't iterators). In general, any object that
# has an __iter__ method is iterable. An iterator is any object that is both iterable (has an __iter__ methd) and
# has a __next__ method.

# Let's make a version of the enumerate iterator that works with lists:
class My_enumerate:
    def __init__(self, list):
        self.list = list
        self.index = 0
    def __iter__(self):
        return self
    def __next__(self):
        if self.index < len(self.list):
            i = self.index
            value = self.list[i]
            self.index += 1
            return i, value
        else:
            raise StopIteration

# With iterators, it is standard for __iter__ to return self because it is already an iterator.
# We can use it like this:
for i, v in My_enumerate(['a', 'b', 'c']):
    print(i, v)

# 0 a
# 1 b
# 2 c

# Python has a built-in iterator called reversed that iterates over a sequence in reverse order:
for i in reversed([1, 2, 3, 4]):
    print(i)

# 4
# 3
# 2
# 1

# Let's make our own version of reversed:
class My_reversed:
    def __init__(self, list):
        self.list = list
        self.index = len(list) 
    def __iter__(self):
        return self
    def __next__(self):
        if self.index > 0:
            self.index = self.index
            return self.list[self.index]
        else:
            raise StopIteration

# Then
for i in My_reversed([1, 2, 3, 4]):
    print(i)

# 4
# 3
# 2
# 1

# Let's make a more complex iterator, one that generate prime numbers. We want it to work like this:
# primes = Primes()
# for p in range(5):
#   print(next(primes))

# 2
# 3
# 5
# 7
# 11

# To implement it, we first write a couple of helper functions for finding primes:
def is_prime(n):
    """Returns True if n is a prime number, False otherwise."""
    if n < 2:
        return False
    for d in range(2, n):
        if n % d == 0:
            return False
    return True

def next_prime(n):
    """Returns the next prime number after n."""
    while True:
        n += 1
        if is_prime(n):
            return n

# next_prime is curious because it appears to contain an infinite loop, but we know it does not run forever thanks
# to Euclid's theorem (which proves there are infinitely many primes)

# Now we can implement Primes:
class Primes:
    def __init__(self):
        self.value = 1
    def __iter__(self):
        return self
    def __next__(self):
        self.value = next_prime(self.value)
        return self.value

# The source code for Primes is relatively simple thanks to our helper funcs. Calling __next__ calls next_prime,
# which could do a lot of work: for large values of n, could take a long time to find the next prime number.

# Let's write a related iterator that generates the rpimes less than a given number. We'll use the Primes iterator,
# and stop when we reach the given number:
class Primes_less_than:
    def __init__(self, max):
        self.max = max
        self.primes = Primes()
    def __iter__(self):
        return self
    def __next__(self):
        p = next(self.primes)
        if p < self.max:
            return p
        else:
            raise StopIteration

# This lets us write:
for p in Primes_less_than(10):
    print(p)

# 2
# 3
# 5
# 7

# Experience shows that iterators are a powerful tool for writing code that is concise, readable, and easy
# to reason about. But implementing __next__ requres writting classes that store the state of the iterator, and
# in practice that can be difficult to do correctly.
# So, python provides a more convinent way to write iterators: generators

# Suppose we want an iterator to iterate over the strings "Step A", "Step B", "Step C". We could write a class
# like this:
class SimpleSteps:
    def __init__(self):
        self.steps = ["Step A", "Step B", "Step C"]
        self.index = 0
    def __iter__(self):
        return self
    def __next__(self):
        if self.index < len(self.steps):
            self.index += 1
            return self.steps[self.index - 1]
        else:
            raise StopIteration

for step in SimpleSteps():
        print(step)

# Step A
# Step B
# Step C

# This works, but it's a pain to write. So instead, python lets us write a generator function that returns
# an iterator:
def simple_steps():
    yield "Step A"
    yield "Step B"
    yield "Step C"

for step in simple_steps():
    print(step)

# Step A
# Step B
# Step C

# You could also use it like this:
gen = simple_steps()
print(next(gen)) # Step A
print(next(gen)) # Step B
print(next(gen)) # Step C
print(next(gen)) # StopIteration exception

# This is much nicer.
# simple_steps is an example of a generator function. A generator functin is a function that returns a
# generator object, which is a special kind of iterator. Like all iterators, generator objects have an __iter__
# and __next__ method, but they also remember the values of variables and let you use yield to return them.

# yeild is like return, but instead of returning a value and ending the function, it returns a value and then
# rememvers what line of code it is on and the values of variables. When __next__ is called, the function
# continues from the line after the last yield.

def my_enumerate(list):
    index = 0
    for item in list:
        yield index, item
        index += 1

for i, v in my_enumerate(["a", "b", "c"]):
    print(i, v)

# 0 a
# 1 b
# 2 c

# Compared to My_enumerate, this is shorter and more readable
# We can write our own version of reversed like this:
def my_reversed(list):
    index = len(list)
    while index > 0:
        yield list[index]
        index -= 1

for i in my_reversed([1, 2, 3, 4]):
    print(i)

# yk the rest

# Prime numbers can be generated like this:
def primes_gen():
    """Yields all the prime numbers."""
    n = 2
    while True:
        yield n
        n = next_prime(n)

primes = primes_gen()
print(next(primes)) # 2
print(next(primes)) # 3
print(next(primes)) # 5

# we add _gen to the name to indicate that this is a generator function. This is an inifinte generator, since it
# never stops yeilding prime numbers.Again, commpared to the classes above that do the same thing, 
# generator function sare generally simpler and more readable.

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

# A common programming pattern that closures help with is wrapping a function inside another function to give
# it some extra behavior. For example, suppose we have this function to simulate doing laundry:
def do_laundry():
    import time
    print("Doing laundry ...")
    time.sleep(1)
    print("Laundry done")

# Now suppose we want to time exactly how long it takes to run. We could modify it like this:
def do_laundry():
    import time
    start_time = time.time()
    print("Doin laundry ...")
    time.sleep(1)
    print("Laundry Done")
    end_time = time.time()
    print(f"Time taken: {end_time - start_time} seconds")
    do_laundry()

# Doing laundry...
# Laundry done
# Time taken: 1.0003 seconds or smth idk

# This works, but it's messy, and the timing code is not reusable. So instead, let's write a function that can
# take do_laundry as input and return a new function that tiems it:
def make_timed_function(f):
    def timed_function():
        import time
        start_time = time.time()
        result = f()
        end_time = time.time()
        print(f"Time taken: {end_time - start_time} seconds")
        return result
    return timed_function

timed_do_laundry = make_timed_function(do_laundry)
timed_do_laundry()

# yk the rest
# and thats all. Ive read the notes for generators enough times for it to be a waste for me to 
# re-write it here.
# FIND MORE REVIEW MATERIAL (BE IT OLD ASSIGNMENTS OR PRACTICE EXAMS)
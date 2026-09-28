# Q1
# 1)
[x**2 for x in range(21) if x % 2 == 0]

# 2)
lst = ["Alice", "Mick", "Andy", "Bob"]
[x for x in lst if len(x) % 2 == 1]

# Q2
l1 = [1, 2, 3]
l2 = ['a', 'b', 'c']
[(x,y) for x in l1 for y in l2]

# Q3
def slow_function(n):
    import time
    #time.sleep(1) # idk
    return n

my_data = [1, 2, 3]
results = [y for x in my_data if (y:=slow_function(x)) > 10]

# Q4
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
t = [list(x) for x in zip(*matrix)]
print(t)

# Q5
class CountByTwo:

    def __init__(self, start):
        self.start = start

    def __iter__(self):
        return self

    def __next__(self):
        self.start +=2
        return self.start

count5bytwo = CountByTwo(5)

#for x in count5bytwo:
    #import time
    #print(x) # works...
    #time.sleep(1)

# Q6
# As was considered to us by our TA: think of an iterable as something that can be iterated over, i.e., something
# that has elements that you may want to see one at a time in a loop. An iterator, on the other hand, is a cursor,
# being the thing that moves between elements of an iterable.
# The standard python string isn't considered an iterable as it doesn't have the __next__() method. This acts as the
# cursor I mentioned, going from one element to the next.

# Q7
def my_reversed_gen(lst):
    for x in range(len(lst)):
        yield lst[len(lst) - x - 1] # -1 is used to remain inside of the lst

for x in my_reversed_gen("Alice"):
    print(x)

# Q8
def make_multiplier(n):
    def multiply(x):
        return n * x
    return multiply

multiply5by = make_multiplier(5)
print(multiply5by(3))

# Q9
def print_types(f):
    def do_it(*args, **kwargs):
        print(f"will print types after {f.__name__} runs...")
        this = f(*args, **kwargs)
        print("Types:", [type(x) for x in args])
        return this
    return do_it

@print_types
def hello_times(name, times):
    for x in range(times):
        print("hello {name}!")

hello_times("Dude", 4)

# smth I saw on discord for the summer 383 quiz1
lst = [(x, y, z) for x in range(4) for y in range(4) for z in range(4) if x < y < z]
print(lst)

# More gemeni questions on closures:

# From a different Q1: a closure can best be thought of as functions that return <function, environment>. 
# Variables defined in the outer function may be seen and edited (editing requres the 'nonlocal' term) 
# by the inner function.

# Q2
def make_accumulator(initial_value):
    def add(x):
        nonlocal initial_value
        initial_value += x
        return initial_value

    def get_total():
        return initial_value

    return add, get_total

add, get_total = make_accumulator(10)

print(add(10))
print(get_total())

# Q3
def make_bounds_checker(x):
    def is_x_chars(str):
        return len(str) == x

    return is_x_chars

is_5_chars = make_bounds_checker(5)
print(is_5_chars("Alice"))
print(is_5_chars("Bob"))

# Remember: you use 'nonlocal' inside of the INNER function

# Gemeni on iterators:
# An iterator in python is an object that returns values one at a time, typically providing sequential access
# to items in a collection. To be recognized as an offical python iterator, an object must conform to the 
# iterator protocol, which requires two specific methods:
#   - __next__(): This method fetches and returns the next value in the sequence. When ther is no more data
# left to iterate over, it raises a StopIteration exception to safely signal the end of the sequence.
#   - __iter__(): This method returns the iterator object itself, usually by simply returning self.

# An iterable, on the other hand, is any object that implements an __iter__ method. When called, this
# method returns an iterator object that is guaranteed to have a __next__ method.

# The fundamental difference between the two lies in their responsibilities and their required methods:
#   - Iterables are objects you can iterate over. They must have an __iter__ method, but they do not have a
# __next__ method
#   - Iterators are the objects that actually perform the iteration and track the state. They must have
# a __next__ method to fetch values, and because they also implement __iter__ (which returns self), all
# iterators are technically iterable.

# Python strings perfectly illustrate this distinction. Strings are iterable, but they are not iterators 
# themselves. When you write a for loop to iterate directly over a string, the loop handles the messy details
# behind the scenes: it first calls __iter__ on the string to obtain a temporary iterator object, and then
# it repeatedly calls __next__ on that iterator to extarct each character until the StopIteration exception
# is raised.

# Thats all...
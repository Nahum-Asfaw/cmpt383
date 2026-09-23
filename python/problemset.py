# Python Problemset

# Q1: List comprehensions are a compact way of creating lists, tuples, and other objects using 
# a format simlar to mathematical set notation. Like set notation, you firrt define what you want
# the returned value to look like (e.g., x**2), then describe what the range and conditions are
# for this set. So if you wanted x**2 over 0, 2, 4, ..., 10, (0 to 10 with only even numbers),  
# it can be represented as [x**2 for x in range(0, 11) if x % 2 == 0]

# Q2: 1)
p1 = [x for x in range(1, 101) if x % 5 == 0]
print(p1)
# 2)
eg = ["Even", "Odd", "I AmEven", "I AmOdd"]
p2 = [c for c in eg if len(c) % 2 == 0]
print(p2)
# 3) Might be a bad ans...
def eval(x):
    if x > 0: return x -1
    else: return x + 1

eg = [0, 2, -2, 0, -3, 5]
p3 = [eval(x) for x in eg if x != 0]
print(p3)
# 4)
p4 = [(a, b, c ,d) for a in range(0, 2) for b in range(0, 2) 
      for c in range(0, 2) for d in range(0, 2)]
print(p4)
# 5)
l1 = [1, 2, 3, 4, 0]
l2 = [7, 9, 2, 4, 10]
l3 = [11, 9, 12, 13, 14]
p5 = [(a, b, c) for a in l1 for b in l2 for c in l3
      if a != b != c != a]
#print(p5) too much, no clarity
# 6)
p6 = [(a, b, c) for a in range(1, 101) for b in range(1, 101)
      for c in range(1, 101) if a**2 + b**2 == c**2 if a < b < c]
#print(p6) too much

# Q3: The walrus operatior is a colon and equals sign, ':='. It is used to assign
# a value to vars inside of a larger expression. An example:
[c:= x*2 for x in range(0, 11)] # An ordinary '=' wouldn't be possible here.

# Q4: a)
def my_zip2(A, B):
    list = []
    for x in range(0, len(A)):
        list.append((A[x], B[x]))
    return list

print(my_zip2([1, 2, 3], [4, 5, 6]))
#b)
dp = sum(x*y for x, y in my_zip2([1, 2, 3], [4, 5, 6]))
print(dp)
#c)
def my_zip(*args):
    if len(args) < 2:
        print("n < 2")
        raise ValueError
    list = []
    for y in range (0, len(args[0])):
        list.append(tuple(x[y] for x in args))
    
    return list

print(my_zip([1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]))
#print(my_zip([1, 2, 3]))
# d)
def add_lists(*args):
    list = [sum(x) for x in my_zip(*args)]
    return list

print(add_lists([1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]))

# Q5:
# 1) loop
def make_numbered_list1(list):
    temp = ""
    for i, value in enumerate(list):
        temp = temp + "\n" + ". ".join([str(i+1), value]) 
    return temp

print(make_numbered_list1(['a', 'b', 'c']))

# 2) lc
def make_numbered_list2(list):
   temp = ""
   [temp:= temp + "\n" + ". ".join([str(i+1), value]) for i, value in enumerate(list)]
   return temp

print(make_numbered_list2(['a', 'b', 'c']))

# 3) in one line!
def make_numbered_list3(list):
    return "".join(["\n" + ". ".join([str(i+1), value]) for i, value in enumerate(list)])


print(make_numbered_list3(['a', 'b', 'c']))

# Q6:
def get_max(list):
    max = list[0]
    if str(max).isnumeric():
        for i, value in enumerate(list): # why enumerate? what is the use of i?
            if max < value:
                max = value
    
    else: 
        for i, value in enumerate(list):
            if len(max) < len(value):
                max = value

    return max

print(get_max([1, 3, 6, 1, 2]))
print(get_max(['apple', 'bannana', 'cherry']))

# Q7: The python iter protocol is a desgination for functions, being iterable, iterators, 
# or neither. Iterators can be ran through themelves in for loops, such as zip and enumerate.
# If a function has the method __iter__(), it is an iterable and can be made into an iterator
# by adding the __next__() method. Once a __next__() runs out of data to iterate over, it raises
# StopIteration, and ends. The data cannot be retrieved after this point.

# Q8:
class My_reversed:
    def __init__(self, str):
        self.str = str
        self.index = len(str)

    def __iter__(self):
        return self

    def __next__(self):
        if self.index > 0:
            self.index = self.index - 1 # no -- in python?
            return self.str[self.index]
        else:
            raise StopIteration

for c in My_reversed('cat'):
    print(c)

# Q9: Explained in Q7. It means it doesn't have the method __next__() to traverse the values.
# Toby hypothesized that python was designed this way to save on memory. Most functions are 
# iterable, but not iterators, as they don't need that functionality, and adding __next__()
# to those functions might add some overhead.

# Q10:
class My_enumerate:
    def __init__(self, list):
        self.list = list
        self.index = -1
        self.n = len(list) - 1

    def __iter__(self):
        return self

    def __next__(self):
        if self.index < self.n:
            self.index = self.index + 1
            return self.index, self.list[self.index]
        else:
            raise StopIteration

for i, v in My_enumerate(['a', 'b', 'c']):
    print(i, v)
    
# Q11: 1)
def my_range_gen(a, b):
    val = a
    while val < b:
        yield val
        val = val + 1

for x in my_range_gen(0, 11):
    print(x)

# 2)
def my_zip2_gen(A, B):
    for x in my_range_gen(0, len(A)):
        yield (A[x], B[x])

for x, y in my_zip2_gen([1, 2, 3], [4, 5, 6]):
    print(x, y)

# Q12:
def longer_than_gen(val, list):
    for x in list:
        if len(x) > val:
            yield x

pets = ['cat', 'hamster','dog', 'bird']
for s in longer_than_gen(3, pets):
    print(s)

# Q13:
def lines_of_file_gen(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()

    count = 0
    for line in lines:
        yield count, line
        count = count + 1

for i, line in lines_of_file_gen('joke.txt'):
    print(f'{i + 1}: {line}', end="")

print()

#Q14:
def make_bounds_checker(a, b):
    def good_score(x):
        if a < x < b:
            return True
        else:
            return False
    return good_score

good_score = make_bounds_checker(0, 100)
print(good_score(50)) # True
print(good_score(101)) # False
print()

is_teen = make_bounds_checker(13, 19)
print(is_teen(15)) # True
print(is_teen(12)) # False
print(is_teen(20)) # False

# Q15: uhh... its like a function that can take a function and you can do stuff with it
# (like making a log, seeing completion time, etc.) An example would be Q3 in gicd/fib.py

# Q16:
def always_return_str(f):
    def make_str(*args, **kwargs):
        this = f(*args, **kwargs)
        return str(this)
    return make_str

@always_return_str
def f(n):
    if n == 1:
        return 'one'
    elif n == 2:
        return 2
    elif n == 3:
        return [1, 2, 3]
    else:
        return ''

# isinstance(x, str) returns True if x is a string, and False
# otherwise
print(f(1), isinstance(f(1), str))
print(f(2), isinstance(f(2), str))
print(f(3), isinstance(f(3), str))
print(f(4), isinstance(f(4), str))

# Q17:
import time

class LoggedTimer:
    def __init__(self, filename):
        """The Problem set asks us to use __init__ to store the filename, so here it is
        """
        self.filename = filename

    def __enter__(self):
        self.start = time.perf_counter()
        with open(self.filename, 'w') as f:
            f.write(f"Started at {self.start:7.9f}\n")
        print(f"Logged to {self.filename}")
        return self

    def log(self, str):
        with open(self.filename, "a") as f:
            f.write(str)
            f.write("\n")

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.end = time.perf_counter()
        time1 = self.end - self.start
        with open(self.filename, 'a') as f:
            f.write(f"Stopped at {self.end:7.9f}\n")
            f.write(f"Elapsed time: {time1:.3f}\n")
            
with LoggedTimer('timer.log') as t:
    t.log("Starting sleep ...   ")
    time.sleep(1)
    t.log("Done sleeping!")

print('Done!')

# Q18:
def classify_grade(x):
    match x:
        case _ if x in range(0, 50): 
            return "F"
        case _ if x in range(50 , 70):
            return "D"
        case _ if x in range(70, 80):
            return "C"
        case _ if x in range(80, 90):
            return "B"
        case _ if x in range(90, 101):
            return "A"
        case _:
            return "Error"

print(classify_grade(95))   # A
print(classify_grade(80))   # B
print(classify_grade(79))   # C
print(classify_grade(62))   # D
print(classify_grade(48))   # F

# Q19:
def calculate_area(shape):
    match shape:
        case ("circle", r):
            return 3.14*r**2 # idk pi in python
        case ("rectangle", w, h):
            return w*h
        case ("triangle", b, h):
            return (b*h)/2
        case ("square", s):
            return s**2
        case _:
            return "Unknown shape"

print(calculate_area(("circle", 5)))       # 78.5
print(calculate_area(("rectangle", 4, 6))) # 24
print(calculate_area(("triangle", 3, 8)))  # 12.0
print(calculate_area(("square", 7)))       # 49
print(calculate_area(("hexagon", 4)))      # Unknown shape
# Done!

# Sept 23
# Side effects of a func: reading files, printing, etc. Returns None
# A func is impure if it has a side effect
# A func is pure if there are no side effects, and it returns a value
# Consider using pure functions as much as possible!!!
# E.g., cannot do assignments with global variables in a pure function,
# as that is considered a side effect (no return value?).
# A solution is to use helper functions to make calculations.
# In python, you can easily pass functions to other functions, e.g., 
# def f(g): ...

# CMPT383
# Python notes -> list comprehensions

# Basic Concepts
# Point is that python can create sets/lists in mathematical notation
print([x**2 for x in [1, 2, 3, 4, 5]])

print([x**2 for x in range(1,6)])

# Same as...
squares = []
for x in [1, 2, 3, 4, 5]:
    squares.append(x**2)

print(squares)

# Creating conditions
print([x for x in range(1, 6) if x % 2 == 0])

# Same as...
even_numbers = []
for x in range(1, 6):
    if x % 2 == 0:
        even_numbers.append(x)

print(even_numbers)

# The squares of even numbers from 1 to 10:
print([x**2 for x in range(1, 11) if x % 2 == 0])

# Non-empty strings with an even # of chars:
print([s.title() for s in ['bob', '', 'mary', 'carla', 'sam', 'dean'] if s.strip() != '' if len(s) % 2 == 0])

# Multiple Clauses
# Act like nested for loops. Gives all the pairs of #s from 1 to 3
print([(x, y) for x in range(1,4) for y in range(1, 4)])

# Often formatted as...
print([(x,y) for x in range(1, 4)
             for y in range(1,4)])

# The sol'ns to x^2 + y = 100 for x and y in range(1, 101):
print([(x, y) for x in range(1, 101)
              for y in range(1, 101)
              if x**2 + y == 100])
# AKA brute force, or exhaustive enumeration

# Cartesian Prodcuts
# If and B are two sets, we can represent their Cartesian product A x B as
# [(a, b) for a in A
#         for b in B]

# if A1, ..., An all have m elements, then A1 x A2 x ... x An has m*m*... = m^n
# elements, and so the comprehension makes m^n elements, a running time which is exponential in n. 
# For example, if all the sets are 0, 1, then the comprehension makes 2^n elements, and contains
# all the bit strings of length n.
# For instance, here are all 2^3 = 8 bit sequences of length 3:
print([(a, b, c) for a in [0, 1]
                 for b in [0, 1]
                 for c in [0, 1]])

# If you treat the sequence as binary numbers, then this has generated the numbers 0 to 7 in binary:
# yk it
# Thinkkign of lists comprehensions as cartesian products gives us a nice connection to mathematics. It
# lets us use ideas from math to help reason about our code (and vice versa)
# Example: see abc_puzzle.py for more details.

# The walrus operator
# Consider this function:
def get_score(s):
    return sum(ord(c) for c in s)

# It returns the sum of the ASCII values of the characters in the string, e.g., get_score('cat') returns 312.
# A function like this might be useful with a hash table of strings

# Now consider this code, which gets a list of all the names and scores that match a certain condition.
all_names = ['Bob', 'Alice', 'Charlie', 'Bev']
high_scores = [(n, get_score(n)) for n in all_names if get_score(n) % 5 != 0]

# For each name, get_score is called twice, and it returns teh same result each time. That's inefficient.
# We can do better by using the walrus operator, :=, to save the value of the result in a variable:
high_scores = [(n, score) for n in all_names if (score:= get_score(n)) % 5 != 0] # walrus operator here

# The first time get_score is called, its result is saved in the variable score using :=. Then score can be
# used in other parts of teh comprehension without calling get_score again.

# In some situations the walrus operator can make code more concise and efficient, so be on the lookout for
# situations where it can be used.

# high_scores.py contains the complete code example.

# Notes continued in zip_prac.py

# A sometimes useful funtion is sizp, which takews two or more lists and gives
# a list of pairs or tuples of the corresponding elements. For example:
list1 = [1, 2, 3]
list2 = ['a', 'b', 'c']
for x, y in zip(list1, list2):
    print(x,y)

# look here!
list(zip(list1, list2)) # [(1, 'a'), ...]

# We'll assume that the list we pass to zip are the same length
# We can use zip to add two lists of numbers element-wise:
list1 = [1, 2, 3]
list2 = [4, 5, 6]
total = [x + y for x, y in zip(list1, list2)]
print(total) # [5, 7, 9]

# Note that using two for loops DOESN'T do the same thing:
total = [x+y for x in list1 for y in list2]
print(total) # [5, 6, 7, 6, 7, 8, 7, 8, 9]

# That sums all the pairs of elements in the Cartesian produt of the lists
# Using this trick you can compute the dot product of two lists of numbers like this:
# carring over list1, list2:
dot_product = sum([x*y for x, y in zip(list1, list2)])
print(dot_product) # 32

# in this case, the [] brackets are not needed:
dp = sum(x *y for x, y in zip(list1, list2))
print(dp) # still 32

# Here's anoher example where zip pairs-up related pieces of information. 
# This calculates the names of students who passed an exam:
names = ["Alice", "Bob", "Charlie"]
scores = [85, 40, 92]

passing = [name for name, score in zip(names, scores) if score > 50]

print(passing) # ['Alice', 'Charlie']

# zip can help you get pairs of adjacent elements in a sequence. For example:
s = 'house'
adj_pairs = [(x, y) for x,y in zip(s, s[1:])]
print(adj_pairs) # [('h', 'o'), ('o', 'u'), ...]

# s[1:] is the string 'ouse', so the zip expression is the same as zip('house', 'ouse').
# The strings are different lengths, and so zip stops after pairing up the first four charcters
# Using this trick you can write the is_sorted function like this:
def is_sorted(list):
    return all(x <= y for x,y in zip(list, list[1:]))

is_sorted([1, 2, 3, 4, 5]) # True
is_sorted([1, 3, 2, 4, 5]) # False

# As another example of unpacking, consider this function which takes three arguments:
def f(a, b, c):
    return a + b + c

# we can call it like this:
print(f(1, 2, 3)) # 6

# but suppose we have a list of values:
values = [1, 2, 3]
#print(f(values)) # error: wrong number of arguments

# f takes three arguments, the expression f(values) only passed one. We could fix it like this:
print(f(values[0], values[1], values[2])) # 6

# But its a pain to write. The unpacking operator * lets us do the same thing more concisely:
print(f(*values)) # 6

# Finally, consider transposing a matrix. For example, if you have the matrix:
# 1 2
# 3 4
# 5 6

# Its transpose is:
# 1 2 3
# 4 5 6

# In python, the first matrix would be
[[1, 2], # row 0
 [3, 4], # row 1
 [5, 6]] # row 2

# And the transpose would be:
[[1, 3, 5], # column 0
 [2, 4, 6]] # column 1

# Using zip and teh * operator, we can transpose a matrix like this:
matrix = [[1, 2], [3, 4], [5, 6]]
transposed = [list(row) for row in zip(*matrix)]

# The expression zip(*matrix) is, in this example, the same as zip([1, 2], [3, 4], [5, 6]).
# The * operator unpacks the elements of matrix into its individual lists and passes them to
# zip as separate arguments. zip([1, 2], [3, 4], [5, 6])

for row in zip([1, 2], [3, 4], [5, 6]):
    print(row)

# CSV = Comma Seperated Values, common way of storing values in python
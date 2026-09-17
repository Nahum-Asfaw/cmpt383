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

# Do abc_puzzle.py
# Do comprehensions.py
# Do scratch.py

# CSV = Comma Seperated Values, common way of storing values in python
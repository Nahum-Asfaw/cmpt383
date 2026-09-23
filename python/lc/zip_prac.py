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
# The match statement is a new feature in Python 3.10. It is a more powerful alternative to the
# if statement, and is somewhat similar to the switch statment in C/C++, but more flexible

# Essentially, a match statment compares a value to a sequence of pattterns, stopping at the 
# pattern that matched. It can also automatically extract parts of some values.
def http_error(status):
    match status:
        case 400:
            return "Bad request"
        case 404:
            return "Not found"
        case 418:
            return "Huh"
        case _:
            return "Something's wrong with the internet"

print(http_error(400)) # Bad request
print(http_error(404)) # Not found
print(http_error(418)) # Huh
print(http_error(500)) # Something's wrong with the internet

# The cases are checked in the order they are written. _ is a catch-all that matched anything, 
# and so often the last case is case _.
# You can use | as "or" to match mupltiple patterns at once. For example:

def http_error(status):
    match status:
        case 400:
            return "Bad request"
        case 401 | 403 | 404:
            return "Not allowed"
        case 418:
            return "Huh"
        case _:
            return "Something's wrong with the internet"

# This example uses variables to extract parts of the value being matched:
def print_point(point):
    match point:
        case (0, 0):
            print("Origin")
        case (0, y):
            print(f"On the y-axis at {y}")
        case (0, x):
            print(f"On the x-axis at {x}")
        case (x, y):
            print(f"X={x}, Y={y}")
        case _:
            raise ValueError("Not a point")

print_point((0, 0)) # Origin
print_point((0, 3)) # On the y-axis at 3
print_point((6, 0)) # On the x-axis at 6
print_point((2, 5)) # X=2, Y=5
print_point([6, 4]) # X=6, Y=4
print_point((6, 4, 2)) # Not a point

# It's often useful to match a list and extract the first element and the rest of the list.
def print_parts(list):
    match list:
        case [first, *rest]:
            print(first)
            print(rest)
        case _:
            print(f'Cannot match {list}')

print_parts([1, 2, 3])
# 1
# [2, 3]

print_parts(['up', 'down', 'left', 'right'])
# up
# ['down', 'left', 'right']

print_parts([5])
# 5
# []

print_parts([])
# Cannot match []

# Here's how we could get the min using match:
def get_min(list):
    match list:
        case []:
            raise ValueError("List is empty")
        case [x]:
            return x
        case [first, *rest]:
            min_rest = get_min(rest)
            return first if first < min_rest else min_rest

print(get_min([3])) # 3
print(get_min([3, 4])) # 3
print(get_min([4, 3])) # 3
print(get_min([3, 3])) # 3
print(get_min([3, 4, 5])) # 3

# A few things to note:
# - It's a recursive function.
# - It clearly states that the empty list, [], raises an error
# - It's also clear that the min of a list with a single element is just the element itself
# - The third case binds the first element of the list to first, and the rest of the list
# to rest. Then it finds the min of the rest of the list and compares it to the first element.

# Python's match doesn't always work as you might like. For example:
def bad_contains(x, list):
    match list:
        case []:
            return False
        case [x, *_]:
            return True
        case [_, *rest]:
            return bad_contains(x, rest)

print(bad_contains(3, [])) # False
print(bad_contains(3, [4])) # True  <--- not what we want!
print(bad_contains(3, [3])) # True 

# In bad_contains, one might think that the second case matched just if the first element of the
# list is equal to x. For example, if list is [4, 5, 6] and x is 3, then you might think that this
# doesn't match becase 4 is not equal to 3

# But that's not how it works in python. Instead, the second case binds the first element of the 
# list to x, over-writting the x passed in as an argument. In other words, x is set to be the first
# element of list, whatever it is. And so True is returned for any list of one or more elements.

# To implement it correctly, you would need to do something like this:
def good_contains(x, list):
    match list:
        case []:
            return False
        case [first, *rest]:
            return first == x or good_contains(x, rest)

print(good_contains(3, [])) # False
print(good_contains(3, [4])) # False
print(good_contains(3, [3])) # True
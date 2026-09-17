A = [1, 2, 3]
B = [4, 5, 6]

C = [a + b for a in A 
           for b in B]

#print(C)

L = [1, 2, 3, 4, 5, 0]
def is_sorted(L):
    return all(a <= b for a, b in zip(L, L[1:]))

def f(a, b, c):
    return a + b + c
#print(is_sorted(L))

# Use the star operator, *, to unpack lists:
# lst = [1, 2, 3]
# f(*[1, 2, 3])

# Task: Write the implementation for transposing a matrix. Use comprehensions
# matrix notation: [[1, 2, 3], [4, 5, 6]] <--transpose--> [[1, 4], [2, 5], [3, 6]]

# From the notes:
A = [[1, 2 ,3], [4, 5, 6]]
T = [list(row) for row in zip(*A)] 
print("Transpose: ", T) 
# abc_puzzle_sol.py

#
# Find all 3-digit numbers ABC such that
#
# - A, B, and C are all different digits (and A is not 0)
# - ABC + CBA is a number whose digits are all the same
# - A and B are not 0 (to avoid leading zeros)
# - ABC < CBA
#
# For example: 123 + 321 = 444
#
# Solution 1: use for-loops (and no comprehensions)
def sol_for_loops():
    solutions = []
    for a in range (0, 10):
        for b in range(0, 10):
            for c in range(0, 10):
               abc = str(a) + str(b) + str(c)
               cba = str(c) + str(b) + str(a)
               test = str(int(abc) + int(cba))
               if a != b != c != a and test[0] == test[1] == test[2] and int(abc) < int(cba) and a != 0 and b != 0:
                solutions.append(abc)

    print(solutions)

# Solution 2: use a single list comprehension (and no loops, no walrus operator)
def sol_list_comprehension():
    solutions = []
    # ...
    solutions = [str(a) + str(b) + str(c) for a in range(0, 10)
                              for b in range(0, 10)
                              for c in range(0, 10)
    if (a != b != c != a and str(int(str(a) + str(b) + str(c)) + int(str(c) + str(b) + str(c)))[0] ==  
        str(int(str(a) + str(b) + str(c)) + int(str(c) + str(b) + str(c)))[1] ==  
        str(int(str(a) + str(b) + str(c)) + int(str(c) + str(b) + str(c)))[2] and
        int(str(a) + str(b) + str(c)) < int(str(c) + str(b) + str(c)) and a != 0 and b != 0)]
    
    print(solutions)

# Solution 3: use a single list comprehension and the walrus operator
def sol_walrus():
    solutions = []
    # ...

    print(solutions)

#------------------------------------------------------------------
sol_for_loops()
sol_list_comprehension()
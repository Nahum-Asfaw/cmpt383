# recursive takes lines, does opearation similar to while loop
def recursive(lines, words, sum5):
    if len(words) == 0:
        if len(lines) == 0: # base case
            return sum5
        line = lines.pop()
        newWords = line.split()
        recursive(lines, newWords, sum5)
    else:
        c = words.pop()
        if c.isnumeric() and int(c) >= 1 and int(c) <= 100:
            sum5 += int(c)
        recursive(lines, words, sum5)

# 1: Using a for loop
def for_loop():
    l1 = []
    sum1 = 0

    with open('numbers.txt', 'r') as f:
        lines = f.readlines()

    for line in lines:
        words = line.split()
        for c in words:
            if c.isnumeric() and int(c) >= 1 and int(c) <= 100:
                sum1 += int(c)
                l1.append(c)
    l1.clear()
    return sum1

# 2: Using a while loop
def while_loop():
    l2 = []
    sum2 = 0

    with open('numbers.txt', 'r') as h:
        lines = h.readlines()

    while(len(lines) != 0): # i.e., while it is not empty
        line = lines.pop()
        words = line.split()
        while(len(words) != 0):
            c = words.pop()
            if c.isnumeric() and int(c) >= 1 and int(c) <= 100:
                sum2 += int(c)
                l2.append(c)

    l2.clear()
    return sum2

# 3: List comprehensions without the walrus operator, :=
def lc_no_walrus():
    sum3 = 0
    with open('numbers.txt', 'r') as h:
        lines = h.readlines()

    sum3 = sum([int(c) for line in lines
                       for c in line.split()
                       if c.isnumeric() and int(c) >= 1 and int(c) <= 100
    ])
    return sum3

# 4: List comprehensions with the walrus operator, :=
def lc_walrus():

    with open('numbers.txt', 'r') as h:
        lines = h.readlines()

    sum4 = 0
    [sum4 := (int(c) + sum4) for line in lines
                for c in line.split()
                if c.isnumeric() and int(c) >= 1 and int(c) <= 100
    ]
    return sum4

# 5: Using recursion
def rec():
    with open('numbers.txt', 'r') as f:
        lines = f.readlines()
        recursive(lines, [], 0)
# --------------------------------------------------------------------------
import timeit
timeit.timeit("for_loop", number=1000)
# Just doing list comprehensions as that's the only testable material
import time

# Decorator to measure time taken
def measure_time(f):
    def record(*args, **kwargs):
        print(f"Running {f.__name__} ...")
        start = time.time()
        this = f(*args, **kwargs)
        end = time.time()
        print(f"{f.__name__} took {end - start} seconds to run!")
        return this
    return record

# Q3
@measure_time
def using_lc(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()

    return sum(int(x) for line in lines for x in line.split() if 100 >= int(x) >= 1 if x.isnumeric())

# Q4
@measure_time
def using_lc_walrus(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()

    y = 0
    [y:=+(y + int(x)) for line in lines for x in line.split() if 100 >= int(x) >= 1 if x.isnumeric()]
    return y

a = using_lc("numbers.txt")
b = using_lc_walrus("numbers.txt")
print(f"a: {a}, b {b}")
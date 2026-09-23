# Python_practice
# Q1
def _fib(n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    return _fib(n-1) + _fib(n-2)

class Fib:
    def __init__(self, n):
        self.n = n
        self.index = 0
    
    def __iter__(self):
        return self
    
    def __next__(self):
        if self.index < self.n:
            self.index += 1
            return _fib(self.index -1)
        else:
            raise StopIteration

def testFib(n):
    for i in Fib(n):
        print(i)
#------------------------------
testFib(10)
#------------------------------
# Q2
def fib_gen(n):
    for x in range(0, n):
        yield _fib(x)
    
def testFib2(n):
    for i in fib_gen(n):
        print(i)
#-----------------------------
testFib2(10)    
#-----------------------------
# Q3
def take_any(f): # prints the func name, parameters, and return value
    def print_stuff(*args, **kwargs):
        print(f'{f.__name__} called with arg(s):', *args)
        this = f(*args, **kwargs)
        print("function returned: ")
        return this
    return print_stuff
    
@take_any
def fib(n):
    return _fib(n)

def testFib3(n):
    print(fib(n))
#----------------------------
testFib3(10)
#----------------------------
# Done.
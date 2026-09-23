# Python context managers are a way to manage resources in a clean and safe way.
# They are used to allocate and de-allocate resources such as files, sockets, and locks.

# A contex manager is an object that has __enter__ and __exit__ methods. They work with the 
# with statement. For example:
with open('file.txt') as f:
    for line in f:
        print(line)

# In this code, the file is opened when the with statement is entered, and when the loop exists,
# the file is closed. The context manager automatically takes care of the opening and closing
# of the file.
# Let's write our own context manager to show the basic idea. Consider the Greet class:
class Greet:
    def __init__(self, name):
        self.name = name

    def __enter__(self):
        print(f"Hello, {self.name}!")

    def __exit__(self, exc_type, exc_val, exc_tb):
        print(f"Goodbye, {self.name}!") 

# We can use it like this:
with Greet("Alice"):
    print("How are you?")

# You can replace __enter__ and __exit__ with whatever you want to do. For example,
# we could use it to start and stop a timer:
# Here is the Timer class:
import time
class Timer:
    def __enter__(self):
        """called when entering the 'with' block. Return value becomes the 'as' variable
        """
        self.start =time.perf_counter()
        return self # so you could do "with Timer() as t: ... t.start"

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Called when leaving the block (normal exit or exception)
        """
        elapsed = time.perf_counter() - self.start
        print(f"Elapsed: {elapsed:.3f} seconds")
        return False # False = don't suppress any exception; re-raise if one occurred

with Timer() as t:
    time.sleep(1)
    print("Done")

# The params to __exit__ are used for handling exceptions that might occur in the block
# of code:
# exc_type: the type of the exception that occurred, or None if no exception occured
# exc_val: the value of the exception that occurred, or None if no exception occured
# exc_tb: the traceback of the exception that occurred, or None if yk
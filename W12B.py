class Stack:
    def __init__(self):
        self.L = []

    def push(self, a):
        self.L.append(a)

    def pop(self):
        if len(self.L) > 0:
            return self.L.pop()
        return None
    
class Queue:
    def __init__(self):
        self.L = []

    def enqueue(self, a):
        self.L.append(a)

    def dequeue(self):
        if len(self.L) > 0:
            return self.L.pop(0)
        return None
def main():
    s = Stack()
    q = Queue()
    for i in range(1, 11):
        s.push(i)
    for _ in range(5):
        value = s.pop()
        if value is not None:
            q.enqueue(value)
    for _ in range(5):
        value = q.dequeue()
        if value is not None:
            s.push(value)
    while True:
        value = s.pop()
        if value is None:
            break
        print(value)

    

main()

"""
6
7
8
9
10
5
4
3
2
1
"""


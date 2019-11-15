from multiprocessing import Process

import sys


def f(name,pid):
    
    while(True):
        print('hello', name,pid)
    
i = 0

n = int(sys.argv[1])

#    print(sys.argv[1])

while i < n : 
    p = Process(target=f, args=('bob',i,))
    p.start()
#        p.join()
    i = i+1

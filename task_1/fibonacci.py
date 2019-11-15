import time
import logging
logging.basicConfig(level=logging.DEBUG)

a=0;
logging.info(a)
time.sleep(4)
b=1;
logging.info(b)
time.sleep(4)

while (True):    
    fib = a+b;
    logging.info(fib)
    time.sleep(4)
    a=b;
    b=fib;

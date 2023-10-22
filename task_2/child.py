import os
import time
import random
import sys


class Child:
    @staticmethod
    def work(arg: int):
        pid = os.getpid()
        sys.stdout.write(f"Child[{pid}]: I am started. My PID {pid}, Parent PID {os.getppid()}.\n")
        time.sleep(arg)
        sys.stdout.write(f"Child[{pid}]: I am ended. PID {pid}, Parent PID {os.getppid()}.\n")
        exit_code = random.randint(0, 1)
        os._exit(exit_code)


def main():
    Child.work(int(sys.argv[1]))


main()
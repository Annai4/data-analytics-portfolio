"""
======================================================================
Topic: Big-O Notation Analysis & Traveling Salesperson Problem (TSP)
Description: Analysis of algorithmic time complexity for various loop structures
======================================================================
"""

# ======================================================================
# PART 1: The Traveling Salesperson Problem (TSP) Theory
# ======================================================================
"""
What is the Traveling Salesperson Problem and what is its complexity?
- Problem: Given a list of cities and the distances between each pair of cities, 
  what is the shortest possible route that visits each city exactly once and returns to the origin city?
- Complexity: It is an NP-hard problem. 
- Why does it take so much time? As the number of cities (n) grows, the number of 
  possible routes grows factorially (O(n!)) or exponentially. 
  As the phrase states: "The more there are — the faster it grows!" ("Чем больше — тем быстрее растёт!").
  Brute-force search becomes computationally impossible for even a moderate number of cities.
"""


# ======================================================================
# PART 2: Practical Complexity Analysis (Tasks 1-4)
# ======================================================================

# --- TASK 1 ---
# Time Complexity: O(n)
# Reason: The outer loop runs 'n' times. However, the inner loop immediately breaks 
# after the first iteration (O(1) per outer step). Total operations = n * 1 = O(n).
def task_1(n: int) -> None:
    if n == 1:
        return
    for i in range(1, n + 1):
        # Inner loop equivalent: executes only once due to break
        print("*")
        break


# --- TASK 2 ---
# Time Complexity: O(n log n)
# Reason: The outer loop runs from n/2 to n, which takes ~n/2 iterations -> O(n).
# The inner loop doubles 'j' (j *= 2) up to n, taking O(log n) steps. 
# Combined complexity: O(n) * O(log n) = O(n log n).
def task_2(n: int) -> int:
    a = 0
    for i in range(n // 2, n + 1):
        j = 2
        while j <= n:
            a += n // 2
            j *= 2
    return a


# --- TASK 3 ---
# Time Complexity: O(n^2)
# Reason: This is a classic nested dependent loop. 
# The outer loop runs n times. The inner loop runs (n - i) times.
# Total iterations: n + (n-1) + (n-2) + ... + 1 = n(n+1)/2 = O(n^2).
def task_3(n: int) -> int:
    a = 0
    for i in range(n):
        for j in range(n, i, -1):
            a += i + j
    return a


# --- TASK 4 ---
# Time Complexity: O(log n)
# Reason: In each step of the while loop, 'i' is divided by 2 (i = i // 2). 
# The number of times you can divide a number n by 2 until it reaches 0 is log2(n).
def task_4(n: int) -> int:
    a = 0
    i = n
    while i > 0:
        a += i
        i = i // 2
    return a


# --- Execution and Verification ---
if __name__ == "__main__":
    n_test = 10
    print(f"Running complexity tasks with n = {n_test}:")
    print(f"Task 3 result (O(n^2)): {task_3(n_test)}")
    print(f"Task 4 result (O(log n)): {task_4(n_test)}")

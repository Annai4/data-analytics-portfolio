"""
======================================================================
Topic: Recursion, Iteration, and Classic Problems (Fibonacci & Hanoi)
Description: 
- Recursive vs Iterative Fibonacci functions
- Recursive solution for the Tower of Hanoi puzzle
======================================================================
"""

# ======================================================================
# 1. FIBONACCI NUMBERS (Recursive & Iterative)
# ======================================================================

def num_fib_recursive(n: int) -> int:
    """
    Calculates the n-th Fibonacci number using recursion.
    Time Complexity: O(2^n) - Exponential time due to overlapping subproblems.
    Space Complexity: O(n) - Call stack depth.
    """
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    else:
        return num_fib_recursive(n - 1) + num_fib_recursive(n - 2)


def num_fib_iterative(n: int) -> int:
    """
    Calculates the n-th Fibonacci number using iteration.
    Time Complexity: O(n) - Linear time.
    Space Complexity: O(1) - Constant space.
    """
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    
    a, b = 0, 1
    for _ in range(2, n + 1):
        a, b = b, a + b
    return b


# ======================================================================
# 2. THE TOWER OF HANOI
# ======================================================================

def hanoi_towers(n: int, source: str, target: str, auxiliary: str) -> None:
    """
    Solves the Tower of Hanoi puzzle recursively.
    Rules:
    1. Only one disk can be moved at a time.
    2. No disk can be placed on top of a smaller disk.
    
    Time Complexity: O(2^n) - Number of moves doubles with each extra disk.
    Space Complexity: O(n) - Maximum depth of the recursive call stack.
    """
    # Base case: if only one disk, move it directly from source to target
    if n == 1:
        print(f"Move disk 1 from rod {source} to rod {target}")
        return
    
    # Step 1: Move n-1 disks from source to auxiliary, using target as temporary
    hanoi_towers(n - 1, source, auxiliary, target)
    
    # Step 2: Move the remaining largest disk from source to target
    print(f"Move disk {n} from rod {source} to rod {target}")
    
    # Step 3: Move the n-1 disks from auxiliary to target, using source as temporary
    hanoi_towers(n - 1, auxiliary, target, source)


# --- Execution and Testing ---
if __name__ == "__main__":
    # Test Fibonacci sequence up to n = 6
    n = 6
    print(f"Fibonacci sequence (Recursive up to {n}):", [num_fib_recursive(i) for i in range(n + 1)])
    print(f"Fibonacci sequence (Iterative up to {n}):", [num_fib_iterative(i) for i in range(n + 1)])
    
    print("\n--- Tower of Hanoi Solution for 3 Disks ---")
    # 'A' = Left rod, 'C' = Right rod, 'B' = Middle (auxiliary) rod
    hanoi_towers(3, 'Left (A)', 'Right (C)', 'Middle (B)')

"""
======================================================================
Topic: Binary Trees - SumTree Validation
Description: 
- Verifies if a binary tree is a SumTree (where each node's value 
  equals the sum of its left and right subtrees).
Time Complexity: O(n^2) in the worst case for this specific approach 
                 (due to repeated subtree sums), or O(n) optimized.
Space Complexity: O(h) for the recursion call stack (h = tree height).
======================================================================
"""

class Node:
    """Class representing a tree node."""
    def __init__(self, key: int):
        self.data = key
        self.left = None
        self.right = None


def sum_all(root: Node) -> int:
    """
    Recursively calculates the sum of all node values in a subtree.
    """
    if root is None:
        return 0
    return sum_all(root.left) + root.data + sum_all(root.right)


def isSumTree(node: Node) -> int:
    """
    Checks if a binary tree is a SumTree.
    Returns 1 if it is a SumTree, 0 otherwise.
    """
    # Base case: empty tree or leaf node is a SumTree by definition
    if node is None or (node.left is None and node.right is None):
        return 1

    left_total = sum_all(node.left)
    right_total = sum_all(node.right)

    # Check current node condition and recursively check subtrees
    if (node.data == left_total + right_total) and \
       isSumTree(node.left) and isSumTree(node.right):
        return 1

    return 0


# --- Execution and Test Cases ---
if __name__ == "__main__":
    # Building the test tree from the example
    # Root(26) -> Left(10), Right(3)
    # Left(10) -> Left(4), Right(6)
    # Right(3) -> Right(3)
    root = Node(26)
    root.left = Node(10)
    root.right = Node(3)
    root.left.left = Node(4)
    root.left.right = Node(6)
    root.right.right = Node(3)

    if isSumTree(root):
        print("Результат: Це SumTree!")
    else:
        print("Результат: Це не SumTree!")

"""
======================================================================
Topic: Binary Trees - Identical Trees Validation
Description: 
- Checks if two binary trees are identical (same structure and same node values).
Time Complexity: O(n) - where n is the number of nodes in the smaller tree.
Space Complexity: O(h) - where h is the height of the tree (recursion stack).
======================================================================
"""

class Node:
    """Class for creating a tree node."""
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None


def identicalTrees(a: Node, b: Node) -> bool:
    """
    Recursively compares two binary trees. 
    Returns True if they are structurally identical and have the same node values, False otherwise.
    """
    # Base case: if both trees are empty (None), they are identical
    if a is None and b is None:
        return True

    # If both trees are NOT None, compare data and recursively check left and right subtrees
    if a is not None and b is not None:
        return (
            (a.data == b.data) and
            identicalTrees(a.left, b.left) and
            identicalTrees(a.right, b.right)
        )
    
    # If one tree is empty and the other is not, they are not identical
    return False


# --- Execution and Test Cases ---
if __name__ == "__main__":
    # Tree 1 setup
    root1 = Node(1)
    root1.left = Node(2)
    root1.right = Node(3)
    root1.left.left = Node(4)

    # Tree 2 setup (Identical to Tree 1)
    root2 = Node(1)
    root2.left = Node(2)
    root2.right = Node(3)
    root2.left.left = Node(4)

    # Tree 3 setup (Different structure)
    root3 = Node(1)
    root3.left = Node(2)
    root3.right = Node(3)
    root3.right.right = Node(4)

    # Tree 4 setup (Different values/structure)
    root4 = Node(1)
    root4.left = Node(5)
    root4.left.left = Node(4)
    root4.right = Node(3)

    res1 = identicalTrees(root1, root2)
    print(f"Are root1 and root2 identical? {res1}")  # Expected: True

    res2 = identicalTrees(root3, root4)
    print(f"Are root3 and root4 identical? {res2}")  # Expected: False

"""
======================================================================
Topic: Data Structures - Stack Implementation using Array (List)
Description: 
- Implementing core stack operations: push, pop, empty, peek, search.
Time Complexity: 
- push/pop/peek: O(1) at the top of the stack.
- search: O(n) linear search through the stack elements.
Space Complexity: O(n) to store elements in the list.
======================================================================
"""

class Stack:
    """A custom Stack implementation using a Python list as the underlying array."""
    
    def __init__(self):
        """Initialize an empty stack."""
        self.stack = []
        
    def empty(self) -> bool:
        """Check if the stack is empty. Returns True if empty, False otherwise."""
        return len(self.stack) == 0

    def push(self, elem) -> None:
        """Push a new element onto the top of the stack."""
        self.stack.append(elem)

    def pop(self):
        """Remove and return the top element from the stack. Returns None if empty."""
        if self.empty():
            return None
        return self.stack.pop()

    def peek(self):
        """Return the top element of the stack without removing it."""
        if self.empty():
            return None
        return self.stack.tail if hasattr(self, 'tail') else self.stack[-1]

    def search(self, element) -> int:
        """
        Determine if an object exists in the stack. 
        If found, returns the 1-based position from the top of the stack.
        Otherwise, returns -1.
        """
        if element not in self.stack:
            return -1
        
        # Finding distance from the top of the stack (1-based index from the end)
        # Standard Stack search convention: top element has position 1.
        index_from_bottom = self.stack.index(element)
        position_from_top = len(self.stack) - index_from_bottom
        return position_from_top

    def __repr__(self) -> str:
        """Magic method to provide a clean string representation of the stack."""
        return f"Stack(top -> bottom): {list(reversed(self.stack))}"


# --- Execution and Test Cases ---
if __name__ == "__main__":
    st = Stack()
    
    print("Is stack empty?", st.empty())  # Expected: True
    
    st.push(534)
    st.push('Hah')
    st.push('Boo')
    
    print(st)  # Shows stack contents
    print("Top element (peek):", st.peek())  # Expected: 'Boo'
    
    # Search for elements (position from the top)
    print("Position of 'Hah':", st.search('Hah'))  # Expected: 2
    print("Position of 534:", st.search(534))    # Expected: 3
    print("Position of missing item:", st.search('Missing'))  # Expected: -1
    
    # Pop an element and check state
    popped = st.pop()
    print(f"Popped element: {popped}")
    print(st)

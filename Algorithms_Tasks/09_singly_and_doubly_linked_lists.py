"""
======================================================================
Topic: Data Structures - Singly and Doubly Linked Lists
Description: 
- Implementation of MyLinkedList (Singly Linked List) with tail optimization.
- Implementation of DoublyLinkedList with prev/next pointers.
Time Complexity: 
- append/pushToTail (with tail pointer): O(1)
- get / search / removeLast: O(n)
======================================================================
"""

# ======================================================================
# 1. SINGLY LINKED LIST (MyLinkedList)
# ======================================================================

class Node:
    """Container node for Singly Linked List."""
    def __init__(self, data):
        self.data = data
        self.next = None


class MyLinkedList:
    """Singly Linked List implementation."""
    def __init__(self):
        self.head = None

    def pushToTail(self, data):
        """Adds a new element to the end of the list. Time: O(n)"""
        new_node = Node(data)
        if not self.head:
            self.head = new_node
            return

        last_node = self.head
        while last_node.next:
            last_node = last_node.next

        last_node.next = new_node

    def removeLast(self):
        """Removes the last element from the list. Time: O(n)"""
        if not self.head:
            return

        if not self.head.next:
            self.head = None
            return

        current = self.head
        while current.next.next:
            current = current.next

        current.next = None

    def get(self, index: int):
        """Gets element data by index. Time: O(n)"""
        current = self.head
        count = 0

        while current:
            if count == index:
                return current.data
            current = current.next
            count += 1
        return None


# ======================================================================
# 2. DOUBLY LINKED LIST (DoublyLinkedList)
# ======================================================================

class DNode:
    """Container node for Doubly Linked List with prev and next pointers."""
    def __init__(self, data=None):
        self.data = data
        self.next = None
        self.prev = None


class DoublyLinkedList:
    """Doubly Linked List implementation."""
    def __init__(self):
        self.head = None
        self.tail = None  # Pointer to tail optimizes append to O(1)

    def append(self, data):
        """Add element to the tail. Time: O(1) with tail pointer."""
        new_node = DNode(data)
        if not self.head:
            self.head = new_node
            self.tail = new_node
            return
        
        self.tail.next = new_node
        new_node.prev = self.tail
        self.tail = new_node

    def prepend(self, data):
        """Add element to the head. Time: O(1)"""
        new_node = DNode(data)
        if self.head:
            self.head.prev = new_node
        else:
            self.tail = new_node  # If list was empty, tail is also the new node
            
        new_node.next = self.head
        self.head = new_node

    def delete_with_value(self, data):
        """Deletes the first node containing the specified data."""
        current_node = self.head
        while current_node:
            if current_node.data == data:
                if current_node.prev:
                    current_node.prev.next = current_node.next
                else:
                    self.head = current_node.next  # Deleting head

                if current_node.next:
                    current_node.next.prev = current_node.prev
                else:
                    self.tail = current_node.prev  # Deleting tail

                return
            current_node = current_node.next

    def print_list(self):
        """Prints elements from head to tail."""
        current_node = self.head
        while current_node:
            print(current_node.data, end=" <-> ")
            current_node = current_node.next
        print("None")


# --- Execution and Testing ---
if __name__ == "__main__":
    print("--- Testing Singly Linked List ---")
    proverka = MyLinkedList()
    proverka.pushToTail(1)
    proverka.pushToTail("A")
    proverka.pushToTail(18)
    proverka.pushToTail(129)
    proverka.pushToTail(4)
    proverka.removeLast()
    proverka.removeLast()
    
    result = proverka.get(2)
    print("Element at index 2 (Singly):", result)  # Expected: 18

    print("\n--- Testing Doubly Linked List ---")
    sl2 = DoublyLinkedList()
    sl2.append(4)
    sl2.append(2)
    sl2.append("Uf")
    sl2.prepend(5)
    sl2.print_list()  # Expected: 5 <-> 4 <-> 2 <-> Uf <-> None
    
    sl2.delete_with_value(5)
    sl2.print_list()  # Expected: 4 <-> 2 <-> Uf <-> None

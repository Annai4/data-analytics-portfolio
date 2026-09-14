"""
======================================================================
Topic: Merge Sort Algorithm & Multi-File Merging
Description: 
- Implementation of Merge Sort using 'Divide and Conquer' paradigm.
- Merging multiple sorted files/lists into a single sorted file.
Time Complexity: O(n log n) for sorting.
Space Complexity: O(n) for auxiliary arrays.
======================================================================
"""

# ======================================================================
# 1. MERGE SORT IMPLEMENTATION
# ======================================================================

def merge(left: list, right: list) -> list:
    """
    Merges two sorted lists into a single sorted list.
    """
    result = []
    i = j = 0  # Pointers for left and right lists

    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
            
    # Append any remaining elements
    result.extend(left[i:])
    result.extend(right[j:])
    return result


def merge_sort(arr: list) -> list:
    """
    Sorts a list using the Merge Sort algorithm (Divide and Conquer).
    - Divides the array recursively until each sub-array has 1 or 0 elements.
    - Merges the sub-arrays back in sorted order.
    """
    if len(arr) <= 1:
        return arr                      

    mid = len(arr) // 2
    left = merge_sort(arr[:mid])      
    right = merge_sort(arr[mid:])
    
    return merge(left, right)


# ======================================================================
# 2. MULTI-FILE SORTED MERGING
# ======================================================================

def read_sorted_file(path: str, dtype=type(int)) -> list:
    """
    Reads a text file line by line and converts contents into a list of numbers.
    """
    with open(path, "r", encoding="utf8") as f:
        return [dtype(line.strip()) for line in f if line.strip()]


def merge_two_lists(a: list, b: list) -> list:
    """Helper function to merge two lists for multi-list merging."""
    i = j = 0
    res = []
    while i < len(a) and j < len(b):
        if a[i] <= b[j]:
            res.append(a[i])
            i += 1
        else:
            res.append(b[j])
            j += 1
    res.extend(a[i:])
    res.extend(b[j:])
    return res


def merge_k_lists(lists: list) -> list:
    """
    Merges multiple sorted lists into a single sorted list iteratively.
    """
    res = []
    for lst in lists:
        res = merge_two_lists(res, lst)
    return res


# --- Execution and Testing ---
if __name__ == "__main__":
    # Test Merge Sort
    sample_data = [48, -12, 93, 48, 0, 512, -88, 305, 777, 123, 456, -5, 999, 271, 512]
    sorted_sample = merge_sort(sample_data)
    print("Original array:", sample_data)
    print("Sorted array via Merge Sort:", sorted_sample)
    
    # Simulation of multi-file merging (using mock list data)
    file_lists = [
        [1, 5, 9],
        [2, 6, 10],
        [3, 4, 8]
    ]
    merged_multiple = merge_k_lists(file_lists)
    print("\nMerged multiple sorted lists:", merged_multiple)

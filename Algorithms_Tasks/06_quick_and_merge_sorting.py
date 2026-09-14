"""
======================================================================
Topic: Advanced Sorting Algorithms (Merge Sort & Iterative QuickSort)
Description: 
- Merge Sort using Divide and Conquer (Recursive)
- QuickSort implemented iteratively using an explicit stack
Time Complexity: O(n log n) average for both algorithms.
Space Complexity: O(n) for Merge Sort, O(log n) for QuickSort stack.
======================================================================
"""

# ======================================================================
# 1. MERGE SORT (Recursive)
# ======================================================================

def merge(left: list, right: list) -> list:
    """Helper function to merge two sorted lists."""
    output = []
    i = j = 0

    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            output.append(left[i])
            i += 1
        else:
            output.append(right[j])
            j += 1

    output.extend(left[i:])
    output.extend(right[j:])
    return output


def merge_sort(lst: list) -> list:
    """
    Sorts a list using the Merge Sort algorithm recursively.
    """
    if len(lst) <= 1:
        return lst

    mid = len(lst) // 2
    left_partition = merge_sort(lst[:mid])
    right_partition = merge_sort(lst[mid:])

    return merge(left_partition, right_partition)


# ======================================================================
# 2. ITERATIVE QUICKSORT
# ======================================================================

def partition(arr: list, low: int, high: int) -> int:
    """
    Partitions the array around a pivot (choosing the last element).
    Elements smaller than the pivot are moved to the left, larger to the right.
    """
    pivot = arr[high]
    i = low - 1

    for j in range(low, high):
        if arr[j] <= pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]

    arr[i + 1], arr[high] = arr[high], arr[i + 1]
    return i + 1


def quicksort_iterative(arr: list) -> list:
    """
    Sorts a list in-place using an iterative QuickSort approach with an explicit stack.
    Avoids recursion depth limits.
    """
    if len(arr) <= 1:
        return arr

    stack = []
    stack.append((0, len(arr) - 1))

    while stack:
        low, high = stack.pop()

        if low >= high:
            continue

        pivot_idx = partition(arr, low, high)

        # Push sub-arrays to stack, pushing the smaller part first to optimize stack size
        if pivot_idx - low < high - pivot_idx:
            stack.append((low, pivot_idx - 1))
            stack.append((pivot_idx + 1, high))
        else:
            stack.append((pivot_idx + 1, high))
            stack.append((low, pivot_idx - 1))

    return arr


# --- Execution and Testing ---
if __name__ == "__main__":
    # Test Merge Sort
    data_list = [6, 8, 1, 4, 5, 3, 7, 9]
    print(f"Unsorted (Merge Sort test): {data_list}")
    sorted_merge = merge_sort(data_list)
    print(f"Sorted via Merge Sort: {sorted_merge}")

    # Test Iterative QuickSort
    lst2 = [23, 15, 28, 3, 16, 77, 80, 94, 62, 19]
    print(f"\nUnsorted (QuickSort test): {lst2}")
    quicksort_iterative(lst2)
    print(f"Sorted via Iterative QuickSort: {lst2}")

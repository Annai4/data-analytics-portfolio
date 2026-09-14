"""
======================================================================
Topic: Two Pointers / Merging Sorted Arrays
Task: Find the k-th element in two sorted arrays
Time Complexity: O(m + n) - where m and n are lengths of the arrays.
Space Complexity: O(m + n) - memory used for the merged array.
======================================================================
"""

def find_kth_element(arr1: list, arr2: list, k: int) -> int:
    """
    Finds the element at the k-th position (1-based index) in the combined 
    sorted array formed by merging two sorted arrays.
    
    Parameters:
    - arr1: First sorted list of integers
    - arr2: Second sorted list of integers
    - k: The target position (1-based index)
    
    Returns:
    - The value at the k-th position.
    """
    n = len(arr1)
    m = len(arr2)
    
    if k < 1 or k > n + m:
        raise ValueError("k is out of the combined array length range.")

    sorted_merged = [0] * (n + m)
    i = 0  # Pointer for arr1
    j = 0  # Pointer for arr2
    d = 0  # Pointer for merged array

    # Merge two sorted arrays
    while i < n and j < m:
        if arr1[i] <= arr2[j]:
            sorted_merged[d] = arr1[i]
            i += 1
        else:
            sorted_merged[d] = arr2[j]
            j += 1
        d += 1

    # Append remaining elements from arr1, if any
    while i < n:
        sorted_merged[d] = arr1[i]
        i += 1
        d += 1

    # Append remaining elements from arr2, if any
    while j < m:
        sorted_merged[d] = arr2[j]
        j += 1
        d += 1

    # Return the element at index k - 1 (converting 1-based index to 0-based)
    return sorted_merged[k - 1]


# --- Execution and Test Cases ---
if __name__ == "__main__":
    arr1 = [100, 112, 256, 349, 770]
    arr2 = [72, 86, 113, 119, 265, 445, 892]
    k = 7
    
    result = find_kth_element(arr1, arr2, k)
    print(f"The {k}-th element in the combined sorted array is: {result}")  # Expected: 256

"""
======================================================================
Topic: Greedy Algorithms
Description: 
- Coin Change Problem (finding the optimal set of coins for a given amount)
- Activity Selection Problem (maximizing non-overlapping activities)
Time Complexity: 
- Coin Change: O(n log n + amount / min_coin)
- Activity Selection: O(n log n) due to sorting by finish times.
======================================================================
"""

# ======================================================================
# 1. COIN CHANGE PROBLEM
# ======================================================================

def change_coins(amount: int, coins: list) -> list:
    """
    Greedy approach to find the minimum/optimal set of coins 
    to make up a given amount.
    """
    change = []
    # Sort coins in descending order to always pick the largest possible coin first
    coins.sort(reverse=True)

    for coin in coins:
        while amount >= coin:
            change.append(coin)
            amount -= coin
            
    return change


# ======================================================================
# 2. ACTIVITY SELECTION PROBLEM
# ======================================================================

def activity_selection(start_times: list, finish_times: list) -> list:
    """
    Selects the maximum number of activities that can be performed 
    by a single person, assuming they can only work on one activity at a time.
    Greedy strategy: always pick the activity that finishes earliest.
    """
    n = len(start_times)
    if n == 0:
        return []

    # Combine start and finish times into pairs of tuples
    activities = list(zip(start_times, finish_times))
    
    # Sort activities by their finish time (index 1)
    activities.sort(key=lambda x: x[1])

    # The first activity that finishes earliest is always selected
    selected_activities = [activities[0]]
    last_finish_time = activities[0][1]

    # Iterate through the remaining activities
    for i in range(1, n):
        current_start, current_finish = activities[i]
        
        # If the start time of the current activity is greater than or equal 
        # to the finish time of the previous selected activity, select it.
        if current_start >= last_finish_time:
            selected_activities.append(activities[i])
            last_finish_time = current_finish

    return selected_activities


# --- Execution and Test Cases ---
if __name__ == "__main__":
    # Test Coin Change
    print("--- Coin Change Tests ---")
    amount_1 = 100
    coins_1 = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
    print(f"Amount {amount_1}, Coins {coins_1} -> Result:", change_coins(amount_1, coins_1))

    amount_2 = 23
    coins_2 = [10, 10, 2, 1]
    print(f"Amount {amount_2}, Coins {coins_2} -> Result:", change_coins(amount_2, coins_2))

    # Test Activity Selection
    print("\n--- Activity Selection Tests ---")
    start_times = [1, 3, 0, 5, 8, 5]
    finish_times = [2, 4, 6, 7, 9, 9]
    print("Selected activities (start, finish):", activity_selection(start_times, finish_times))

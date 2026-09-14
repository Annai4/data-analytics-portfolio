"""
======================================================================
Topic: Dictionaries, Collections, and Text Processing
Task: Letter Frequency Dictionary for English and German alphabets
Time Complexity: O(N), where N is the length of the text.
Space Complexity: O(U), where U is the size of the alphabet.
======================================================================
"""

from collections import Counter

def letter_frequency(text: str, alphabet: str) -> dict:
    """
    Builds a frequency dictionary of letters for a given text 
    based on a specific alphabet.
    """
    # Normalize text to lower case
    text = text.lower()
    
    # Filter text to include only letters present in the given alphabet
    filtered_chars = [ch for ch in text if ch in alphabet]
    
    # Count frequencies using Counter
    frequency_counter = Counter(filtered_chars)
    
    # Return as a regular dictionary (sorted by frequency descending)
    return dict(frequency_counter.most_common())


# --- Execution and Test Cases ---
if __name__ == "__main__":
    english = 'abcdefghijklmnopqrstuvwxyz'
    german  = 'abcdefghijklmnopqrstuvwxyzäöüß'
    
    text = "Hier steht Ihr Text. ÄÖÜ äöü ß, and English letters too!"
    
    print("--- English Alphabet Frequency ---")
    print(letter_frequency(text, english))
    
    print("\n--- German Alphabet Frequency ---")
    print(letter_frequency(text, german))

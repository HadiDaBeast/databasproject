def get_one_indices(input_str):
    result = ''
    for idx, char in enumerate(input_str):
        if char == '1':
            if idx <= 9:
                result += str(idx)
            else:
                result += index_to_letters(idx)
    return result

def index_to_letters(index):
    # Convert 10 -> 'A', 11 -> 'B', ..., 35 -> 'Z', 36 -> 'AA', etc.
    index -= 10
    letters = ''
    while True:
        letters = chr(ord('A') + (index % 26)) + letters
        index = index // 26 - 1
        if index < 0:
            break
    return letters

# Example usage:
input_str = "1000000000001000000000000000000010"
print(get_one_indices(input_str))

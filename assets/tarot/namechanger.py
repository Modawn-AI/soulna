import os
import re

# Read the new names from the text file
with open('asia_name.txt', 'r') as file:
    new_names = [line.strip() + '.png' for line in file]

# Get all files in the current directory that match the pattern
files = sorted([f for f in os.listdir('.') if re.match(r'KArtStyle_A\d+_N\d+\.png', f)])

# Rename files
for old_name, new_name in zip(files, new_names):
    os.rename(old_name, new_name)
    print(f'Renamed: {old_name} -> {new_name}')

print("Renaming complete.")
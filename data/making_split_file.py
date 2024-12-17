import pandas as pd
import os
print("Current working directory:", os.getcwd())
# File paths
train_path = "data/train_split.csv"
test_path = "data/test_split.csv"
val_path = "data/val_split.csv"
output_path = "data/split.csv"

# Read the CSV files
train_df = pd.read_csv(train_path)
test_df = pd.read_csv(test_path)
val_df = pd.read_csv(val_path)

# Add a split column to each DataFrame
train_df['split'] = 'train'
test_df['split'] = 'test'
val_df['split'] = 'val'

# Concatenate the DataFrames
merged_df = pd.concat([train_df, test_df, val_df], ignore_index=True)

# Ensure correct column names for compatibility with get_simi
merged_df.columns = ['filename', 'split']

# Save the merged DataFrame to a new CSV file
merged_df.to_csv(output_path, index=False)

print(f"Merged file saved as {output_path}")

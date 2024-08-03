import os

def delete_png_files(folder_path):
    # Ensure the folder path exists
    if not os.path.exists(folder_path):
        print(f"The folder {folder_path} does not exist.")
        return

    # Counter for deleted files
    deleted_count = 0

    # Iterate through all files in the folder
    for filename in os.listdir(folder_path):
        if filename.lower().endswith('.png'):
            file_path = os.path.join(folder_path, filename)
            try:
                os.remove(file_path)
                print(f"Deleted: {filename}")
                deleted_count += 1
            except Exception as e:
                print(f"Error deleting {filename}: {str(e)}")

    print(f"Total PNG files deleted: {deleted_count}")

# Usage
folder_path = '/home/ubuntu/pictures'  # Replace with your folder path
delete_png_files(folder_path)
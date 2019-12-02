import csv
from robot.api.deco import keyword

"""CSV Library"""
__all__ = ['clear_file', 'append_file']


@keyword('Clear file')
def clear_file(filepath):  # Clear_file :it will clear your file.
    with open(filepath, 'w+') as file:
        writer = csv.writer(file)


@keyword('Append file')
def append_file(filepath, data):  # Append_file :it will append the data you wanted to in your script.
    with open(filepath, 'a') as file:
        # csv.Dialect.delimiter = delimiter
        writer = csv.writer(file, delimiter='|', quoting=csv.QUOTE_NONE, escapechar=' ')
        writer.writerow(data)

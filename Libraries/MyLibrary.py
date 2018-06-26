from robot.api.deco import keyword

import os
import hashlib
import logging

"""Custom library"""
__all__ = ['get_list_of_files_from_directory', 'check_file_in_list',
           'get_md5_of_file_by_path', 'compare_values']


@keyword('List of files')
def get_list_of_files_from_directory(path):
    """The function takes the path to the directory and returns a
    list of files in this directory"""
    logging.debug("Got path to directory %s" % path)
    for root, dirs, files in os.walk(path):
        return files


@keyword('File is in folder?')
def check_file_in_list(file_name, dirlist):
    """The function checks whether the filename is present in the list of files
     from the directory. Accepts the file name and file list in the directory,
     returns True / False"""
    if file_name in dirlist:
        logging.debug('{!r} is present in {!s}'.format(file_name, dirlist))
        return True
    else:
        logging.debug('{!r} is not present in {!s}'.format(file_name, dirlist))
        return False


@keyword('Calc ${path} MD5')
def get_md5_of_file_by_path(path):
    """The function evaluates MD5 of the file. Accepts the path to the file
    and returns the file MD5 itself."""
    md5 = hashlib.md5(open(path, 'rb').read()).hexdigest()
    logging.debug('md5 successfully got')
    return md5


@keyword('Values are equal?')
def compare_values(value_1, value_2):
    """The function compares 2 values. Takes 2 values and returns True / False"""
    if value_1 == value_2:
        logging.debug('Values are equal')
        return True
    else:
        logging.debug('Values are not equal')
        raise MyFatalError.__new__(RuntimeError)


class MyFatalError(RuntimeError):
    ROBOT_EXIT_ON_FAILURE = True

# from robot.api.deco import keyword

import os
import hashlib
import logging


def get_list_of_files_from_directory(path):
    logging.debug("Got path to directory %s" % path)
    for root, dirs, files in os.walk(path):
        return files
    logging.INFO('This is a boring example')


def check_file_in_list(file_name, dirlist):
    if file_name in dirlist:
        logging.debug('{!r} is present in {!s}'.format(file_name, dirlist))
        return True
    else:
        logging.debug('{!r} is not present in {!s}'.format(file_name, dirlist))
        return False


def get_md5_of_file_by_path(path):
    md5 = hashlib.md5(open(path, 'rb').read()).hexdigest()
    logging.debug('md5 successfully got')
    return md5


def compare_values(value_1, value_2):
    if value_1 == value_2:
        logging.debug('Values are equal')
        return True
    else:
        logging.debug('Values are not equal')
        return False

# from robot.api.deco import keyword
# from robot.api import logger
import os
import hashlib
import logging


class MyLibrary_v1:
    ROBOT_LIBRARY_VERSION = '1.0'

    def __init__(self, path_to_folder):
        self.__path_to_folder = path_to_folder

    def get_list_of_files_from_directory(self):
        logging.debug("Got path to directory %s" % self.__path_to_folder)
        for root, dirs, files in os.walk(self.__path_to_folder):
            return files

    def check_file_in_list(self, file_name, dirlist):
        if file_name in dirlist:
            logging.debug('{!r} is present in {!s}'.format(file_name, dirlist))
            return True
        else:
            logging.debug('{!r} is not present in {!s}'.format(file_name, dirlist))
            return False

    def get_md5_of_file_by_path(self, name_of_file):
        md5 = hashlib.md5(open(self.__path_to_folder + name_of_file, 'rb').read()).hexdigest()
        logging.debug('md5 successfully got')
        return md5

    def compare_values(self, value_1, value_2):
        if value_1 == value_2:
            logging.debug('Values are equal')
            return True
        else:
            logging.debug('Values are not equal')
            return False

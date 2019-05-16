#!/usr/bin/python3

import sqlite3
import json
import logging
import time

class ap_sqlite:
    def __init__(self, database_name = "tmp/database0.db"):
        self.database_name = database_name

        self.index_id = {
                self.database_name : -1,
                }

    def create_tables(self, database_name):
        _sqlite_conn = sqlite3.connect(database_name)
        _create_tables_cursor = _sqlite_conn.cursor()
        try :
            self.index_id[database_name] = -1
            _create_tables_cursor.execute('''CREATE TABLE SENSOR
                (ID             INT PRIMARY KEY NOT NULL,
                message         BLOB            NOT NULL
                );''')
        except :
            self.index_id[self.database_name] = \
                    self.search_last_data(self.database_name)
            logging.debug("table aleady created")

        _sqlite_conn.commit()
        _sqlite_conn.close()

    def insert_data(self, message, database_name):
        _sqlite_conn = sqlite3.connect(database_name)

        _insert_data_cursor = _sqlite_conn.cursor()

        self.index_id[database_name] = self.index_id[database_name] + 1

        _insert_data_cursor.execute("INSERT INTO SENSOR VALUES (?, ?)", \
                (self.index_id[database_name], message))

        _sqlite_conn.commit()
        _sqlite_conn.close()

    def search_last_data(self, database_name):
        ret_data = -1

        _sqlite_conn = sqlite3.connect(database_name)
        _search_data_cursor = _sqlite_conn.cursor()

        try :
            data = _search_data_cursor.execute(\
                    "select * from SENSOR order by id desc limit 0,1")

            tmp_data = data.fetchone()
            ret_data = tmp_data[0]
        except :
            pass

        _sqlite_conn.close()
        return ret_data

    def print_all_data(self, database_name):
        ret_data = []
        data = None
        _sqlite_conn = sqlite3.connect(database_name)

        _print_all_data = _sqlite_conn.cursor()

        data = _print_all_data.execute("select * from SENSOR")

        for tmp_data in data:
            ret_data.append(tmp_data[1])

        _print_all_data.execute("delete from SENSOR")

        _sqlite_conn.commit()
        _sqlite_conn.close()
        self.index_id[database_name] = -1

        return ret_data

if __name__ == "__main__":
    pass


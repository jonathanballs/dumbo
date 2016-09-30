module Dumbo.DbDatabase;

import Dumbo.DbTable;

class DbDatabase {
    string name;
    string[] tableNames;

    this(string name, string[] tableNames) {
        this.name = name;
        this.tableNames = tableNames;
    }

    string getName() { return name; }
    string[] getTableNames() { return tableNames; }
}


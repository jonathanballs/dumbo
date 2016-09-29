module Dumbo.Backends.SqliteBackend;

import std.typecons : Nullable;
import std.stdio;
import d2sqlite3;
import Dumbo.Backends.DatabaseBackend;

class SqliteBackend : DatabaseBackend {

    private string databaseName;

    this(string databaseName) {
        this.databaseName = databaseName;
    }

    public string getName() {
        return databaseName;
    }

    public string[] getTableNames() {
        string statement = "SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name";
        string[] tableNames;

        auto db = Database(databaseName);
        ResultRange results = db.execute(statement);
        foreach (Row row; results) {
            string tableName = row.peek!string(0);
            tableNames ~= tableName;
        }
        db.close();

        return tableNames;
    }

    public string[] getColumnNames(string tableName) {
        string statement = "PRAGMA table_info(" ~ tableName ~ ")";
        string[] columnNames;
        auto db = Database(databaseName);

        ResultRange results = db.execute(statement);
        foreach (Row row; results) {
            string columnName = row.peek!string(1);
            columnNames ~= columnName;
        }
        db.close();

        return columnNames;
    }
}


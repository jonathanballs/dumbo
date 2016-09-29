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
        string statement = "SELECT name FROM sqlite_master WHERE type = 'table'";
        string[] names;

        auto db = Database(databaseName);
        ResultRange results = db.execute(statement);
        foreach (Row row; results) {
            string name = row.peek!string(0);
            names ~= name;
        }
        db.close();

        return names;
    }

    public string[] getColumnNames(string table) {
        return ["pk", "username", "password", "firstname", "lastname"];
    }
}


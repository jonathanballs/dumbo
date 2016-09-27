module Dumbo.Backends.SqliteBackend;

import Dumbo.Backends.DatabaseBackend;

class SqliteBackend : DatabaseBackend {

    private string databaseName;

    this(string databaseName) {
        this.databaseName = databaseName;
    }

    public string getName() {
        return "ayy lmao";
    }

    public string[] getTableNames() {
        return ["users", "books", "other"];
    }

    public string[] getColumnNames(string table) {
        return ["pk", "username", "password", "firstname", "lastname"];
    }
}


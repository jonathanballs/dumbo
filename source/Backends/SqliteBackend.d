module Dumbo.Backends.SqliteBackend;

import std.typecons : Nullable;
import std.stdio;
import std.string;
import d2sqlite3;
import Dumbo.Backends.DatabaseBackend;
import Dumbo.DbTable;
import Dumbo.DbColumn;
import Dumbo.Constants;

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

    public DbTable getTable(string tableName) {
        auto table = new DbTable(tableName, this.getColumns(tableName));
        table.setRows(this.getRows(tableName));
        return table;
    }

    public DbColumn[] getColumns(string tableName) {
        DbColumn[] columns;
        auto db = Database(databaseName);

        string statement = "PRAGMA table_info(" ~ tableName ~ ")";
        ResultRange results = db.execute(statement);

        foreach (Row row; results) {
            string columnName = row.peek!string(Constants.pragmaCNameColumn);
            string columnTypeString = row.peek!string(Constants.pragmaCTypeColumn);
            columnTypeString = columnTypeString.toLower();

            // Parse dataType to basic type affinities
            DbValueType columnType;
            if (columnTypeString.indexOf("int") >= 0) {
                columnType = DbValueType.INTEGER;
            }
            else if (columnTypeString.indexOf("char") >= 0
                    || columnTypeString.indexOf("clob") >= 0
                    || columnTypeString.indexOf("text") >= 0) {

                columnType = DbValueType.TEXT;
            }
            else if (columnTypeString.indexOf("blob") >= 0) {

                columnType = DbValueType.BLOB;
            }
            else if (columnTypeString.indexOf("real") >= 0
                    || columnTypeString.indexOf("floa") >= 0
                    || columnTypeString.indexOf("doub") >= 0) {

                columnType = DbValueType.REAL;
            }
            else {

                columnType = DbValueType.TEXT;
            }

            columns ~= new DbColumn(columnName, columnType);

        }
        db.close();

        return columns;
    }

    public string[][] getRows(string tableName) {
        string statement = "SELECT * FROM " ~ tableName ~ " ORDER BY rowid ASC";
        string[][] rows;

        auto db = Database(databaseName);
        ResultRange results = db.execute(statement);

        int numberOfColumns = cast(int)this.getColumns(tableName).length;

        foreach (Row row; results) {
            string[] rowValues;
            foreach (i; 0 .. numberOfColumns) {
                rowValues ~= row.peek!string(i);
            }
            rows ~= rowValues;
        }
        db.close();

        return rows;
    }
}


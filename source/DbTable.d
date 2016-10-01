module Dumbo.DbTable;

import Dumbo.DbColumn;

class DbTable {
    private string name;
    private DbColumn[] columns;
    private string[][] rows;

    this(string tableName, DbColumn[] tableColumns) {
        this.name = tableName;
        this.columns = tableColumns;
    }


    string getName() { return name; }
    DbColumn[] getColumns() { return columns; }
    string[][] getRows() { return rows; }
    void setRows(string[][] rows) { this.rows = rows; }

    string[] getColumnNames() {
        string[] columnNames;

        foreach(column; columns) {
            columnNames ~= column.getName();
        }

        return columnNames;
    }
}


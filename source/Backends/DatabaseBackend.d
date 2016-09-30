module Dumbo.Backends.DatabaseBackend;

import Dumbo.DbTable;
import Dumbo.DbColumn;

interface DatabaseBackend {
    // Get database name
    public string getName();

    // Get list of tables names
    public string[] getTableNames();

    // Get a tables
    public DbTable getTable(string tableName);

    // Get list of columns
    public DbColumn[] getColumns(string tableName);
}

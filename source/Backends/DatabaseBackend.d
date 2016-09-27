module Dumbo.Backends.DatabaseBackend;

interface DatabaseBackend {
    // Get database name
    public string getName();

    // Get list of tables
    public string[] getTableNames();

    // Get column headers
    public string[] getColumnNames(string table);
}

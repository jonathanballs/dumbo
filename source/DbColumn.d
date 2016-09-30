module Dumbo.DbColumn;

import gtkc.gobjecttypes;

enum DbValueType {
    // Sqlite Type Affinities
    TEXT,
    NUMERIC,
    INTEGER,
    REAL,
    BLOB,
}

class DbColumn {
    private DbValueType type;
    private string name;
    
    this(string name, DbValueType type) {
        this.name = name;
        this.type = type;
    }

    string getName() { return name; }
    DbValueType getType() { return type; }

    GType getTypeGType() {
        switch(this.type) {
            case DbValueType.INTEGER:
                return GType.INT;
            case DbValueType.TEXT:
            case DbValueType.BLOB:
                return GType.STRING;
            case DbValueType.REAL:
                return GType.FLOAT;
            default:
                return GType.STRING;
        }
    }
}


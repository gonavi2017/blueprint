// Package field provides access to the field table in the MySQL database.
package field

import (
	"database/sql"
	"fmt"

	"github.com/go-sql-driver/mysql"
)

var (
	// table is the table name.
	table = "field"
)

// Item defines the model.
type Item struct {
	ID          uint32         `db:"id"`
	Line        uint32         `db:"line"`
	Name        string         `db:"name"`
	Description string         `db:"description"`
	Placeholder string         `db:"placeholder"`
	Required    bool           `db:"required"`
	FormID      uint32         `db:"form_id"`
	FieldTypeID uint32         `db:"field_type_id"`
	StatusID    uint8          `db:"status_id"`
	CreatedAt   mysql.NullTime `db:"created_at"`
	UpdatedAt   mysql.NullTime `db:"updated_at"`
	DeletedAt   mysql.NullTime `db:"deleted_at"`
}

// Connection is an interface for making queries.
type Connection interface {
	Exec(query string, args ...interface{}) (sql.Result, error)
	Get(dest interface{}, query string, args ...interface{}) error
	Select(dest interface{}, query string, args ...interface{}) error
}

// All gets field infieldation from description.
func All(db Connection) ([]Item, bool, error) {
	var result []Item
	err := db.Select(&result, fmt.Sprintf(`
		SELECT id, line, name, description, placeholder, required, form_id, field_type_id, status_id
		FROM %v
		WHERE deleted_at IS NULL order by form_id, line`, table))
	return result, err == sql.ErrNoRows, err
}

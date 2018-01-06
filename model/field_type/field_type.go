// Package field_type provides access to the field_type table in the MySQL database.
package field_type

import (
	"database/sql"
	"fmt"

	"github.com/go-sql-driver/mysql"
)

var (
	// table is the table name.
	table = "field_type"
)

// Item defines the model.
type Item struct {
	ID          uint32         `db:"id"`
	Name        string         `db:"name"`
	Description string         `db:"description"`
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

// All gets field_type infield_typeation from description.
func All(db Connection) ([]Item, bool, error) {
	var result []Item
	err := db.Select(&result, fmt.Sprintf(`
		SELECT id, name, description, status_id
		FROM %v
		WHERE deleted_at IS NULL order by id`, table))
	return result, err == sql.ErrNoRows, err
}

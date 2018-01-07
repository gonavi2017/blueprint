// Package form provides access to the form table in the MySQL database.
package form

import (
	"database/sql"
	"fmt"

	"github.com/go-sql-driver/mysql"
	"github.com/gonavi2017/blueprint/model/field"
	"github.com/gonavi2017/blueprint/model/field_type"
)

var (
	// table is the table name.
	table = "form"
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
	Fields      []field.Item
	FieldTypes  []field_type.Item
}

// Connection is an interface for making queries.
type Connection interface {
	Exec(query string, args ...interface{}) (sql.Result, error)
	Get(dest interface{}, query string, args ...interface{}) error
	Select(dest interface{}, query string, args ...interface{}) error
}

// ByDescription gets form information from description.
func ByDescription(db Connection, description string) ([]Item, bool, error) {
	var result []Item
	err := db.Select(&result, fmt.Sprintf(`
		SELECT id, name, description, status_id
		FROM %v
		WHERE description = ?
			AND deleted_at IS NULL
		`, table),
		description)
	return result, err == sql.ErrNoRows, err
}

// ByDescriptionPaginate gets items for a user based on page and max variables.
func ByDescriptionPaginate(db Connection, description string, max int, page int) ([]Item, bool, error) {
	var result []Item
	err := db.Select(&result, fmt.Sprintf(`
		SELECT id, name, description, status_id, updated_at, deleted_at
		FROM %v
		WHERE  description = ?
			AND deleted_at IS NULL
		LIMIT %v OFFSET %v
		`, table, max, page),
		description)
	return result, err == sql.ErrNoRows, err
}

// ByDescriptionCount counts the number of items for a user.
func ByDescriptionCount(db Connection, description string) (int, error) {
	var result int
	err := db.Get(&result, fmt.Sprintf(`
		SELECT count(*)
		FROM %v
		WHERE description = ?
			AND deleted_at IS NULL
		`, table),
		description)
	return result, err
}

// Create creates user.
func Create(db Connection, name, description string) (sql.Result, error) {
	result, err := db.Exec(fmt.Sprintf(`
		INSERT INTO %v
		(name, description)
		VALUES
		(?,?)
		`, table),
		name, description)
	return result, err
}

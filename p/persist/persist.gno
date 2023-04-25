package persist

import (
	"std"

	"github.com/google/uuid"
)

// Persist is a generic interface for storing any data type as bytes
type Persist interface {
	Set(key uuid.UUID, value interface{}) error
	Get(key uuid.UUID) (interface{}, error)
}

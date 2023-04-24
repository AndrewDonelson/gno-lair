// Package models provides functionality for managing base models.
package models

import (
	"github.com/gofrs/uuid"
)

// IModel is the base interface for all models, defining the id property.
type IModel interface {
	GetID() uuid.UUID
	SetID(uuid.UUID)
}

// Model is the base class for all models, implementing the IModel interface and defining the id property.
type Model struct {
	ID uuid.UUID
}

// GetID returns the unique identifier of a model.
func (m *Model) GetID() uuid.UUID {
	return m.ID
}

// SetID sets the unique identifier of a model.
func (m *Model) SetID(id uuid.UUID) {
	m.ID = id
}

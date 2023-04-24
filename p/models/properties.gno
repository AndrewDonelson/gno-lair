// Package properties provides functionality for managing custom object properties.
package models

import (
	"encoding/json"
	"errors"
	"sync"

	"workspace/p/persist"

	"github.com/google/uuid"
)

// IProperties defines the contract for the Properties object.
type IProperties interface {
	Set(key string, value interface{}) error
	Get(key string) (interface{}, error)
	Save() error
}

// Properties represents a custom object properties handler.
type Properties struct {
	data       map[string]interface{}
	changed    bool
	persist    persist.Persist
	mu         sync.RWMutex
	persistKey uuid.UUID
}

// NewProperties creates a new Properties object with a given persist object and key.
func NewProperties(persistObj persist.Persist, key uuid.UUID) (*Properties, error) {
	p := &Properties{
		data:       make(map[string]interface{}),
		changed:    false,
		persist:    persistObj,
		persistKey: key,
	}

	if err := p.load(); err != nil {
		return nil, err
	}

	return p, nil
}

// load retrieves the properties data from the persist object.
func (p *Properties) load() error {
	p.mu.Lock()
	defer p.mu.Unlock()

	value, err := p.persist.Get(p.persistKey)
	if err != nil {
		return err
	}

	if value != nil {
		return json.Unmarshal(value.([]byte), &p.data)
	}

	return nil
}

// Set sets the value of a property and marks it as changed.
func (p *Properties) Set(key string, value interface{}) error {
	p.mu.Lock()
	defer p.mu.Unlock()

	if p.data[key] != value {
		p.data[key] = value
		p.changed = true
	}

	return nil
}

// Get retrieves the value of a property.
func (p *Properties) Get(key string) (interface{}, error) {
	p.mu.RLock()
	defer p.mu.RUnlock()

	value, ok := p.data[key]
	if !ok {
		return nil, errors.New("property not found")
	}

	return value, nil
}

// Save saves the properties data to the persist object if there are any changes.
func (p *Properties) Save() error {
	p.mu.Lock()
	defer p.mu.Unlock()

	if !p.changed {
		return nil
	}

	data, err := json.Marshal(p.data)
	if err != nil {
		return err
	}

	if err := p.persist.Set(p.persistKey, data); err != nil {
		return err
	}

	p.changed = false
	return nil
}

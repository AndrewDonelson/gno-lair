package store

import (
	"testing"
)

// TestNewitem tests the NewItem function.
func TestNewitem(t *testing.T) {
	const (
		ID          = 123
		name        = "Item Name"
		price       = 456
		description = "Item Description"
	)

	item := NewItem(name, price, description)
	if item.GetName() != name {
		t.Errorf("item.Name = %v, want %v", item.Name, name)
	}
	if item.GetPrice() != price {
		t.Errorf("item.Price = %v, want %v", item.Price, price)
	}
	if item.GetDescription() != description {
		t.Errorf("item.Description = %v, want %v", item.Description, description)
	}
}

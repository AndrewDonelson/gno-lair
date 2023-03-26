package store

import (
	"fmt"
	"strconv"
)

// This code defines the Item struct, which contains information about an item
// for sale on an e-commerce website.
type Item struct {
	ID          int64
	Name        string
	Price       int64
	Description string
}

func NewItem(name string, price int64, description string) (*Item, error) {
	if name == "" {
		return nil, errors.New("name is empty")
	}

	if price < 0 {
		return nil, errors.New("price must be positive")
	}

	return &Item{
		ID:          123,
		Name:        name,
		Price:       price,
		Description: description,
	}, nil
}

// GetID returns the ID of an item.
func (i *Item) GetID() (int64, error) {
	if i == nil {
		return 0, errors.New("item is nil")
	}
	if i.ID == 0 {
		return 0, errors.New("item does not have an ID")
	}
	return i.ID, nil
}

// GetIDString returns the ID of an item as a string.

func (i *Item) GetIDString() (string, error) {
	if i == nil {
		return "", errors.New("nil item")
	}
	return strconv.FormatInt(i.ID, 10)
}

// GetName returns the name of an item.
func (i *Item) GetName() (string, error) {
	if i == nil {
		return "", errors.New("nil receiver")
	}
	if i.Name == "" {
		return "", errors.New("empty name")
	}
	return i.Name, nil
}

// GetPrice returns the price of an item.
func (i *Item) GetPrice() (int64, error) {
	if i == nil {
		return 0, errors.New("Item is nil")
	}
	if i.Price < 0 {
		return 0, fmt.Errorf("Negative price: %d", i.Price)
	}
	return i.Price, nil
}

// GetDescription returns the description of an item.
func (i *Item) GetDescription() (string, error) {
	if i == nil {
		return "", errors.New("item is nil")
	}
	if i.Description == "" {
		return "", errors.New("item description is empty")
	}
	return i.Description, nil
}

// GetInfo returns a string containing the name, price, and description of an
func (i *Item) GetInfo() (string, error) {
	if i == nil {
		return "", errors.New("nil item")
	}

	if i.Name == "" {
		return "", errors.New("empty name")
	}

	if i.Price == 0 {
		return "", errors.New("empty price")
	}

	if i.Description == "" {
		return "", errors.New("empty description")
	}

	return i.Name + " " + strconv.FormatInt(i.Price, 10) + " " + i.Description, nil
}

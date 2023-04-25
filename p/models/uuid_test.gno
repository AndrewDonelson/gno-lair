package models

import (
	"testing"
)

func TestUUID(t *testing.T) {
	uuid, err := NewV4()
	if err != nil {
		fmt.Println("Error generating UUID:", err)
		t.Errorf("Error generating UUID:", err)
		return
	}

	fmt.Println("Generated UUID:", uuid)
}

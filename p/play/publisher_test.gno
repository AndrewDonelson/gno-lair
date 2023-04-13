package play

import (
	"testing"
	"workspace/p/models"
)

func TestPublisher(t *testing.T) {
	p := NewPublisher("ACME Games", "http://acmegames.com")
	if p.Name != "ACME Games" {
		t.Errorf("Publisher name is %s, want ACME Games", p.Name)
	}

	if p.Website != "http://acmegames.com" {
		t.Errorf("Publisher URL is %s, want http://acmegames.com", p.Website)
	}
}

package persist

import (
	"testing"

	"github.com/google/uuid"
)

// TestNewBucket tests the NewBucket function.
func TestNewBucket(t *testing.T) {
	const (
		name    = "Bucket Name"
		maxSize = 123
	)

	bucket := NewBucket(name, maxSize)
	if bucket.Name() != name {
		t.Errorf("bucket.Name = %v, want %v", bucket.Name(), name)
	}
	if bucket.MaxSize() != maxSize {
		t.Errorf("bucket.MaxSize = %v, want %v", bucket.MaxSize(), maxSize)
	}
}

// TestBucketSize tests the Size function.
func TestBucketSize(t *testing.T) {
	const (
		name    = "Bucket Name"
		maxSize = 123
	)

	bucket := NewBucket(name, maxSize)
	if bucket.Size() != 0 {
		t.Errorf("bucket.Size = %v, want %v", bucket.Size(), 0)
	}
}

// TestBucketMaxSize tests the MaxSize function.
func TestBucketMaxSize(t *testing.T) {
	const (
		name    = "Bucket Name"
		maxSize = 123
	)

	bucket := NewBucket(name, maxSize)
	if bucket.MaxSize() != maxSize {
		t.Errorf("bucket.MaxSize = %v, want %v", bucket.MaxSize(), maxSize)
	}
}

// TestBucketName tests the Name function.
func TestBucketName(t *testing.T) {
	const (
		name    = "Bucket Name"
		maxSize = 123
	)

	bucket := NewBucket(name, maxSize)
	if bucket.Name() != name {
		t.Errorf("bucket.Name = %v, want %v", bucket.Name(), name)
	}
}

// TestBucketSetMaxSize tests the SetMaxSize function.
func TestBucketSetMaxSize(t *testing.T) {
	const (
		name    = "Bucket Name"
		maxSize = 123
	)

	bucket := NewBucket(name, maxSize)
	bucket.SetMaxSize(456)
	if bucket.MaxSize() != 456 {
		t.Errorf("bucket.MaxSize = %v, want %v", bucket.MaxSize(), 456)
	}
}

// TestBucketSetName tests the SetName function.
func TestBucketSetName(t *testing.T) {
	const (
		name    = "Bucket Name"
		maxSize = 123
	)

	bucket := NewBucket(name, maxSize)
	bucket.SetName("New Bucket Name")
	if bucket.Name() != "New Bucket Name" {
		t.Errorf("bucket.Name = %v, want %v", bucket.Name(), "New Bucket Name")
	}
}

// TestBucketSet tests the Set function.
func TestBucketSet(t *testing.T) {
	const (
		name    = "Bucket Name"
		maxSize = 123
	)

	id, err := uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	bucket := NewBucket(name, maxSize)
	bucket.Set(id, "value")
	if bucket.Size() != 1 {
		t.Errorf("bucket.Size = %v, want %v", bucket.Size(), 1)
	}
}

// TestBucketGet tests the Get function.
func TestBucketGet(t *testing.T) {
	const (
		name    = "Bucket Name"
		maxSize = 123
	)

	id, err := uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	bucket := NewBucket(name, maxSize)
	bucket.Set(id, "value")
	value, err := bucket.Get(id)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if value != "value" {
		t.Errorf("bucket.Get = %v, want %v", value, "value")
	}
}

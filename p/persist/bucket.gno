package persist

import (
	"bytes"
	"encoding/gob"
	"fmt"
	"math/rand"

	"github.com/google/uuid"
)

// Bucket implements the Persist interface using a map
type Bucket struct {
	name    string
	maxSize int64
	data    map[uuid.UUID][]byte
}

// NewBucket creates a new Bucket instance
func NewBucket(name string, maxSize int64) *Bucket {
	// if name is empty then set it to a random name by appending a random number to "bucket"
	if name == "" {
		name = fmt.Sprintf("bucket-%d", rand.Int63())
	}

	// if maxSize <= 0  then set the it to the maximum value
	if maxSize <= 0 {
		maxSize = 9223372036854775807
	}

	return &Bucket{
		name:    name,
		maxSize: maxSize,
		data:    make(map[uuid.UUID][]byte),
	}
}

// Size returns the number of items in the Bucket
func (b *Bucket) Size() int64 {
	return int64(len(b.data))
}

// MaxSize returns the maximum number of items the Bucket can hold
func (b *Bucket) MaxSize() int64 {
	return b.maxSize
}

// Name returns the name of the Bucket
func (b *Bucket) Name() string {
	return b.name
}

// SetMaxSize sets the maximum number of items the Bucket can hold
func (b *Bucket) SetMaxSize(maxSize int64) {
	b.maxSize = maxSize
}

// SetName sets the name of the Bucket
func (b *Bucket) SetName(name string) {
	b.name = name
}

// Set stores the value as bytes in the Bucket
func (b *Bucket) Set(key uuid.UUID, value interface{}) error {
	var buf bytes.Buffer
	enc := gob.NewEncoder(&buf)

	if err := enc.Encode(value); err != nil {
		return fmt.Errorf("failed to encode value: %v", err)
	}

	b.data[key] = buf.Bytes()
	return nil
}

// Get retrieves the value as bytes from the Bucket and decodes it
func (b *Bucket) Get(key uuid.UUID) (interface{}, error) {
	data, ok := b.data[key]
	if !ok {
		return nil, fmt.Errorf("key not found: %s", key)
	}

	buf := bytes.NewBuffer(data)
	dec := gob.NewDecoder(buf)

	var value interface{}
	if err := dec.Decode(&value); err != nil {
		return nil, fmt.Errorf("failed to decode value: %v", err)
	}

	return value, nil
}

package persist

import (
	"bytes"
	"encoding/gob"
	"fmt"
	"math/rand"
	"sync"

	"github.com/google/uuid"
)

// Bucket implements the Persist interface using a map
type Bucket struct {
	name    string
	maxSize int64
	data    map[uuid.UUID][]byte
	mu      sync.RWMutex
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

func (b *Bucket) Set(key uuid.UUID, value interface{}) error {
	b.mu.Lock()
	defer b.mu.Unlock()

	var buf bytes.Buffer
	enc := gob.NewEncoder(&buf)

	err := enc.Encode(value)
	if err != nil {
		return fmt.Errorf("failed to encode value: %w", err)
	}

	b.data[key] = buf.Bytes()
	return nil
}

func (b *Bucket) Get(key uuid.UUID, target interface{}) error {
	b.mu.RLock()
	defer b.mu.RUnlock()

	value, ok := b.data[key]
	if !ok {
		return fmt.Errorf("key not found: %s", key)
	}

	buf := bytes.NewBuffer(value)
	dec := gob.NewDecoder(buf)

	err := dec.Decode(target)
	if err != nil {
		return fmt.Errorf("failed to decode value: %w", err)
	}

	return nil
}

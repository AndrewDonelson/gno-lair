package persist

import (
	"testing"

	"github.com/google/uuid"
)

type TestStruct struct {
	String  string
	Int     int
	Int64   int64
	Float64 float64
	Bool    bool
}

const (
	name        = "Bucket Name"
	maxSize     = 123
	testString  = "Hello World!"
	testInt     = 987
	testInt64   = 9876543210
	testFloat64 = 3.14159265359
	testBool    = true
)

func NewTestStruct() *TestStruct {
	return &TestStruct{
		String:  testString,
		Int:     testInt,
		Int64:   testInt64,
		Float64: testFloat64,
		Bool:    testBool,
	}
}

// TestNewBucket tests the NewBucket function.
func TestNewBucket(t *testing.T) {
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
	bucket := NewBucket(name, maxSize)
	if bucket.Size() != 0 {
		t.Errorf("bucket.Size = %v, want %v", bucket.Size(), 0)
	}
}

// TestBucketMaxSize tests the MaxSize function.
func TestBucketMaxSize(t *testing.T) {
	bucket := NewBucket(name, maxSize)
	if bucket.MaxSize() != maxSize {
		t.Errorf("bucket.MaxSize = %v, want %v", bucket.MaxSize(), maxSize)
	}
}

// TestBucketName tests the Name function.
func TestBucketName(t *testing.T) {
	bucket := NewBucket(name, maxSize)
	if bucket.Name() != name {
		t.Errorf("bucket.Name = %v, want %v", bucket.Name(), name)
	}
}

// TestBucketSetMaxSize tests the SetMaxSize function.
func TestBucketSetMaxSize(t *testing.T) {
	bucket := NewBucket(name, maxSize)
	bucket.SetMaxSize(456)
	if bucket.MaxSize() != 456 {
		t.Errorf("bucket.MaxSize = %v, want %v", bucket.MaxSize(), 456)
	}
}

// TestBucketSetName tests the SetName function.
func TestBucketSetName(t *testing.T) {
	bucket := NewBucket(name, maxSize)
	bucket.SetName("New Bucket Name")
	if bucket.Name() != "New Bucket Name" {
		t.Errorf("bucket.Name = %v, want %v", bucket.Name(), "New Bucket Name")
	}
}

func TestBucketString(t *testing.T) {
	id, err := uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	bucket := NewBucket(name, maxSize)
	err = bucket.Set(id, testString)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}

	var testStringValue string
	err = bucket.Get(id, &testStringValue)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testStringValue != testString {
		t.Errorf("bucket.Get = %v, want %v", testStringValue, "value")
	}
}

func TestBucketInt(t *testing.T) {
	id, err := uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	bucket := NewBucket(name, maxSize)
	err = bucket.Set(id, testInt)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}

	var testValue int
	err = bucket.Get(id, &testValue)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testValue != testInt {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}
}

func TestBucketInt64(t *testing.T) {
	id, err := uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	bucket := NewBucket(name, maxSize)
	err = bucket.Set(id, testInt64)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}

	var testValue int
	err = bucket.Get(id, &testValue)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testValue != testInt64 {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}
}

func TestBucketFloatInt(t *testing.T) {
	id, err := uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	bucket := NewBucket(name, maxSize)
	err = bucket.Set(id, testFloat64)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}

	var testValue float64
	err = bucket.Get(id, &testValue)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testValue != testFloat64 {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}
}

func TestBucketStruct(t *testing.T) {
	testStruct := NewTestStruct()

	id, err := uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	bucket := NewBucket(name, maxSize)
	err = bucket.Set(id, testStruct)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}

	var testValue *TestStruct
	err = bucket.Get(id, &testValue)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testValue == nil {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	if testValue.String != testStruct.String {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	if testValue.Int != testStruct.Int {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	if testValue.Int64 != testStruct.Int64 {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	if testValue.Float64 != testStruct.Float64 {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	if testValue.Bool != testStruct.Bool {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}
}

// This function is used to test the bucket's ability to store and retrieve all types of data.
// Each Value tested will  have its own id (uuid) and will be stored in the same bucket.
// It will create a single bucket and store all types of data in it.
// It will then retrieve all of the data and verify that it is correct.
func TestBucketAll(t *testing.T) {
	bucketCount := int64(0)
	bucket := NewBucket(name, maxSize)

	// Test String
	id, err := uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	err = bucket.Set(id, testString)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}
	bucketCount++

	var testStringValue string
	err = bucket.Get(id, &testStringValue)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testStringValue != testString {
		t.Errorf("bucket.Get = %v, want %v", testStringValue, "value")
	}

	// Test Int
	id, err = uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	err = bucket.Set(id, testInt)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}
	bucketCount++

	var testIntValue int
	err = bucket.Get(id, &testIntValue)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testIntValue != testInt {
		t.Errorf("bucket.Get = %v, want %v", testIntValue, "value")
	}

	// Test Int64
	id, err = uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	err = bucket.Set(id, testInt64)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}
	bucketCount++

	var testInt64Value int64
	err = bucket.Get(id, &testInt64Value)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testInt64Value != testInt64 {
		t.Errorf("bucket.Get = %v, want %v", testInt64Value, "value")
	}

	// Test Float64
	id, err = uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	err = bucket.Set(id, testFloat64)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}
	bucketCount++

	var testFloat64Value float64
	err = bucket.Get(id, &testFloat64Value)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testFloat64Value != testFloat64 {
		t.Errorf("bucket.Get = %v, want %v", testFloat64Value, "value")
	}

	// Test Bool
	id, err = uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	err = bucket.Set(id, testBool)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}
	bucketCount++

	var testBoolValue bool
	err = bucket.Get(id, &testBoolValue)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testBoolValue != testBool {
		t.Errorf("bucket.Get = %v, want %v", testBoolValue, "value")
	}

	// Test Struct
	id, err = uuid.NewRandom()
	if err != nil {
		t.Errorf("uuid.NewRandom() = %v, want %v", err, nil)
	}

	testStruct := NewTestStruct()
	err = bucket.Set(id, testStruct)
	if err != nil {
		t.Errorf("bucket.Set = %v, want %v", err, nil)
	}
	bucketCount++

	var testValue *TestStruct
	err = bucket.Get(id, &testValue)
	if err != nil {
		t.Errorf("bucket.Get = %v, want %v", err, nil)
	}

	if testValue == nil {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	if testValue.String != testStruct.String {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	if testValue.Int != testStruct.Int {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	if testValue.Int64 != testStruct.Int64 {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	if testValue.Float64 != testStruct.Float64 {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	if testValue.Bool != testStruct.Bool {
		t.Errorf("bucket.Get = %v, want %v", testValue, "value")
	}

	// test and make sure the number of Bucket Items matches the number of items we added
	if bucket.Size() != bucketCount {
		t.Errorf("bucket.Count() = %v, want %v", bucket.Size(), bucketCount)
	}
}

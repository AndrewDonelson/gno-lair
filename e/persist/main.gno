package persist

// Example data
type Person struct {
	Name string
	Age  int
	Male bool
}

func main() {
	persons := NewBucket()

	person := Person{Name: "Alice", Age: 30, false}
	key, _ := uuid.NewRandom()

	// Set the data
	err := persons.Set(key, person)
	if err != nil {
		fmt.Printf("Error setting data: %v\n", err)
		return
	}

	// Get the data
	retrievedValue, err := persons.Get(key)
	if err != nil {
		fmt.Printf("Error getting data: %v\n", err)
		return
	}

	retrievedPerson, ok := retrievedValue.(Person)
	if !ok {
		fmt.Println("Failed to type assert retrieved value to Person")
		return
	}

	fmt.Printf("Retrieved data: %v\n", retrievedPerson)
}
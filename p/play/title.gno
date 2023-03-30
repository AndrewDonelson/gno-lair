package play

import (
	"bytes"
	"encoding/gob"
	"encoding/json"
	"fmt"

	"github.com/google/uuid"
)

type Title struct {
	Id      uuid.UUID // Universally Unique Identifier v4 
	Name    string // Name of the Software Title
	Website string // url
	Logo    []byte // 256x256 WxH image data
}

// Getters
func (t *Title) GetId() uuid.UUID {
	return t.Id
}

func (t *Title) GetName() string {
	return t.Name
}

func (t *Title) GetWebsite() string {
	return t.Website
}

func (t *Title) GetLogo() []byte {
	return t.Logo
}

// Setters
func (t *Title) SetId(id uuid.UUID) {
	t.Id = id
}

func (t *Title) SetName(name string) {
	t.Name = name
}

func (t *Title) SetWebsite(website string) {
	t.Website = website
}

func (t *Title) SetLogo(logo []byte) {
	t.Logo = logo
}

// ToJSON converts the Title object to a JSON string
func (t *Title) ToJSON() (string, error) {
	jsonBytes, err := json.Marshal(t)
	if err != nil {
		return "", fmt.Errorf("failed to marshal Title to JSON: %v", err)
	}
	return string(jsonBytes), nil
}

// FromJSON initializes the Title object from a JSON string
func (t *Title) FromJSON(jsonStr string) error {
	return json.Unmarshal([]byte(jsonStr), t)
}

// ToBytes converts the Title object to bytes using gob
func (t *Title) ToBytes() ([]byte, error) {
	var buf bytes.Buffer
	enc := gob.NewEncoder(&buf)

	if err := enc.Encode(t); err != nil {
		return nil, fmt.Errorf("failed to encode Title to bytes: %v", err)
	}

	return buf.Bytes(), nil
}

// FromBytes initializes the Title object from bytes using gob
func (t *Title) FromBytes(data []byte) error {
	buf := bytes.NewBuffer(data)
	dec := gob.NewDecoder(buf)

	return dec.Decode(t)
}

// ToString returns the Title object as a string
func (t *Title) ToString() string {
	return fmt.Sprintf("Id: %s, Name: %s, Website: %s, Logo size: %d bytes", t.Id, t.Name, t.Website, len(t.Logo))
}

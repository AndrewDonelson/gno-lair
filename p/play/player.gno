package play

import (
	"bytes"
	"encoding/gob"
	"encoding/json"
	"fmt"
	"time"

	"github.com/google/uuid"
)

// Player represents a player in the game for a given publishers game title
type Player struct {
	Id          uuid.UUID
	WalletAddress string
	DisplayName  string
	RealName     string
	Email        string
	AvatarURL    string
	Language     string
	Created      time.Time
	FirstLogin   time.Time
	LastLogin    time.Time
	City         string
	Country      string
}

// Getters

// GetId returns the player's id
func (p *Player) GetId() uuid.UUID {
	return p.Id
}

// GetWalletAddress returns the player's wallet address
func (p *Player) GetWalletAddress() string {
	return p.WalletAddress
}

// GetDisplayName returns the player's display name
func (p *Player) GetDisplayName() string {
	return p.DisplayName
}

// GetRealName returns the player's real name
func (p *Player) GetRealName() string {
	return p.RealName
}

// GetEmail returns the player's email address
func (p *Player) GetEmail() string {
	return p.Email
}

// GetAvatarURL returns the player's avatar URL
func (p *Player) GetAvatarURL() string {
	return p.AvatarURL
}

// GetLanguage returns the player's language
func (p *Player) GetLanguage() string {
	return p.Language
}

// GetCreated returns the player's creation date
func (p *Player) GetCreated() time.Time {
	return p.Created
}

// GetFirstLogin returns the player's first login date
func (p *Player) GetFirstLogin() time.Time {
	return p.FirstLogin
}

// GetLastLogin returns the player's last login date
func (p *Player) GetLastLogin() time.Time {
	return p.LastLogin
}

// GetCity returns the player's city
func (p *Player) GetCity() string {
	return p.City
}

// GetCountry returns the player's country
func (p *Player) GetCountry() string {
	return p.Country
}

// Setters

// SetId sets the player's id
func (p *Player) SetId(id uuid.UUID) {
	p.Id = id
}

// SetWalletAddress sets the player's wallet address
func (p *Player) SetWalletAddress(walletAddress string) {
	p.WalletAddress = walletAddress
}

// SetDisplayName sets the player's display name
func (p *Player) SetDisplayName(displayName string) {
	p.DisplayName = displayName
}

// SetRealName sets the player's real name
func (p *Player) SetRealName(realName string) {
	p.RealName = realName
}

// SetEmail sets the player's email address
func (p *Player) SetEmail(email string) {
	p.Email = email
}

// SetAvatarURL sets the player's avatar URL
func (p *Player) SetAvatarURL(avatarURL string) {
	p.AvatarURL = avatarURL
}

// SetLanguage sets the player's language
func (p *Player) SetLanguage(language string) {
	p.Language = language
}

// SetCreated sets the player's creation date
func (p *Player) SetCreated(created time.Time) {
	p.Created = created
}

// SetFirstLogin sets the player's first login date
func (p *Player) SetFirstLogin(firstLogin time.Time) {
	p.FirstLogin = firstLogin
}

// SetLastLogin sets the player's last login date
func (p *Player) SetLastLogin(lastLogin time.Time) {
	p.LastLogin = lastLogin
}

// SetCity sets the player's city
func (p *Player) SetCity(city string) {
	p.City = city
}

// SetCountry sets the player's country
func (p *Player) SetCountry(country string) {
	p.Country = country
}

// ToJSON converts the Player object to a JSON string
func (p *Player) ToJSON() (string, error) {
	jsonBytes, err := json.Marshal(p)
	if err != nil {
		return "", fmt.Errorf("failed to marshal Player to JSON: %v", err)
	}
	return string(jsonBytes), nil
}

// FromJSON initializes the Player object from a JSON string
func (p *Player) FromJSON(jsonStr string) error {
	return json.Unmarshal([]byte(jsonStr), p)
}

// ToBytes converts the Player object to bytes using gob
func (p *Player) ToBytes() ([]byte, error) {
	var buf bytes.Buffer
	enc := gob.NewEncoder(&buf)

	if err := enc.Encode(p);
	if err != nil {
		return nil, fmt.Errorf("failed to encode Player to bytes: %v", err)
	}

	return buf.Bytes(), nil
}

// FromBytes initializes the Player object from bytes using gob
func (p *Player) FromBytes(data []byte) error {
	buf := bytes.NewBuffer(data)
	dec := gob.NewDecoder(buf)

	return dec.Decode(p)
}

// ToString returns the Player object as a string
func (p *Player) ToString() string {
	return fmt.Sprintf("Id: %s, WalletAddress: %s, DisplayName: %s, LastLogin: %v, City: %s, Country: %s",
		p.Id, p.WalletAddress, p.DisplayName, p.LastLogin, p.City, p.Country)
}	
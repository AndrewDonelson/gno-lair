// Package models provides functionality for generic models. This file is for managing ratings
package models

import (
	"fmt"

	"github.com/gofrs/uuid"
)

// RatingInterface defines the contract for the Rating class.
type RatingInterface interface {
	GetID() uuid.UUID
	SetID(uuid.UUID)
	GetUserID() uuid.UUID
	SetUserID(uuid.UUID)
	GetPostID() uuid.UUID
	SetPostID(uuid.UUID)
	GetScore() int
	SetScore(int)
	Display() string
}

// Rating represents a rating of a post with basic properties and methods.
type Rating struct {
	ID     uuid.UUID
	UserID uuid.UUID
	PostID uuid.UUID
	Score  int
}

// GetID returns the ID of a rating.
func (r *Rating) GetID() uuid.UUID {
	return r.ID
}

// SetID sets the ID of a rating.
func (r *Rating) SetID(id uuid.UUID) {
	r.ID = id
}

// GetUserID returns the user ID associated with a rating.
func (r *Rating) GetUserID() uuid.UUID {
	return r.UserID
}

// SetUserID sets the user ID associated with a rating.
func (r *Rating) SetUserID(userID uuid.UUID) {
	r.UserID = userID
}

// GetPostID returns the post ID associated with a rating.
func (r *Rating) GetPostID() uuid.UUID {
	return r.PostID
}

// SetPostID sets the post ID associated with a rating.
func (r *Rating) SetPostID(postID uuid.UUID) {
	r.PostID = postID
}

// GetScore returns the score of a rating.
func (r *Rating) GetScore() int {
	return r.Score
}

// SetScore sets the score of a rating.
func (r *Rating) SetScore(score int) {
	r.Score = score
}

// Display returns a formatted string containing the rating's details.
func (r *Rating) Display() string {
	return fmt.Sprintf("ID: %d, UserID: %d, PostID: %d, Score: %d", r.GetID(), r.GetUserID(), r.GetPostID(), r.GetScore())
}

// Package models provides functionality for generic models. This file is for managing ratings
package models

import "fmt"

// RatingInterface defines the contract for the Rating class.
type RatingInterface interface {
	GetID() int
	SetID(int)
	GetUserID() int
	SetUserID(int)
	GetPostID() int
	SetPostID(int)
	GetScore() int
	SetScore(int)
	Display() string
}

// Rating represents a rating of a post with basic properties and methods.
type Rating struct {
	ID     int
	UserID int
	PostID int
	Score  int
}

// GetID returns the ID of a rating.
func (r *Rating) GetID() int {
	return r.ID
}

// SetID sets the ID of a rating.
func (r *Rating) SetID(id int) {
	r.ID = id
}

// GetUserID returns the user ID associated with a rating.
func (r *Rating) GetUserID() int {
	return r.UserID
}

// SetUserID sets the user ID associated with a rating.
func (r *Rating) SetUserID(userID int) {
	r.UserID = userID
}

// GetPostID returns the post ID associated with a rating.
func (r *Rating) GetPostID() int {
	return r.PostID
}

// SetPostID sets the post ID associated with a rating.
func (r *Rating) SetPostID(postID int) {
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

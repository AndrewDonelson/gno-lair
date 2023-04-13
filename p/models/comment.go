// Package models provides functionality for generic models. This file is for managing comments
package models

import "fmt"

// CommentInterface defines the contract for the Comment class.
type CommentInterface interface {
	GetID() int
	SetID(int)
	GetPostID() int
	SetPostID(int)
	GetUserID() int
	SetUserID(int)
	GetContent() string
	SetContent(string)
	Display() string
}

// Comment represents a comment on a post with basic properties and methods.
type Comment struct {
	ID      int
	PostID  int
	UserID  int
	Content string
}

// GetID returns the ID of a comment.
func (c *Comment) GetID() int {
	return c.ID
}

// SetID sets the ID of a comment.
func (c *Comment) SetID(id int) {
	c.ID = id
}

// GetID returns the ID of a comment.
func (c *Comment) GetPostID() int {
	return c.PostID
}

// SetID sets the ID of a comment.
func (c *Comment) SetPostID(id int) {
	c.PostID = id
}

// GetUserID returns the user ID associated with a comment.
func (c *Comment) GetUserID() int {
	return c.UserID
}

// SetUserID sets the user ID associated with a comment.
func (c *Comment) SetUserID(userID int) {
	c.UserID = userID
}

// GetContent returns the content of a comment.
func (c *Comment) GetContent() string {
	return c.Content
}

// SetContent sets the content of a comment.
func (c *Comment) SetContent(content string) {
	c.Content = content
}

// Display returns a formatted string containing the comment's details.
func (c *Comment) Display() string {
	return fmt.Sprintf("ID: %d, UserID: %d, Content: %s", c.GetID(), c.GetUserID(), c.GetContent())
}

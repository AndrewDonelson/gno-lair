// Package models provides functionality for generic models. This file is for managing posts.
package models

import "fmt"

// PostInterface defines the contract for the Post class.
type PostInterface interface {
	GetID() int
	SetID(int)
	GetTitle() string
	SetTitle(string)
	GetContent() string
	SetContent(string)
	Display() string
}

// Post represents a post with basic properties and methods.
type Post struct {
	ID      int
	Title   string
	Content string
}

// GetID returns the ID of a post.
func (p *Post) GetID() int {
	return p.ID
}

// SetID sets the ID of a post.
func (p *Post) SetID(id int) {
	p.ID = id
}

// GetTitle returns the title of a post.
func (p *Post) GetTitle() string {
	return p.Title
}

// SetTitle sets the title of a post.
func (p *Post) SetTitle(title string) {
	p.Title = title
}

// GetContent returns the content of a post.
func (p *Post) GetContent() string {
	return p.Content
}

// SetContent sets the content of a post.
func (p *Post) SetContent(content string) {
	p.Content = content
}

// Display returns a formatted string containing the post's details.
func (p *Post) Display() string {
	return fmt.Sprintf("ID: %d, Title: %s, Content: %s", p.GetID(), p.GetTitle(), p.GetContent())
}

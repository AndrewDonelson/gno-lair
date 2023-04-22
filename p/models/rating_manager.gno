package models

import "github.com/gofrs/uuid"

func Init() {
	// Init the rating manager
	MgrRating = &RatingManager{
		ratings: make(map[uuid.UUID]*Rating),
	}
}

// RatingManager manages the ratings of posts (any content).
type RatingManager struct {
	ratings map[string]*Rating
}

var MgrRating *RatingManager

// GetRating returns the rating with the given ID.
func (rm *RatingManager) GetRating(id string) *Rating {
	return rm.ratings[id]
}

// AddRating adds a rating to the manager.
func (rm *RatingManager) AddRating(contentID, userID uuid.UUID, thumbsUp bool) {
	newRating := NewRating(userID, contentID, thumbsUp)
	rm.ratings[newRating.GetID()] = newRating
}

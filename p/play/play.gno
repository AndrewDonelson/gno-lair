package play

import (
	"workspace/p/models"
	"workspace/p/persist"
)

type Play struct {
	publishers *persist.Bucket
	titles     *persist.Bucket
	players    *persist.Bucket
}

func NewPlay() *Play {
	return &Play{
		publishers: persist.NewBucket("publishers", 0),
		titles:     persist.NewBucket("titles", 0),
		players:    persist.NewBucket("players", 0),
	}
}

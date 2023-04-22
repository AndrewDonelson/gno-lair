package events

import (
	"time"
)

func init() {
	changedNotifier := onChangedNotifier{}

	events.OnChanged.Register(changedNotifier)
}

var OnChanged onChanged

// OnChangedPayload is the data for when a user is created
type OnChangedPayload struct {
	Time time.Time
}

type onChanged struct {
	handlers []interface{ Handle(OnChangedPayload) }
}

// Register adds an event handler for this event
func (u *onChanged) Register(handler interface{ Handle(OnChangedPayload) }) {
	u.handlers = append(u.handlers, handler)
}

func (u onChanged) OnCh

// Emit sends out an event with the payload
func (u onChanged) Emit(payload OnChangedPayload) {
	for _, handler := range u.handlers {
		go handler.Handle(payload)
	}
}

package brainfuck

import (
	"testing"
)

func TestBrainFuck(t *testing.T) {
	bfvm := NewBrainFuckVM()
	bfvm.source = []byte("++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.")
	err := bfvm.compile()
	if err != nil {
		t.Error(err)
	}
	bfvm.execute()
}

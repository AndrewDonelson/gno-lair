package brainfuck

import (
	"errors"
	"fmt"
	"os"
)

// VM is the main Virtual machine for the BrainFuck language
type VM struct {
	source  []byte
	program []Instruction
}

type Instruction struct {
	operator uint16
	operand  int16
}

const (
	ERR_CMP   = "compilation error"
	ERR_UOP   = "Unknown operator."
	ERR_READ  = "error reading [%s]"
	ERR_WRITE = "error writing [%s]"
	ERR_PANIC = ""

	data_size int = 65535

	op_move_dp = iota
	op_add_val
	op_out
	op_in
	op_jmp_fwd
	op_jmp_bck
)

// compile the source
func (vm *VM) compile() (err error) {
	var pc uint16
	jmp_stack := make([]uint16, 0)

	for _, c := range vm.source {
		switch c {
		case '>':
			vm.program = append(vm.program, Instruction{op_move_dp, 1})
		case '<':
			vm.program = append(vm.program, Instruction{op_move_dp, -1})
		case '+':
			vm.program = append(vm.program, Instruction{op_add_val, 1})
		case '-':
			vm.program = append(vm.program, Instruction{op_add_val, -1})
		case '.':
			vm.program = append(vm.program, Instruction{op_out, 0})
		case ',':
			vm.program = append(vm.program, Instruction{op_in, 0})
		case '[':
			vm.program = append(vm.program, Instruction{op_jmp_fwd, 0})
			jmp_stack = append(jmp_stack, pc)
		case ']':
			if len(jmp_stack) == 0 {
				return errors.New(ERR_CMP)
			}
			jmp_pc := jmp_stack[len(jmp_stack)-1]
			jmp_stack = jmp_stack[:len(jmp_stack)-1]
			vm.program = append(vm.program, Instruction{op_jmp_bck, int16(jmp_pc)})
			vm.program[jmp_pc].operand = int16(pc)
		default:
			pc--
		}
		pc++
	}
	if len(jmp_stack) != 0 {
		return errors.New(ERR_CMP)
	}
	return
}

// execute the instructions
func (vm *VM) execute() {
	data := make([]byte, data_size)
	var data_ptr int16

	for pc := 0; pc < len(vm.program); pc++ {
		switch vm.program[pc].operator {
		case op_move_dp:
			data_ptr += vm.program[pc].operand
		case op_add_val:
			data[data_ptr] += byte(vm.program[pc].operand)
		case op_out:
			fmt.Printf("%c", data[data_ptr])
		case op_in:
			read_val := make([]byte, 1)
			os.Stdin.Read(read_val)
			data[data_ptr] = read_val[0]
		case op_jmp_fwd:
			if data[data_ptr] == 0 {
				pc = int(vm.program[pc].operand)
			}
		case op_jmp_bck:
			if data[data_ptr] > 0 {
				pc = int(vm.program[pc].operand)
			}
		default:
			panic(ERR_UOP)
		}
	}
}

// load from a file
func (vm *VM) Read(s string) (err error) {
	vm.source, err = os.ReadFile(s)
	if err != nil {
		err = fmt.Errorf(ERR_READ, s)
		return
	}
	return nil
}

// create a new VM
func NewBrainFuckVM() *VM {
	return &VM{}
}

// Example
// func main() {
// 	args := os.Args
// 	if len(args) != 2 {
// 		fmt.Printf("Usage: %s filename\n", args[0])
// 		return
// 	}
// 	filename := args[1]

// 	vm := NewBrainFuckVM()

// 	// Read BF source from file
// 	err := vm.Read(filename)
// 	if err != nil {
// 		panic(err)
// 	}

// 	// compile BF Code
// 	err = vm.compile()
// 	if err != nil {
// 		panic(err)
// 	}

// 	// Execute the BF instructions
// 	vm.execute()
// }

// file: program.go
package lib

// Program is the root node of the AST representing a complete Solidity source file.
type Program struct {
	Statements []Statement
}

// NewProgram creates a new Program instance.
func NewProgram() *Program {
	return &Program{
		Statements: []Statement{},
	}
}

// AddStatement appends a statement to the program's Statements slice.
func (p *Program) AddStatement(s Statement) {
	p.Statements = append(p.Statements, s)
}

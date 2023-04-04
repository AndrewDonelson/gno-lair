// file: statement.go
package lib

type Statement interface {
	statementNode()
}

// FunctionDeclaration represents a function declaration in the Solidity language.
type FunctionDeclaration struct {
	Token      Token // The 'function' token
	Name       *IdentifierExpression
	Parameters []*Parameter
	Body       *BlockStatement
}

func (fd *FunctionDeclaration) statementNode() {}

// Parameter represents a function parameter in a function declaration.
type Parameter struct {
	Token Token // The type token
	Type  string
	Name  *IdentifierExpression
}

// VariableDeclaration represents a variable declaration in the Solidity language.
type VariableDeclaration struct {
	Token Token // The 'var' token
	Name  *IdentifierExpression
	Type  string
	Value Expression
}

func (vd *VariableDeclaration) statementNode() {}

// ReturnStatement represents a return statement in the Solidity language.
type ReturnStatement struct {
	Token       Token // The 'return' token
	ReturnValue Expression
}

func (rs *ReturnStatement) statementNode() {}

// BlockStatement represents a block of code surrounded by curly braces.
type BlockStatement struct {
	Token      Token // The '{' token
	Statements []Statement
}

func (bs *BlockStatement) statementNode() {}

// file: expression.go
package lib

// Expression is an interface that all expressions implement.
type Expression interface {
	expressionNode()
}

// A binary expression is an expression with a binary operator, e.g., 1 + 2, 3 * 4, etc.
type BinaryExpression struct {
	Token    Token // The operator token, e.g., '+'
	Operator string
	Left     Expression
	Right    Expression
}

func (be *BinaryExpression) expressionNode() {}

// A function call expression is a function call, e.g., foo(), bar(), etc.
type FunctionCallExpression struct {
	Token     Token // The '(' token
	Function  Expression
	Arguments []Expression
}

func (fce *FunctionCallExpression) expressionNode() {}

// A literal expression is a literal value, e.g., 1, 2, 3, "foo", "bar", etc.
type LiteralExpression struct {
	Token Token
	Value string
}

func (le *LiteralExpression) expressionNode() {}

// An identifier expression is a variable name, e.g., foo, bar, etc.
type IdentifierExpression struct {
	Token Token
	Value string
}

func (ie *IdentifierExpression) expressionNode() {}

// A unary operation expression is an expression with a unary operator, e.g., -1, !true, etc.
type BinaryOperationExpression struct {
	Token    Token // The operator token (e.g., '+', '-', '*', '/')
	Left     Expression
	Operator TokenType
	Right    Expression
}

func (boe *BinaryOperationExpression) expressionNode() {}

// A unary expression is an expression with a unary operator, e.g., -1, !true, etc.
type UnaryExpression struct {
	Token    Token // The operator token, e.g., '-', '!'
	Operator string
	Operand  Expression
}

func (ue *UnaryExpression) expressionNode() {}

// An array access expression represents accessing an element of an array, e.g., foo[0], bar[2], etc.
type ArrayAccessExpression struct {
	Token Token // The '[' token
	Array Expression
	Index Expression
}

func (aae *ArrayAccessExpression) expressionNode() {}

// A member access expression represents accessing a member of a struct or object, e.g., foo.bar, person.name, etc.
type MemberAccessExpression struct {
	Token  Token // The '.' token
	Object Expression
	Member Expression
}

func (mae *MemberAccessExpression) expressionNode() {}

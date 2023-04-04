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

// A unary operation expression is an expression with a unary operator, e.g., -1, !true, etc.
type UnaryOperationExpression struct {
	Token    Token // The operator token (e.g., '+', '-', '*', '/')
	Operator TokenType
	Operand  Expression
}

func (uoe *UnaryOperationExpression) expressionNode() {}

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

// A tuple expression is an expression that groups multiple expressions together, e.g., (a, b, c)
type TupleExpression struct {
	Token       Token // The '(' token
	Expressions []Expression
}

func (te *TupleExpression) expressionNode() {}

// A ternary expression is an expression with a conditional operator, e.g., a ? b : c
type TernaryExpression struct {
	Token       Token // The '?' token
	Condition   Expression
	Consequence Expression
	Alternative Expression
}

func (te *TernaryExpression) expressionNode() {}

// An assignment expression is an expression that assigns a value to a variable, e.g., a = b
type AssignmentExpression struct {
	Token Token // The '=' token
	Left  Expression
	Right Expression
}

func (ae *AssignmentExpression) expressionNode() {}

// A conditional expression is an expression that evaluates to one of two values depending on a condition, e.g., a ? b : c
type ConditionalExpression struct {
	Token       Token // The '?' token
	Condition   Expression
	Consequence Expression
	Alternative Expression
}

func (ce *ConditionalExpression) expressionNode() {}

// NewExpression represents a new instance creation, e.g., new Foo(), new Bar[5]
type NewExpression struct {
	Token  Token // The 'new' keyword token
	Type   Expression
	Length Expression // For array types, this is the length of the array
}

func (ne *NewExpression) expressionNode() {}

// IndexAccessExpression represents an index access expression, e.g., foo[2]
type IndexAccessExpression struct {
	Token Token // The '[' token
	Array Expression
	Index Expression
}

func (iae *IndexAccessExpression) expressionNode() {}

// MappingAccessExpression represents a mapping access expression, e.g., foo[2][3]
type MappingAccessExpression struct {
	Token   Token // The '[' token
	Mapping Expression
	Key     Expression
}

func (mae *MappingAccessExpression) expressionNode() {}

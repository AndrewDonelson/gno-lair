package lib

import "strings"

const (
	ILLEGAL TokenType = iota
	EOF

	// Keywords
	KWRD_CONTRACT
	KWRD_FUNCTION
	KWRD_MODIFIER
	KWRD_IMPORT
	KWRD_PRAGMA
	KWRD_LIBRARY
	KWRD_STRUCT
	KWRD_ENUM
	KWRD_ADDRESS
	KWRD_ARRAY
	KWRD_MAPPING
	KWRD_EVENT
	KWRD_INTERFACE
	KWRD_IS
	KWRD_NEW
	KWRD_PRIVATE
	KWRD_PUBLIC
	KWRD_INTERNAL
	KWRD_EXTERNAL
	KWRD_PURE
	KWRD_VIEW
	KWRD_PAYABLE
	KWRD_CONSTANT
	KWRD_REQUIRES
	KWRD_IF
	KWRD_ELSE
	KWRD_FOR
	KWRD_WHILE
	KWRD_DO
	KWRD_RETURN
	KWRD_EMIT
	KWRD_SUPER
	KWRD_STATICCALL
	KWRD_CALL
	KWRD_DELEGATECALL
	KWRD_KECCAK256
	KWRD_SHA3
	KWRD_GAS
	KWRD_VALUE
	KWRD_SELFBALANCE
	KWRD_SUICIDE
	KWRD_ASSERT
	KWRD_REVERT
	KWRD_REQUIRE
	KWRD_ABORT
	KWRD_ECRECOVER
	KWRD_ADD
	KWRD_MUL
	KWRD_SUB
	KWRD_DIV
	KWRD_SDIV
	KWRD_MOD
	KWRD_SMOD
	KWRD_ADD_MOD
	KWRD_SUB_MOD
	KWRD_EXP
	KWRD_SIGNEXTEND

	// Identifiers
	IDNT_IDENT

	// Literals
	LITR_INT
	LITR_STRING
	LITR_BOOL
	LITR_HEX

	// Operators
	OPER_PLUS
	OPER_MINUS
	OPER_MULTIPLY
	OPER_DIVIDE
	OPER_MODULO
	OPER_ASSIGN
	OPER_AND
	OPER_OR
	OPER_NOT
	OPER_XOR
	OPER_BITWISE_NOT
	OPER_BITWISE_AND
	OPER_BITWISE_OR
	OPER_BITWISE_XOR
	OPER_LEFT_PAREN
	OPER_RIGHT_PAREN
	OPER_LEFT_BRACE
	OPER_RIGHT_BRACE
	OPER_COMMA
	OPER_COLON
	OPER_SEMICOLON
	OPER_PERIOD
	OPER_EQUAL
	OPER_LESS_THAN
	OPER_GREATER_THAN

	// Comments
	COMMENT_SINGLE_LINE
	COMMENT_MULTI_LINE
)

// TokenType represents the type of a token
type TokenType int

// Token represents a single token extracted from the Solidity source code
type Token struct {
	Type    TokenType
	Literal string
}

// Lexer is the main struct of the lexer
type Lexer struct {
	input    string
	position int
	//readPos  int
	ch byte
}

var keywords = map[string]TokenType{
	"contract":     KWRD_CONTRACT,
	"function":     KWRD_FUNCTION,
	"modifier":     KWRD_MODIFIER,
	"import":       KWRD_IMPORT,
	"pragma":       KWRD_PRAGMA,
	"library":      KWRD_LIBRARY,
	"struct":       KWRD_STRUCT,
	"enum":         KWRD_ENUM,
	"address":      KWRD_ADDRESS,
	"array":        KWRD_ARRAY,
	"mapping":      KWRD_MAPPING,
	"event":        KWRD_EVENT,
	"interface":    KWRD_INTERFACE,
	"is":           KWRD_IS,
	"new":          KWRD_NEW,
	"private":      KWRD_PRIVATE,
	"public":       KWRD_PUBLIC,
	"internal":     KWRD_INTERNAL,
	"external":     KWRD_EXTERNAL,
	"pure":         KWRD_PURE,
	"view":         KWRD_VIEW,
	"payable":      KWRD_PAYABLE,
	"constant":     KWRD_CONSTANT,
	"requires":     KWRD_REQUIRES,
	"if":           KWRD_IF,
	"else":         KWRD_ELSE,
	"for":          KWRD_FOR,
	"while":        KWRD_WHILE,
	"do":           KWRD_DO,
	"return":       KWRD_RETURN,
	"emit":         KWRD_EMIT,
	"super":        KWRD_SUPER,
	"staticcall":   KWRD_STATICCALL,
	"call":         KWRD_CALL,
	"delegatecall": KWRD_DELEGATECALL,
	"keccak256":    KWRD_KECCAK256,
	"sha3":         KWRD_SHA3,
	"gas":          KWRD_GAS,
	"value":        KWRD_VALUE,
	"selfbalance":  KWRD_SELFBALANCE,
	"suicide":      KWRD_SUICIDE,
	"assert":       KWRD_ASSERT,
	"revert":       KWRD_REVERT,
	"require":      KWRD_REQUIRE,
	"abort":        KWRD_ABORT,
	"ecrecover":    KWRD_ECRECOVER,
	"add":          KWRD_ADD,
	"mul":          KWRD_MUL,
	"sub":          KWRD_SUB,
	"div":          KWRD_DIV,
	"sdiv":         KWRD_SDIV,
	"mod":          KWRD_MOD,
	"smod":         KWRD_SMOD,
	"addmod":       KWRD_ADD_MOD,
	"submod":       KWRD_SUB_MOD,
	"exp":          KWRD_EXP,
	"signextend":   KWRD_SIGNEXTEND,
}

// Helper Functions
// newToken creates a new token with the given type and literal value
func newToken(tokenType TokenType, ch byte) Token {
	return Token{Type: tokenType, Literal: string(ch)}
}

// isLetter checks if a character is a letter or an underscore
func isLetter(ch byte) bool {
	return ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z') || ch == '_'
}

// isDigit checks if a character is a digit
func isDigit(ch byte) bool {
	return '0' <= ch && ch <= '9'
}

// readChar reads the next character from the input
func (l *Lexer) readChar() {
	if l.position >= len(l.input) {
		l.ch = 0
	} else {
		l.ch = l.input[l.position]
	}
	l.position++
}

// readIdentifier reads an identifier and advances the lexer's position
func (l *Lexer) readIdentifier() string {
	var buffer strings.Builder
	for isLetter(l.ch) {
		buffer.WriteByte(l.ch)
		l.readChar()
	}
	return buffer.String()
}

// readNumber reads a number and advances the lexer's position
func (l *Lexer) readNumber() string {
	var buffer strings.Builder
	for isDigit(l.ch) {
		buffer.WriteByte(l.ch)
		l.readChar()
	}
	return buffer.String()
}

// lookupIdent looks up whether a given string is a keyword or an identifier
func lookupIdent(ident string) TokenType {
	if tok, ok := keywords[ident]; ok {
		return tok
	}
	return IDNT_IDENT
}

// NewLexer creates a new lexer
func NewLexer(input string) *Lexer {
	l := &Lexer{
		input: input,
	}
	l.readChar()
	return l
}

// skipWhitespace skips over any whitespace characters
func (l *Lexer) skipWhitespace() {
	for l.ch == ' ' || l.ch == '\t' || l.ch == '\n' || l.ch == '\r' {
		l.readChar()
	}
}

func (l *Lexer) NextToken() Token {
	var tok Token

	l.skipWhitespace()

	switch l.ch {
	case '=':
		tok = newToken(OPER_ASSIGN, l.ch)
	case ';':
		tok = newToken(OPER_SEMICOLON, l.ch)
	case '(':
		tok = newToken(OPER_LEFT_PAREN, l.ch)
	case ')':
		tok = newToken(OPER_RIGHT_PAREN, l.ch)
	case '{':
		tok = newToken(OPER_LEFT_BRACE, l.ch)
	case '}':
		tok = newToken(OPER_RIGHT_BRACE, l.ch)
	case ',':
		tok = newToken(OPER_COMMA, l.ch)
	case '+':
		tok = newToken(OPER_PLUS, l.ch)
	case '-':
		tok = newToken(OPER_MINUS, l.ch)
	case '*':
		tok = newToken(OPER_MULTIPLY, l.ch)
	case '/':
		tok = newToken(OPER_DIVIDE, l.ch)
	case '%':
		tok = newToken(OPER_MODULO, l.ch)
	case 0:
		tok.Literal = ""
		tok.Type = EOF
	default:
		if isLetter(l.ch) {
			tok.Literal = l.readIdentifier()
			tok.Type = lookupIdent(tok.Literal)
			return tok
		} else if isDigit(l.ch) {
			tok.Literal = l.readNumber()
			tok.Type = LITR_INT
			return tok
		} else {
			tok = newToken(ILLEGAL, l.ch)
		}
	}
	l.readChar()
	return tok
}

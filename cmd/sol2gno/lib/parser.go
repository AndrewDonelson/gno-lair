package lib

type Parser struct {
	l         *Lexer
	curToken  Token
	peekToken Token
	errors    []Error
}

type Error struct {
	msg string
}

func NewParser(l *Lexer) *Parser {
	p := &Parser{
		l:      l,
		errors: []Error{},
	}

	// Read two tokens so curToken and peekToken are both set.
	p.nextToken()
	p.nextToken()

	return p
}

func (p *Parser) nextToken() {
	p.curToken = p.peekToken
	p.peekToken = p.l.NextToken()
}


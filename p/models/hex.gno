package models

import (
	"fmt"
)

type IEncodingHex interface {
	EncodeToString(src []byte) string
	DecodeString(s string) ([]byte, error)
}

type EncodingHex struct{}

func (EncodingHex) EncodeToString(src []byte) string {
	dst := make([]byte, encodedLen(len(src)))
	encode(dst, src)
	return string(dst)
}

func (EncodingHex) DecodeString(s string) ([]byte, error) {
	dst := make([]byte, decodedLen(len(s)))
	_, err := decode(dst, []byte(s))
	if err != nil {
		return nil, err
	}
	return dst, nil
}

func encodedLen(n int) int {
	return n * 2
}

func decodedLen(n int) int {
	return n / 2
}

func encode(dst, src []byte) {
	const hexChars = "0123456789abcdef"
	for i, b := range src {
		dst[i*2] = hexChars[b>>4]
		dst[i*2+1] = hexChars[b&0x0F]
	}
}

func decode(dst, src []byte) (int, error) {
	for i := 0; i < len(src); i += 2 {
		a, ok := fromHexChar(src[i])
		if !ok {
			return i / 2, fmt.Errorf("invalid hex char: %c", src[i])
		}
		b, ok := fromHexChar(src[i+1])
		if !ok {
			return i / 2, fmt.Errorf("invalid hex char: %c", src[i+1])
		}
		dst[i/2] = (a << 4) | b
	}
	return len(src) / 2, nil
}

func fromHexChar(c byte) (byte, bool) {
	switch {
	case '0' <= c && c <= '9':
		return c - '0', true
	case 'a' <= c && c <= 'f':
		return c - 'a' + 10, true
	case 'A' <= c && c <= 'F':
		return c - 'A' + 10, true
	}
	return 0, false
}

package scratch

import "io"

// ((type_declaration (type_spec (name:(type_identifier)@type_decl.name type:(type_identifier)@type_decl.type)))@type_decl.declaration),
type Foo interface {
	io.Reader
	io.Writer
}

// GoImpl Foo
type mockFoo struct{}

func (mockfoo *mockFoo) Read(p []byte) (n int, err error) {
	panic("not implemented") // TODO: Implement
}

func (mockfoo *mockFoo) Write(p []byte) (n int, err error) {
	panic("not implemented") // TODO: Implement
}

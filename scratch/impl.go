package scratch

import "io"

// ((type_declaration (type_spec (name:(type_identifier)@type_decl.name type:(type_identifier)@type_decl.type)))@type_decl.declaration),
type Foo interface {
	io.Reader
	io.Writer
}

type mockFoo struct{}

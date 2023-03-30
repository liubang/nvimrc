package scratch

type Person struct {
	Name     string `json:"name" gorm:"column:name" xml:"Name"`
	UserName string `json:"userName" gorm:"column:user_name" xml:"User Name"`
	UserAge  string `json:"userAge" gorm:"column:user_age" xml:"User Age"`
	Age      int    `json:"age" gorm:"column:age" xml:"Age"`
}

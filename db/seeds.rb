user = [
    {   FirstName: "Suraj",
        LastName: "Singla",
        Username: "suraj333",
        Email: "suraj333@gmail.com",
        Password: "!@QW12qw",
        UserType:  "admin"},
    {   FirstName: "John",
        LastName: "Doe",
        Username: "jD123",
        Email: "jd333@mmail.com",
        Password: ")(PO09po",
        UserType: "user" },
    {   FirstName: "Mickey",
        LastName: "Mouse",
        Username: "mickey222",
        Email: "mouse2323@gmail.com",
        Password: "%^TY56ty",
        UserType: "user" }
]

user.each do |usr|
    User.create(usr)
end
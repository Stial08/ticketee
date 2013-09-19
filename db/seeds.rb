#Create States
new = State.create(name: "New",
             background:"#85FF00",
             color:"white")

open = State.create(name: "Open",
             background: "#00CFFD",
             color: "white")

closed = State.create(name: "Closed",
             background: "black",
             color: "white")


for x in (0...20)
#create users
user = User.create(email: Faker::Internet.email , password: 12345678, password_confirmation: 12345678, admin: false)
#create Projects




#Create Tickets
end

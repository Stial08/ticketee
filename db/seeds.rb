#Create States
states = []
states[0] = State.create(name: "New",background:"#85FF00", color:"white")
states[1] = State.create(name: "Open", background: "#00CFFD", color: "white")
states[2] = State.create(name: "Closed", background: "black", color: "white")
image = nil
#nested_assets = {"0" => {asset:image.store!(File.open(File.join(Rails.root, "/db/fixtures/images/1.jpg")))},
                 #"1" => {asset: File.open(File.join(Rails.root, "/db/fixtures/images/2.jpg"))}, 
                 #"2" => {asset: File.open(File.join(Rails.root, "/db/fixtures/images/3.gif"))}}

for x in (0...3)
#create users
user = User.create(email: "user#{x}@email.com" , password: 12345678, password_confirmation: 12345678, admin: false, mame: "user#{x}")
#create Projects
  for y in (0...2)
    project = Project.new(name: "Project of #{user.name} number #{y}" , description: 'Default description of project', user_id: user.id)
    #project.asset = nested_assets 
    project.save
    #Create Tickets
    for z in (0...10)
      ticket = Ticket.new(title: "Ticket number #{z}",  description: "Description of the ticket number #{z}")
      ticket.tag_names = "Tag#{z} Ticket#{z} number{z} project#{y} user#{x}"
      ticket.project_id = project.id
      ticket.user_id = user.id
      ticket.save
    end
  end
end


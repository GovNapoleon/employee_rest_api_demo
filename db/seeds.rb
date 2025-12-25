# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

unless Department.blank?
  Department.create!(name: "Networking")
  Department.create!(name: "Dispatch")
  Department.create!(name: "Marketting")
  Department.create!(name: "Shipping")
end


unless Country.blank?
  Country.create!(name: "UK")
  Country.create!(name: "Spain")
  Country.create!(name: "Brazil")
  Country.create!(name: "Italy")
end

unless Employee.blank?
  Employee.create!(firstname: "Connors",lastname:"McGregor",haspassport:true,salary:5000,birthdate:'2000-1-1',
                   hiredate:'2020-1-1',gender:'Male',notes:'Notorious Guy!',email:'Connors@gmail.com',phone:'12345',country_id:1,department_id:1)

  Employee.create!(firstname: "Chad",lastname:"Mendis",haspassport:true,salary:5000,birthdate:'2000-1-1',
                   hiredate:'2020-1-1',gender:'Male',notes:'Notorious Guy!',email:'Chad@gmail.com',phone:'12345',country_id:1,department_id:1)

  Employee.create!(firstname: "Nate",lastname:"Diaz",haspassport:true,salary:5000,birthdate:'2000-1-1',
                   hiredate:'2020-1-1',gender:'Male',notes:'Notorious Guy!',email:'Nate@gmail.com',phone:'12345',country_id:1,department_id:1)

  Employee.create!(firstname: "Nick",lastname:"Diaz",haspassport:true,salary:5000,birthdate:'2000-1-1',
                   hiredate:'2020-1-1',gender:'Male',notes:'Notorious Guy!',email:'Nick@gmail.com',phone:'12345',country_id:2,department_id:2)

  Employee.create!(firstname: "Anthony",lastname:"Joshua",haspassport:true,salary:5000,birthdate:'2000-1-1',
                   hiredate:'2020-1-1',gender:'Male',notes:'Notorious Guy!',email:'Anthony@gmail.com',phone:'12345',country_id:2,department_id:2)

  Employee.create!(firstname: "Michael",lastname:"Johnson",haspassport:true,salary:5000,birthdate:'2000-1-1',
                   hiredate:'2020-1-1',gender:'Male',notes:'Notorious Guy!',email:'Michael@gmail.com',phone:'12345',country_id:3,department_id:3)

  Employee.create!(firstname: "Israel",lastname:"Adesanya",haspassport:true,salary:5000,birthdate:'2000-1-1',
                   hiredate:'2020-1-1',gender:'Male',notes:'Notorious Guy!',email:'Adesanya@gmail.com',phone:'12345',country_id:3,department_id:3)

  Employee.create!(firstname: "Michael",lastname:"Chang",haspassport:true,salary:5000,birthdate:'2000-1-1',
                   hiredate:'2020-1-1',gender:'Male',notes:'Notorious Guy!',email:'Chang@gmail.com',phone:'12345',country_id:4,department_id:4)

  Employee.create!(firstname: "Novak",lastname:"Djokovic",haspassport:true,salary:5000,birthdate:'2000-1-1',
                   hiredate:'2020-1-1',gender:'Male',notes:'Notorious Guy!',email:'Novak@gmail.com',phone:'12345',country_id:4,department_id:4)

  Employee.create!(firstname: "Pete",lastname:"Samprass",haspassport:true,salary:5000,birthdate:'2000-1-1',
                   hiredate:'2020-1-1',gender:'Male',notes:'Notorious Guy!',email:'Pete@gmail.com',phone:'12345',country_id:4,department_id:4)


end

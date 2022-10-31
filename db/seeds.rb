# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

kroger = Supermarket.create!(name: "Kroger", location: "123 Camino Del Rio")
publix = Supermarket.create!(name: "Publix", location: "585 Market Street")
whole = Supermarket.create!(name: "Whole Foods", location: "77 Manufacturers Blvd")

crackers = kroger.items.create!(name: "Crackers", price: 3)
pb = kroger.items.create!(name: "Peanut Butter", price: 4)
salmon = kroger.items.create!(name: "Salmon", price: 7)
orange = publix.items.create!(name: "Orange Juice", price: 4)
pesto = publix.items.create!(name: "Pesto", price: 5)
sourdough = publix.items.create!(name: "Sourdough Bread", price: 3)
mango = whole.items.create!(name: "Dried Mango", price: 10)
pretzles = whole.items.create!(name: "Peanut Butter Pretzles", price: 6)
steak = whole.items.create!(name: "Flank Steak", price: 20)

kenz = Customer.create!(name: "Kenz")
zack = Customer.create!(name: "Zack")
nick = Customer.create!(name: "Nick")
lauren = Customer.create!(name: "Lauren")
require 'rails_helper' 

RSpec.describe 'customer show page', type: :feature do
  describe 'as a user' do
    describe 'when I visit /customers/:id' do
      it '- I see the customers name, a that customers list of items with the items name, price, and the name of the supermarket it belongs to' do
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

        lauren.items << salmon
        lauren.items << mango
        lauren.items << steak
        lauren.items << orange
        nick.items << mango
        nick.items << crackers
        nick.items << orange 
        zack.items << pb
        zack.items << pesto
        kenz.items << pretzles
        kenz.items << crackers
        kenz.items << sourdough

        visit "/customers/#{lauren.id}"
        # save_and_open_page

        expect(page).to have_content("Customer Name: #{lauren.name}")
        expect(page).to have_content("Item: #{salmon.name}, Price: $#{salmon.price}, Pickup At: #{kroger.name}")
        expect(page).to have_content("Item: #{mango.name}, Price: $#{mango.price}, Pickup At: #{whole.name}")
        expect(page).to have_content("Item: #{steak.name}, Price: $#{steak.price}, Pickup At: #{whole.name}")
        expect(page).to have_content("Item: #{orange.name}, Price: $#{orange.price}, Pickup At: #{publix.name}")
        expect(page).to_not have_content(zack.name)
        expect(page).to_not have_content(sourdough.name)
        expect(page).to_not have_content(sourdough.price)
      end

      it '- I see a form to add an item to this customer. 
      when I fill in a field with the id of an existing item, and I click submit, 
      I am redirected back to the customers show page, 
      and I see the new item listed upder this customers items' do
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

        lauren.items << salmon
        lauren.items << mango
        lauren.items << steak
        lauren.items << orange
        nick.items << mango
        nick.items << crackers
        nick.items << orange 
        zack.items << pb
        zack.items << pesto
        kenz.items << pretzles
        kenz.items << crackers
        kenz.items << sourdough

        visit "/customers/#{nick.id}"

        fill_in "Add an item to #{nick.name}'s grocery list:", with: 'Steak' 

        click_button('Submit')
        expect(current_path).to eq("/customers/#{nick.id}")
        expect(page).to have_content("Customer Name: #{nick.name}")
        expect(page).to have_content("Item: #{mango.name}, Price: $#{mango.price}, Pickup At: #{whole.name}")
        expect(page).to have_content("Item: #{crackers.name}, Price: $#{crackers.price}, Pickup At: #{kroger.name}")
        expect(page).to have_content("Item: #{orange.name}, Price: $#{orange.price}, Pickup At: #{publix.name}")
        expect(page).to have_content("Item: #{steak.name}, Price: $#{steak.price}, Pickup At: #{whole.name}")
        expect(page).to_not have_content(kenz.name)
        expect(page).to_not have_content(sourdough.name)
        expect(page).to_not have_content(sourdough.price)
      end
    end
  end
end
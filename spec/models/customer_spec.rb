require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :customer_items }
    it { should have_many(:items).through(:customer_items)}
  end

  describe 'instance methods' do
    describe '#add_item' do
      it 'adds an instance of an item to customer.items' do
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

        kenz.add_item(pesto.id)

        expect(kenz.items).to eq([crackers, pesto, sourdough, pretzles])
      end
    end
  end
end
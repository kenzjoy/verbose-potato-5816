class CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @items = Item.all
    if params[:add_item] != nil
      @customer.add_item(params[:add_item])
    end
  end
end
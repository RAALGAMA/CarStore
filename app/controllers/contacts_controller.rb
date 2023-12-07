# app/controllers/contacts_controller.rb
class ContactsController < ApplicationController
  def show
    @contacts = Contact.order(params[:content])
  end
end

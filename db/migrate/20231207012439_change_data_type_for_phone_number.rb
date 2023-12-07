# db/migrate/xxxxxx_change_data_type_for_phone_number_in_contacts.rb
class ChangeDataTypeForPhoneNumberInContacts < ActiveRecord::Migration[6.0]
  def change
    change_column :contacts, :phone_number, :integer
  end
end

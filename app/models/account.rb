class Account < ActiveRecord::Base

  with_options dependent: :destroy do |assoc|
    assoc.has_many :orders
    assoc.has_many :products
    assoc.has_many :contests
  end


  validates_presence_of :shopify_account_url  
  validates_presence_of :shopify_password
end

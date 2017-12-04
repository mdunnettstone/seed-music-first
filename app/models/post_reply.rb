class PostReply < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :account
end

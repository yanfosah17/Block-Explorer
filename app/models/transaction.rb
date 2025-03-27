class Transaction < ApplicationRecord
    validates :hash_key, presence: true, uniqueness: true
    validates :sender, :receiver, :deposit, :block_hash, :height, presence: true
  end
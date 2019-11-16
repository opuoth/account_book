class Post < ApplicationRecord
  validates :incoming,presence: true, if: -> {outgoing.blank?}
  validates :outgoing,presence: true, if: -> {incoming.blank?}
end

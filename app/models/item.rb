class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :category
  has_many :images, dependent: :destroy #親が削除された時に合わせて子も削除される
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :item_size, optional: true
  belongs_to_active_hash :shipping_fee 
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture

  validates :name, 
    presence: true, length: {maximum: 40}, presence: {message: "を入力してください"}
  validates :explanation, 
    presence: true, length: {minimum: 1, maximum: 10000}
  validates :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, :category_id, :images, 
    presence: true, presence: {message: "を選択してください"}
  validates :price, 
    numericality: { only_integer: true, greater_than: 299, less_than: 9999999, message: "入力してください。半角で入力してください。"}
  

  def previous
    Item.where("id < ?", self.id).order("id DESC").first
  end

  def next
    Item.where("id > ?", self.id).order("id ASC").first
  end

end

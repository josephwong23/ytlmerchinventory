class Order < ApplicationRecord
  belongs_to :item
  belongs_to :member

  validates :quantity, presence: true
  validates :order_date, presence: true
  validates :deliver_by, presence: true
  validates :item_id, presence: true
  validates :member_id, presence: true

  scope :active, -> { where(status: true) }
  scope :inactive, -> { where(status: false) }
  scope :expired, -> { where('deliver_by < ?', Date.today) }

  has_paper_trail

  def self.renew(id)
    order = Order.where(id: id)
    order.update(deliver_by: 7.days.from_now)
  end

  def self.toggle_delivery_status(id)
    order = Order.find(id)
    order.update(delivery_status: !order.delivery_status)
  end

  def self.disable(id)
    order = Order.where(id: id)
    order.update(status: false)
  end

  def notification_for_action(action:, who_did_this:)
    send("notification_for_order_#{action}_from_username", who_did_this)
  end

  #######
  private
  #######

  def notification_for_order_create_from_username(username)
    "#{self.member.name} borrowed #{self.quantity} x #{self.item.name} from #{username}"
  end

  def notification_for_order_renew_from_username(username)
    "An item borrowed by #{self.member.name} has been renewed for 7 days from #{username}"
  end

  def notification_for_order_return_from_username(username)
    "#{pluralize(self.quantity, 'item')} borrowed by #{self.member.name} have been marked as returned from #{username}"
  end

  def notification_for_order_cancel_from_username(username)
    "An self regarding #{pluralize(self.quantity, 'item')} borrowed by #{self.member.name} has been canceled from #{username}"
  end
end

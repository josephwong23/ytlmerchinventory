class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :disable, :renew]

  def index
    render locals: { orders:  Order.all,
                     members: Member.all,
                     items:   Item.all,
                     active:  Order.active.all,
                     expired: Order.expired.all }
  end

  def edit
  end

  def update
    new_quantity = order_params["quantity"].to_i
    old_quantity = @order.quantity

    if @order.item.remaining_quantity < new_quantity - old_quantity
      redirect_to :back, alert: "Only #{@order.item.remaining_quantity + old_quantity} items available!"
      return
    end

    if @order.update(order_params)

      if (old_quantity > new_quantity)
        @order.item.increment!(:remaining_quantity, old_quantity - new_quantity)
      elsif (old_quantity < new_quantity)
        @order.item.decrement!(:remaining_quantity, new_quantity - old_quantity)
      end
      redirect_to :root, notice: 'Order was successfully updated.'
      # send_notification_email_for_action(:create)
    else
      render :edit
    end
  end

  def old
    @inactive = Order.inactive.all
  end

  def renew
    Order.renew(@order.id)

    redirect_to :root, notice: 'Renewed for 7 days from now. Enjoy!'

    # send_notification_email_for_action(:renew)
  end

  def toggle_deliver
    Order.toggle_delivery_status(params[:id])

    redirect_to :root, notice: 'Updated Delivery Status'
  end

  def disable
    Order.disable(@order.id) && @order.item.increment!(:remaining_quantity, @order.quantity)

    redirect_to :root, notice: 'Item marked as returned. Thank you!'

    # send_notification_email_for_action(:return)
  end

  def new
    @order  = Order.new
    @member = Member.all
  end

  def create
    @order = Order.new(order_params)
    @order.status ||= true

    if @order.item.remaining_quantity < @order.quantity
      redirect_to :back, alert: 'The quantity you entered is not currently available'
      return
    end

    if @order.save && @order.item.decrement!(:remaining_quantity, @order.quantity)
      redirect_to :root, notice: 'Order was successfully created.'

      # send_notification_email_for_action(:create)
    else
      render :new
    end
  end

  def destroy
    item = @order.item
    if @order.destroy
      if !@order.delivery_status
        item.increment!(:remaining_quantity, @order.quantity)
      end
    end

    redirect_to orders_url, notice: 'Order was successfully destroyed.'

    # send_notification_email_for_action(:cancel)
  end

  #######
  private
  #######

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:quantity, :deliver_by, :order_date, :status, :item_id, :member_id, :reason, :delivery_status)
  end

  def order_mailer_params
    { order: @order, user: current_user }
  end

  def send_notification_email_for_action(action)
    OrderMailer.delay.send_notification(
        mail_locals: { order: @order, user: current_user },
        action:      action,
        subject:     notification_for_action(action: action, who_did_this: current_user.name)
    ).deliver rescue nil
  end
end

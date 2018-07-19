class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_receipt(order)
    @order = order[:order]
    @email = @order.email
    mail(to: @email, subject: "Thank you for your order! Your order number is #{@order.id}") do |format|
      format.html {render 'order_receipt'}
    end
  end
end

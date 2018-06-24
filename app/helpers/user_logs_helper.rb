module UserLogsHelper
  def parse_version(version)
    if (version.event == "create")
      html = "
        <% version.changeset.except(:id, :created_at, :updated_at, :status).each do |key, val| %>
          <span class='text-muted'><%= key + ': ' %></span>
          <span class='text-green'><%= val[1] %></span>
          <br/>
        <% end %>
      "
      return ERB.new(html).result(binding).html_safe
    elsif (version.event == "update")
      html = "
        <% version.changeset.except(:id, :created_at, :updated_at, :status).each do |key, val| %>
          <span class='text-muted'><%= key + ': ' %></span>
          <span class='text-danger'><%= val[0] %></span>
          <i class='fa fa-caret-right'></i>
          <span class='text-green'><%= val[1] %></span>
          <br/>
        <% end %>
      "
      return ERB.new(html).result(binding).html_safe
    elsif (version.event == "destroy")
      html = '
        <% version.object.split("\n")[1..-1].each do |pair| %>
          <% prop = pair.split(": ") %>
          <% if !prop[0].end_with? "_at" %>
            <s class="text-muted"><%= prop[0] %>: <%= prop[1] %></s><br/>
          <% end %>
        <% end %>
      '
      return ERB.new(html).result(binding).html_safe
    else
      return "-"
    end
  end
end
    # def format_item(item)
    #   return "" if item.nil?
    #   html = "
    #     Name: <%= item.name %><br/>
    #     Quantity: <%= item.quantity %><br/>
    #     Remaining Quantity: <%= item.remaining_quantity %><br/>
    #     Category: <%= item.category ? item.category.name : '-' %><br/>
    #     Division: <%= item.member_division ? item.member_division.name : '-' %><br/>
    #     Description: <%= item.description.empty? ? '-' : item.description %><br/>
    #   "
    #   ERB.new(html).result(binding).html_safe
    # end

    # def format_order(order)

    #   return "" if order.nil?
    #   html = "
    #     Item: <%= order.item ? order.item.name : '-' %><br/>
    #     Member: <%= order.member ? order.member.name : '-' %><br/>
    #     Quantity: <%= order.quantity %><br/>
    #     Deliver_by: <%= order.deliver_by %><br/>
    #     Order Date: <%= order.order_date %><br/>
    #     Reason: <%= order.reason.empty? ? '-' : order.reason %><br/>
    #   "

    #   ERB.new(html).result(binding).html_safe
    # end

    # #category, item, order, member, member_division
    # def parse_version_object(obj, type)
    #   case type
    #   when "Category"
    #     'format_category(obj)'
    #   when "Item"
    #     format_item(obj)
    #   when "Order"
    #     format_order(obj)
    #   when "Member"
    #     'format_member(obj)'
    #   when "MemberDivision"
    #     'format_member_division(obj)'
    #   else
    #     return '--'
    #   end
    # end

    # def parse_version(version)
    #   case version.event
    #   when "create"
    #     parse_version_object(version.item, version.item_type)
    #   when "destroy"
    #     parse_version_object(version.reify, version.item_type)
    #   when "update"
    #     'parse_version_changeset(version.changeset, version.item_type)'
    #   else
    #     '---'
    #   end
    # end

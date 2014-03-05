class SubscriptionWorker

  def place_subscription_orders
    SubscriptionOrder.where(status: :pending).includes(:issue).each do |sub_order|
      if sub_order.issue.published?
        place_order(sub_order)
      else
        # calc shipping now and bake in
        # mark as preorder
        sub_order.update_attributes status: :preorder# shipping cost here too
      end
    end
  end

  def process_preorders

    preordered_issues = SubscriptionOrder.where(status: :preorder).pluck(:issue_id)

    orderable_issues = Issue.where(id: preordered_issues).to_a.select{ |i| i.published? }.collect(&:id)

    if orderable_issues.any?
      SubscriptionOrder.where(status: :preorder, issue_id: orderable_issues).each do |sub_order|
        place_order sub_order
      end
    end

  end

  private

    def place_order sub_order
      # create Shoppe order
      # calc shipping if not baked in to the sub_order
      # charge the card
      #     deal with fails here, email, update status etc
      # send email
      # update status
    end
end

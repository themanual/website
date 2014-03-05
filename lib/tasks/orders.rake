namespace :themanual do

  desc "Create Shoppe (pre)orders from subscription orders"
  task place_subscription_orders: :environment do

    SubscriptionWorker.new.place_subscription_orders

  end

  desc "Create Shoppe orders from pre-ordered subscription order"
  task process_preorders: :environment do

    SubscriptionWorker.new.process_preorders

  end

end

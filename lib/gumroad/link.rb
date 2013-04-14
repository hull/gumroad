module Gumroad
  class Link

    LinkAttributes = [
      :id, 
      :name, 
      :url, 
      :description, 
      :price,
      :preview, 
      :country_available, 
      :max_purchase_count, 
      :customizable_price, 
      :webhook, 
      :require_shipping, 
      :shown_on_profile, 
      :custom_receipt, 
      :custom_product_type
    ]

    attr_accessor LinkAttributes
    
    def initialize(session, json)
      @session = session
      LinkAttributes.each do |attribute|
        instance_variable_set(:"@#{attribute}", json[attribute.to_s])
      end
    end

    def save
      params = LinkAttributes.inject({}) { |prms, p| prms.merge(p => send(p)) }
      @session.post("/links", params)
      self
    end

    def destroy
      @session.delete("/links/#{id}")
    end
  end
end
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

    attr_accessor *LinkAttributes
    
    def initialize(session, json)
      @session = session
      LinkAttributes.each do |attribute|
        instance_variable_set(:"@#{attribute}", json[attribute.to_s])
      end
    end

    def save
      if @id
        @session.put("/links/#{@id}", attributes)
      else
        @session.post("/links", attributes)
      end
      self
    end

    def destroy
      @session.delete("/links/#{id}")
    end

    def attributes
      LinkAttributes.inject({}) { |prms, p| prms.merge(p => send(p)) }
    end

  end
end
class Application

  @@items = [Item.new("Bread", 2.99),
            Item.new("Peanuts", 5.00)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item = @@items.find{|i| i.name == item_name}
      if item
        resp.write item.price
      else
        resp.write "Sorry, item does not exist"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end

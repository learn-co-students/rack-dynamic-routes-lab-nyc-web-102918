class Application
  @@items = [Item.new("Apple", 0.50)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last #turn /items/name into name?

      if item = @@items.find{|item| item.name == item_name} #Find the first item in @@items array of objects, where item[:name] is equal to the item listes above
        resp.write item.price #Then output the price of that item.
      else
        resp.status = 400 #this is the response you give if there is no item of that name.
        resp.write "Item not found"
      end

    else
      resp.status = 404
      resp.write "Route not found"
    end

    resp.finish
  end
end #class Application

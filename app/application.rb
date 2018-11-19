class Application
  @@items=[]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      search_item=req.path.split("/items/").last
      found_item=@@items.find{|item|item.name == search_item}
        if found_item
          resp.write(found_item.price)
        else resp.write "Item not found"
            resp.status = 400
        end
      else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end

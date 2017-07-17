class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      Item.items.each do |item|
        if item.name == (req.path.split("/items/").last)
          resp.write "#{item.price}"
          break
        else
          resp.write "Item not found"
          resp.status = 400
        end
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end

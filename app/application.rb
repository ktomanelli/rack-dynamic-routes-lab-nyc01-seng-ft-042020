class Application
    @@items=[]
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        if(req.path.match(/items/))
            item_name = req.path.split('/items/').last
            my_item = @@items.find do |i|
                i.name == item_name
            end
            if my_item
                resp.write "#{my_item.price}"
            else
                return [400,{'Content-Type'=>'text/html'},["Item not found"]]
            end
            resp.finish
        else
            return [404,{'Content-Type'=>'text/html'},["<p>Route not found</p>"]]
        end
    end
end


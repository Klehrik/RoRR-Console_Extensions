Console.new{
    "zoom",
    {
        "Toggle fast speed and extra jumps for the local player.",
    },
    function(args)
        if not Util.bool(Global.__run_exists) then
            Console.print("Not currently in a run.")
            return
        end

        local p = Player.get_local()
        if not Instance.exists(p) then
            Console.print("Local player does not exist.")
            return
        end

        local p_data = Instance.get_data(p)
        p_data.zoom = not p_data.zoom

        local fn = "item_"..(p_data.zoom and "give" or "take")
        p[fn](p, Item.find("paulsGoatHoof"), 50)
        p[fn](p, Item.find("hopooFeather"), 50)
        p[fn](p, Item.find("rustyJetpack"), 10)

        Console.print("Zoom is now "..tostring(p_data.zoom and "ON" or "OFF")..".")
    end
}
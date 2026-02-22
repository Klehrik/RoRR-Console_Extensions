Console.new{
    "god",
    {
        "Toggle invincibility for the local player.",
    },
    function(args)
        if not Util.bool(Global.__run_exists) then
            Console.print("Not currently in a run.")
            return
        end

        if Net.client then
            Console.print("Must be lobby host.")
            return
        end

        local p = Player.get_local()
        if not Instance.exists(p) then
            Console.print("Local player does not exist.")
            return
        end

        local p_data = Instance.get_data(p)
        p_data.god = not p_data.god

        Console.print("Invincibility is now "..tostring(p_data.god and "ON" or "OFF")..".")
    end
}

Hook.add_post(gm.constants.__input_system_tick, function(self, other, result, args)
    local p = Player.get_local()
    if not Instance.exists(p) then return end
    
    local p_data = Instance.get_data(p)
    if not p_data.god then return end

    local inv = p.invincible
    if inv == false then inv = 0 end
    p.invincible = math.max(inv, 3)
end)
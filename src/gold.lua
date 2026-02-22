local packet

Console.new{
    "gold (amount) [m_id]",
    {
        "Set the amount of gold a player has.",
        {"(amount)", "number", "The amount of gold to set."},
        {"[m_id]",   "number", "The m_id of the player. Local player by default."},
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
        
        local amount = math.floor(args[1])
        if type(amount) ~= "number" or amount < 0 then
            Console.print("Enter a valid amount.")
            return
        end

        local m_id = args[2]
        local p = Player.get_local()
        if m_id then
            if type(m_id) ~= "number" then
                Console.print("Invalid value for m_id.")
                return
            end
            p = get_player(m_id)
        end
        if not Instance.exists(p) then
            Console.print("Player does not exist.")
            return
        end

        if p == Player.get_local() then
            local hud = Instance.find(gm.constants.oHUD)
            if hud == Instance.INVALID then
                Console.print("HUD does not exist.")
                return
            end

            hud.gold = amount
            return
        end

        packet:send_direct(p, amount)
    end
}

packet = Packet.new("gold")
packet:set_serializers(
    function(buffer, amount)
        buffer:write_uint(amount)
    end,

    function(buffer, player)
        local hud = Instance.find(gm.constants.oHUD)
        if hud == Instance.INVALID then return end
        hud.gold = buffer:read_uint()
    end
)
Console.new{
    "skip_teleporter [teleport_player]",
    {
        "Skip the teleporter (i.e., finish activation entirely). \nThis includes the ship console.",
        {"[teleport_player]", "bool", "If <y>true</c>, the local player will be teleported to the teleporter. <y>false</c> by default."}
    },
    function(args)
        if not Util.bool(Global.__run_exists) then
            Console.print("Not currently in a run.")
            return
        end

        local player
        local tp_player = args[1]
        if tp_player then
            if type(tp_player) ~= "boolean" then
                Console.print("Invalid value for teleport_player.")
                return
            end

            player = Player.get_local()
            if not Instance.exists(player) then
                Console.print("Local player does not exist.")
                return
            end
        end

        -- Teleporters
        local tp = Instance.find(gm.constants.pTeleporter)
        if Instance.exists(tp) then
            tp.active = 3

        -- Ship console
        else
            cmd = Instance.find(gm.constants.oCommand)
            if Instance.exists(cmd) then
                tp = Instance.create(cmd.x, cmd.y, gm.constants.oCommandFinal)
                Instance.destroy(cmd)
            end
        end

        -- Teleport player
        if (tp ~= Instance.INVALID) and player then
            player.x = tp.x
            player.y = tp.y - 12
        end
    end
}
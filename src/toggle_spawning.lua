local director_alarm_value

Console.new{
    "toggle_spawning",
    {
        "Toggle enemy spawning.",
    },
    function(args)
        local director = Instance.find(gm.constants.oDirectorControl)
        if not Instance.exists(director) then
            Console.print("Not currently in a run.")
            return
        end

        if Net.client then
            Console.print("Must be lobby host.")
            return
        end

        local status = not Util.bool(director.peace)
        director.peace = status
        if status then director_alarm_value = director:alarm_get(1)
        else           director:alarm_set(1, director_alarm_value or 60)
        end

        Console.print("Spawning is now "..tostring(status and "OFF" or "ON")..".")
    end
}
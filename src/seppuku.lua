Console.new{
    "seppuku",
    {
        "Kill the local player.",
    },
    function(args)
        local p = Player.get_local()
        if not Instance.exists(p) then
            Console.print("Local player does not exist.")
            return
        end

        p:kill()
    end
}
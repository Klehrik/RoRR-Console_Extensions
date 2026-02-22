Console.new{
    "list_players",
    {
        "List all player 'm_id's and 'user_name's.",
    },
    function(args)
        if not Util.bool(Global.__run_exists) then
            Console.print("Not currently in a run.")
            return
        end

        -- Collect players
        local t = {}
        local ps = Instance.find_all(gm.constants.oP)
        for _, p in ipairs(ps) do
            table.insert(t, {math.floor(p.m_id), p.user_name})
        end
        table.sort(t, function(a, b) return a[1] < b[1] end)

        -- Format and print
        local str = ""
        for i, p in ipairs(t) do
            if i > 1 then str = str.."\n" end
            str = str.."<y>"..Util.pad_string_right_to_width(p[1], 25).."</c>"..p[2]
        end
        Console.print(str)
    end
}
Console.new{
    "list_class (class) [page]",
    {
        "List all the namespace-identifiers for a content class (in pages of 90). \nValid classes: \n<y>achievement</c> \n<y>actor_skin</c> \n<y>actor_state</c> \n<y>artifact</c> \n<y>buff</c> \n<y>difficulty</c> \n<y>elite</c> \n<y>ending_type</c> \n<y>environment_log</c> \n<y>equipment</c> \n<y>game_mode</c> \n<y>interactable_card</c> \n<y>item</c> \n<y>item_log</c> \n<y>monster_card</c> \n<y>monster_log</c> \n<y>skill</c> \n<y>stage</c> \n<y>survivor</c> \n<y>survivor_log</c>",
        {"(class)", "string", "The content class to list."},
        {"[page]",  "number", "The page to list, indexed from 1. <y>1</c> by default."},
    },
    function(args)
        if type(args[1]) ~= "string" then
            Console.print("Enter a valid class.")
            return
        end

        local array = Global["class_"..args[1]]
        if type(array) ~= "Array" then
            Console.print("Class '"..args[1].."' not found.")
            return
        end

        local page = args[2]
        if page and (type(page) ~= "number" or page <= 0) then
            Console.print("Invalid page number.")
            return
        end
        page = math.floor(page or 1)

        -- Collect values
        local rows = {}
        local row_count = 30
        local start = (page - 1) * 90
        for i = start, start + 89 do
            local element = array:get(i)

            if element then
                -- Create row if existn't
                local row = (i % row_count) + 1
                rows[row] = rows[row] or {}

                table.insert(rows[row], {i, element[2], element[1]})  -- id, identifier, namespace
            end
        end

        -- Format and print
        local str = "Listing elements <y>"..start.."</c> to <y>"..(start + 89).."</c> (of <y>"..math.floor(#array - 1).."</c>):\n"
        for i, row in ipairs(rows) do
            local line = ""

            for j, element in ipairs(row) do
                local id         = Util.pad_string_right_to_width(element[1], 25)
                local identifier = Util.pad_string_right_to_width(element[2], 170)
                local namespace  = Util.pad_string_right_to_width(element[3], 80)

                if j > 1 then line = line.."| " end
                line = line.."<y>"..id.."</c>".." "..identifier.." "..namespace.." "
            end

            str = str.."\n"..line
        end
        Console.print(str)
    end
}
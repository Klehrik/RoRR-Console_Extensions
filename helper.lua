-- Helper

nsid_split = function(nsid)
    local ns
    local id = nsid
    local delimiter = nsid:find("-")
    if delimiter then
        ns = nsid:sub(1, delimiter - 1)
        id = nsid:sub(delimiter + 1, -1)
    end
    return id, ns
end

get_player = function(m_id)
    local ps = Instance.find_all(gm.constants.oP)
    for _, p in ipairs(ps) do
        if p.m_id == m_id then return p end
    end
    return Instance.INVALID
end
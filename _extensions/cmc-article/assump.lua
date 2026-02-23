tappend = pandoc.List.extend

-- slice elements out of a table
function tslice(t, first, last, step)
  local sliced = {}
  for i = first or 1, last or #t, step or 1 do
    sliced[#sliced+1] = t[i]
  end
  return sliced
end

function refType(id)
    local match = string.match(id, "^(%a+)%-")
    if match then
        return pandoc.text.lower(match)
    else
        return nil
    end
end

function proc_assump(el)
    if refType(el.attr.identifier) == "asm" then
        local capEl = el.content[1]
        local name = nil
        if capEl ~= nil and capEl.t == 'Header' then
            name = quarto.utils.as_inlines(capEl.content) --pandoc.utils.stringify(capEl.content)
            el.content = tslice(el.content, 2)
        end

        local shortname = pandoc.text.upper(string.sub(el.attr.identifier, 5, -1))

        if quarto.doc.is_format("latex") then
            local namestr = name and pandoc.utils.stringify(name) or ""
            local callthm = pandoc.Div({})
            callthm.content:insert(pandoc.RawBlock("latex", "\\begin{assump}[" .. namestr .. "]{" .. shortname .. "}"))
            tappend(callthm.content, quarto.utils.as_blocks(el.content))
            callthm.content:insert(pandoc.RawBlock("latex", "\\end{assump}"))
            return callthm
        elseif quarto.doc.is_format("typst") then
            local preamble = pandoc.Plain({pandoc.RawInline("typst", "#block[#strong[Assumption " .. shortname .. "]")})
            if name and #name > 0 then
                preamble.content:insert(pandoc.RawInline("typst", ' ('))
                tappend(preamble.content, name)
                preamble.content:insert(pandoc.RawInline("typst", ')'))
            end
            preamble.content:insert(pandoc.RawInline("typst", "*.*#h(0.5em)#emph["))
            local callthm = pandoc.Div(preamble)
            tappend(callthm.content, quarto.utils.as_blocks(el.content))
            callthm.content:insert(pandoc.RawInline("typst", "]] <" .. el.attr.identifier .. ">"))
        else
            quarto.log.output("Warning: Unsupported format for assumption environments.")
        end

        return callthm
    end
    return el
end

function proc_cite(el)
    local refs = pandoc.Inlines({})
    for i, cite in ipairs (el.citations) do
        local label = cite.id
        local type = refType(label)
        if type == "asm" then
            local name = pandoc.text.upper(string.sub(label, 5, -1))
            local ref = pandoc.List()
            if quarto.doc.is_format("latex") then
                local key = string.sub(label, 5, -1)
                ref:insert(pandoc.RawInline('latex', '\\ref{asm-' .. key .. '}'))
            elseif quarto.doc.is_format("typst") then
                ref:insert(1, pandoc.RawInline('typst', '#link(<' .. label .. '>)['))
                -- if cite.mode ~= "SuppressAuthor" then
                --     ref:insert(pandoc.RawInline('typst', 'Assumption '))
                -- end
                ref:insert(pandoc.RawInline('typst', name .. ']'))
            else
                quarto.log.output("Warning: Unsupported format for assumption environments.")
            end
            refs:extend(ref)
        end
    end

    if #refs > 0 then
        return refs
    else
        return el
    end
end


return {
    { Div = proc_assump },
    { Cite = proc_cite }
}
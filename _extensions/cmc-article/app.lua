-- Handle appendices

seen_app = false
seen_div = false

function proc_app(el)
    if el.attr.classes:includes("appendix") and not seen_app then
        seen_app = true
        if quarto.doc.isFormat("latex") then
            return pandoc.List({
                pandoc.RawBlock("latex", "\\appendix\n"),
                pandoc.RawInline("latex", "\\renewcommand\\thefigure{\\thesection.\\arabic{figure}}\n"),
                pandoc.RawInline("latex", "\\setcounter{figure}{0}\n\n"),
                el
            })
        end
    end
end

return {
    { Header = proc_app }
}

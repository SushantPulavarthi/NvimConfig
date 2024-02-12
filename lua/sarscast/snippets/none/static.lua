local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

-- Math context detection-- Math context detection
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Environment/syntax context detection
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end
tex.in_tikz = function()
    local is_inside = vim.fn['vimtex#env#is_inside']("tikzpicture")
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

-- Return snippet tables
return
{
    s({ trig = "q" },
        {
            t("\\quad "),
        }
    ),
    s({ trig = "qq" },
        {
            t("\\qquad "),
        }
    ),
    s({ trig = "npp" },
        {
            t({ "\\newpage", "" }),
        },
        { condition = line_begin }
    ),
    s({ trig = "which" },
        {
            t("\\text{ for which } "),
        },
        { condition = tex.in_mathzone }
    ),
    s({ trig = "all" },
        {
            t("\\text{ for all } "),
        },
        { condition = tex.in_mathzone }
    ),
    s({ trig = "and" },
        {
            t("\\quad \\text{and} \\quad"),
        },
        { condition = tex.in_mathzone }
    ),
    s({ trig = "forall" },
        {
            t("\\text{ for all } "),
        },
        { condition = tex.in_mathzone }
    ),
    s({ trig = "toc" },
        {
            t("\\tableofcontents"),
        },
        { condition = line_begin }
    ),
    s({ trig = "inff" },
        {
            t("\\infty"),
        }
    ),
    s({ trig = "ii" },
        {
            t("\\item "),
        },
        { condition = line_begin }
    ),
    s({ trig = "--" },
        { t('% --------------------------------------------- %') },
        { condition = line_begin }
    ),
    -- HLINE WITH EXTRA VERTICAL SPACE
    s({ trig = "hl" },
        { t('\\hline {\\rule{0pt}{2.5ex}} \\hspace{-7pt}') },
        { condition = line_begin }
    ),
}

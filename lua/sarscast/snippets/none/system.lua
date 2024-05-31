local helpers = require('sarscast.snippets.luasnip-helper-funcs')
local get_visual = helpers.get_visual

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

-- Math context detection-- Math context detection
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return
{
    -- ANNOTATE (custom command for annotating equation derivations)
    s({ trig = "ann" },
        fmta(
            [[
      \annotate{<>}{<>}
      ]],
            {
                i(1),
                d(2, get_visual),
            }
        )
    ),
    -- REFERENCE
    s({ trig = " RR", wordTrig = false },
        fmta(
            [[
      ~\ref{<>}
      ]],
            {
                d(1, get_visual),
            }
        )
    ),
    -- DOCUMENTCLASS
    s({ trig = "dcc" },
        fmta(
            [=[
        \documentclass[<>]{<>}
        ]=],
            {
                i(1, "a4paper"),
                i(2, "article"),
            }
        ),
        { condition = line_begin }
    ),
    -- USE A LATEX PACKAGE
    s({ trig = "pack" },
        fmta(
            [[
        \usepackage{<>}
        ]],
            {
                d(1, get_visual),
            }
        ),
        { condition = line_begin }
    ),
    -- LABEL
    s({ trig = "lbl" },
        fmta(
            [[
      \label{<>}
      ]],
            {
                d(1, get_visual),
            }
        )
    ),
    -- HPHANTOM
    s({ trig = "hpp" },
        fmta(
            [[
      \hphantom{<>}
      ]],
            {
                d(1, get_visual),
            }
        )
    ),
    s({ trig = "TODOO" },
        fmta(
            [[\TODO{<>}]],
            {
                d(1, get_visual),
            }
        )
    ),
    s({ trig = "nc" },
        fmta(
            [[\newcommand{<>}{<>}]],
            {
                i(1),
                i(2)
            }
        ),
        { condition = line_begin }
    ),
    s({ trig = "sii" },
        fmta(
            [[\si{<>}]],
            {
                i(1),
            }
        )
    ),
    s({ trig = "SI" },
        fmta(
            [[\SI{<>}{<>}]],
            {
                i(1),
                i(2)
            }
        )
    ),
    -- URL
    s({ trig = "url" },
        fmta(
            [[\url{<>}]],
            {
                d(1, get_visual),
            }
        )
    ),
    -- href command with URL in visual selection
    s({ trig = "LU" },
        fmta(
            [[\href{<>}{<>}]],
            {
                d(1, get_visual),
                i(2)
            }
        )
    ),
    -- href command with text in visual selection
    s({ trig = "LL" },
        fmta(
            [[\href{<>}{<>}]],
            {
                i(1),
                d(2, get_visual)
            }
        )
    ),
    -- HSPACE
    s({ trig = "hss" },
        fmta(
            [[\hspace{<>}]],
            {
                d(1, get_visual),
            }
        )
    ),
    -- VSPACE
    s({ trig = "vss" },
        fmta(
            [[\vspace{<>}]],
            {
                d(1, get_visual),
            }
        )
    ),
    -- SECTION
    s({ trig = "h1" },
        fmta(
            [[\section{<>}]],
            {
                d(1, get_visual),
            }
        )
    ),
    -- SUBSECTION
    s({ trig = "h2" },
        fmta(
            [[\subsection{<>}]],
            {
                d(1, get_visual),
            }
        )
    ),
    -- SUBSUBSECTION
    s({ trig = "h3" },
        fmta(
            [[\subsubsection{<>}]],
            {
                d(1, get_visual),
            }
        )
    ),
}

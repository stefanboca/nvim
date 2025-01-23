return {
  -- don't skip next on `$` (for typst/latex/etc)
  {
    "echasnovski/mini.pairs",
    opts = {
      skip_next = [=[[%w%%%'%[%"%.%`]]=],
    },
  },
}

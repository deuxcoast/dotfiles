return {
  {
    condition = function()
      return #require("doctor").errors > 0
    end,
    {
      provider = "  ",
      hl = "Error",
    },
  },
  {
    condition = function()
      return #require("doctor").warnings > 0
    end,
    {
      provider = "  ",
      hl = "Comment",
    },
  },
}

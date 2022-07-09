local M = {}

function M.setup()
  require("lightspeed").setup({
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 5,
    labels = nil,
    cycle_group_fwd_key = nil,
    cycle_group_bwd_key = nil,
    ignore_case = false,
    exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },
    jump_to_unique_chars = { safety_timeout = 400 },
    force_beacons_into_match_width = false,
    -- These keys are captured directly by the plugin at runtime.
    special_keys = {
      next_match_group = "<space>",
      prev_match_group = "<tab>",
    },
  })
end

return M

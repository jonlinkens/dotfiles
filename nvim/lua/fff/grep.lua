local M = {}

function M.search(query, file_offset, page_size, grep_config, mode)
  return require("fff").content_search(query, {
    file_offset = file_offset,
    page_size = page_size,
    max_file_size = grep_config and grep_config.max_file_size or nil,
    max_matches_per_file = grep_config and grep_config.max_matches_per_file or nil,
    smart_case = grep_config and grep_config.smart_case or nil,
    time_budget_ms = grep_config and grep_config.time_budget_ms or nil,
    trim_whitespace = grep_config and grep_config.trim_whitespace or nil,
    mode = mode,
  })
end

return M

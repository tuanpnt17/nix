local M = {}

-- ######### dotnet #########
-- Utility function để tìm .csproj và lấy project name
local function get_project_info()
  local function find_csproj_dir(dir)
    local csproj_files = vim.fn.glob(dir .. "/*.csproj", false, true)
    if #csproj_files > 0 then
      return dir, vim.fn.fnamemodify(csproj_files[1], ":t:r")
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      return nil, nil
    end
    return find_csproj_dir(parent)
  end

  local file_path = vim.fn.expand("%:p:h")
  local csproj_dir, project_name = find_csproj_dir(file_path)

  if not csproj_dir then
    return vim.fn.getcwd(), "MyProject"
  end

  return csproj_dir, project_name
end

-- Utility function để generate namespace
local function get_namespace()
  local file_path = vim.fn.expand("%:p:h")
  local csproj_dir, project_name = get_project_info()

  local namespace = project_name

  if file_path:len() > csproj_dir:len() then
    local relative_path = file_path:sub(csproj_dir:len() + 2)
    if relative_path and relative_path ~= "" then
      local subfolder = relative_path:gsub("[/\\]", ".")
      subfolder = subfolder:gsub("^bin%.", ""):gsub("^obj%.", "")
      if subfolder ~= "" then
        namespace = namespace .. "." .. subfolder
      end
    end
  end

  return namespace
end

-- Utility function để lấy tên file không có extension
local function get_filename()
  return vim.fn.expand("%:t:r")
end

-- Utility function để check xem đã có namespace chưa
local function has_namespace()
  local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
  for _, line in ipairs(lines) do
    if line:match("^namespace") then
      return true
    end
  end
  return false
end

-- 1. Generate Namespace
function M.generate_namespace()
  if has_namespace() then
    vim.notify("Namespace already exists", vim.log.levels.WARN)
    return
  end

  local namespace = get_namespace()
  vim.api.nvim_buf_set_lines(0, 0, 0, false, { "namespace " .. namespace .. ";", "" })
  vim.notify("Added namespace: " .. namespace, vim.log.levels.INFO)
end

-- 2. Generate Class
function M.generate_class()
  local namespace = get_namespace()
  local filename = get_filename()

  local class_template = {
    "namespace " .. namespace .. ";",
    "",
    "public class " .. filename,
    "{",
    "    ",
    "}",
  }

  vim.api.nvim_buf_set_lines(0, 0, -1, false, class_template)
  vim.api.nvim_win_set_cursor(0, { 5, 4 }) -- Cursor ở dòng 5, cột 4
  vim.notify("Generated class: " .. filename, vim.log.levels.INFO)
end

-- 3. Generate Interface
function M.generate_interface()
  local namespace = get_namespace()
  local filename = get_filename()

  -- Auto add 'I' prefix nếu chưa có
  local interface_name = filename
  if not interface_name:match("^I[A-Z]") then
    interface_name = "I" .. filename
  end

  local interface_template = {
    "namespace " .. namespace .. ";",
    "",
    "public interface " .. interface_name,
    "{",
    "    ",
    "}",
  }

  vim.api.nvim_buf_set_lines(0, 0, -1, false, interface_template)
  vim.api.nvim_win_set_cursor(0, { 5, 4 }) -- Cursor ở dòng 5, cột 4
  vim.notify("Generated interface: " .. interface_name, vim.log.levels.INFO)
end

-- 4. Generate Record
function M.generate_record()
  local namespace = get_namespace()
  local filename = get_filename()

  local record_template = {
    "namespace " .. namespace .. ";",
    "",
    "public record " .. filename .. "(",
    "    ",
    ");",
  }

  vim.api.nvim_buf_set_lines(0, 0, -1, false, record_template)
  vim.api.nvim_win_set_cursor(0, { 4, 4 }) -- Cursor ở dòng 4, cột 4
  vim.notify("Generated record: " .. filename, vim.log.levels.INFO)
end

-- 5. Generate Enum
function M.generate_enum()
  local namespace = get_namespace()
  local filename = get_filename()

  local enum_template = {
    "namespace " .. namespace .. ";",
    "",
    "public enum " .. filename,
    "{",
    "    ",
    "}",
  }

  vim.api.nvim_buf_set_lines(0, 0, -1, false, enum_template)
  vim.api.nvim_win_set_cursor(0, { 5, 4 }) -- Cursor ở dòng 5, cột 4
  vim.notify("Generated enum: " .. filename, vim.log.levels.INFO)
end

-- ######### dotnetdbg #########
-- Find the root directory of a .NET project by searching for .csproj files
function M.find_project_root_by_csproj(start_path)
  local Path = require("plenary.path")
  local path = Path:new(start_path)

  while true do
    local csproj_files = vim.fn.glob(path:absolute() .. "/*.csproj", false, true)
    if #csproj_files > 0 then
      return path:absolute()
    end

    local parent = path:parent()
    if parent:absolute() == path:absolute() then
      return nil
    end

    path = parent
  end
end

-- Find the highest version of the netX.Y folder within a given path.
function M.get_highest_net_folder(bin_debug_path)
  local dirs = vim.fn.glob(bin_debug_path .. "/net*", false, true) -- Get all folders starting with 'net' in bin_debug_path

  if dirs == 0 then
    error("No netX.Y folders found in " .. bin_debug_path)
  end

  table.sort(dirs, function(a, b) -- Sort the directories based on their version numbers
    local ver_a = tonumber(a:match("net(%d+)%.%d+"))
    local ver_b = tonumber(b:match("net(%d+)%.%d+"))
    return ver_a > ver_b
  end)

  return dirs[1]
end

-- Build and return the full path to the .dll file for debugging.
function M.build_dll_path()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_file, ":p:h")

  local project_root = M.find_project_root_by_csproj(current_dir)
  if not project_root then
    error("Could not find project root (no .csproj found)")
  end

  local csproj_files = vim.fn.glob(project_root .. "/*.csproj", false, true)
  if #csproj_files == 0 then
    error("No .csproj file found in project root")
  end

  local project_name = vim.fn.fnamemodify(csproj_files[1], ":t:r")
  local bin_debug_path = project_root .. "/bin/Debug"
  local highest_net_folder = M.get_highest_net_folder(bin_debug_path)
  local dll_path = highest_net_folder .. "/" .. project_name .. ".dll"

  print("Launching: " .. dll_path)
  return dll_path
end

return M

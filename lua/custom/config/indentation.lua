-- Filetype-specific indentation settings
-- This helps ensure proper indentation for different file types

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'css', 'scss', 'javascript', 'typescript', 'json', 'yaml' },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python' },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua' },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Enable proper indentation for web technologies
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html' },
  callback = function()
    -- Better HTML indentation behavior
    vim.opt_local.indentkeys = '0{,0},0),0],0%,!^F,o,O,e,*<Return>,<>>,<<>,/'
    vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' }) -- Don't auto-comment new lines
    
    -- Ensure HTML indentation works properly
    vim.opt_local.cindent = false
    vim.opt_local.smartindent = true
    vim.opt_local.autoindent = true
    
    -- HTML-specific indentation rules
    vim.bo.indentexpr = ''
  end,
})

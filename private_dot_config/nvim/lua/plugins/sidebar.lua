local present, sidebar = pcall(require, "sidebar-nvim")

if not present then
    return
end

sidebar.setup {
    open = true,
    side = "left",
    initial_width = 50,
    sections = {"datetime", "git", "diagnostics", "todos", "files"},
    datetime = {
        clocks = {{
            name = "local"
        }}
    },
    disable_closing_prompt = true
}

local present, kommentary = pcall(require, 'kommentary.config')

if not present then
   return
end

kommentary.configure_language("default", {
    prefer_single_line_comments = true
})

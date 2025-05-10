config.load_autoconfig()

c.fonts.hints = 'bold 25px default_family'

config.bind('zi', 'zoom-in')
config.bind('zo', 'zoom-out')
config.bind('zz', 'zoom 100%')
config.bind('t', 'open -t')
config.bind('q', 'q')

c.url.default_page = 'https://www.google.co.za/'
c.url.start_pages = 'https://www.google.co.za/'
c.url.searchengines = {
    'DEFAULT': 'https://www.google.com/search?q={}',
    'ddg': 'https://duckduckgo.com/?q={}',
}

c.auto_save.session = True

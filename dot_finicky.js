module.exports = {
  defaultBrowser: 'Firefox',
  rewrite: [
    {
      // Redirect all urls to use https
      match: ({ url }) => url.protocol === 'http',
      url: { protocol: 'https' },
    },
    {
      match: 'www.amazon.com*',
      url: {
        host: 'smile.amazon.com',
      },
    },
    {
      match: ({ url }) => url.search.includes('utm_'),
      url({ url }) {
        const search = url.search
          .split('&')
          .filter((part) => !part.startsWith('utm_'))
        return {
          ...url,
          search: search.join('&'),
        }
      },
    },
  ],
  handlers: [
    {
      match: ['open.spotify.com*', 'play.spotify.com*'],
      browser: 'Spotify',
    },
    {
      // Open Apple Music links directly in Music.app
      match: ['music.apple.com*', 'geo.music.apple.com*'],
      url: {
        protocol: 'itmss',
      },
      browser: 'Music',
    },
  ],
}

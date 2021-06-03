module.exports = {
  defaultBrowser: 'Firefox Developer Edition',
  rewrite: [
    {
      // Redirect all urls to use https
      match: ({ url }) => url.protocol === 'http',
      url: { protocol: 'https' },
    },
    {
      // rewrite http[s]://chime.aws/<meetingID> to chime://meeting?pin=meetingId>
      match: finicky.matchHostnames(['chime.aws']),
      url: ({ url }) => ({
        ...url,
        host: '',
        search: 'pin=' + url.pathname.substr(1),
        pathname: 'meeting',
        protocol: 'chime',
      }),
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
      // open chime: url in Chime.app
      match: ({ url }) => url.protocol === 'chime',
      browser: '/Applications/Amazon Chime.app',
    },
    {
      // open quip: url in Quip.app
      match: ({ url }) => url.protocol === 'quip',
      browser: '/Applications/Quip.app',
    },
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

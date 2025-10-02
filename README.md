# SVNmentions-hook

This compliments [SVNmentions](https://github.com/carrvo/SVNmentions) ([webmentions](https://www.w3.org/TR/webmention/) receiver) by providing an SVN hook that will act as a [webmentions](https://www.w3.org/TR/webmention/) sender.

## Security

Note that SVNmentions obtains direct access to the SVN repository and bypasses any Apache-level Authorization that has been set up. This, and its ability to send outgoing requests makes it an attack vector. Consider extending with or applying some amount of commit content filtering to reduce the risk.

## Setup

You need to configure your SVN repository with the hook and enough configuration for it to understand
what external URI it is serving. The external URI is important for determining the source URI (during the Webmention) **as well as target URI for same site Webmentions that use relative paths**.

Note the following requirements:
- `/path/to/svn-repo/` *MUST* end in a slash (`/`) to ensure that it is a directory
- `https://example.com/apache2/webspace/path` *MUST NOT* end in a slash (`/`) due to it being added by the hook later
- `https://example.com/apache2/webspace/path` *MUST* either start with `https://` OR `http://`

```
./install.bash /path/to/svn-repo/ https://example.com/apache2/webspace/path
```

*Optionally*, you can specify a client ID that will be provided whenever a service is asking for authentication.

```
./install.bash /path/to/svn-repo/ https://example.com/apache2/webspace/path https://example.com/apache2/id
./install.bash /path/to/svn-repo/ https://example.com/apache2/webspace/path 'client ID'
```

## Usage

Just commit files with a supported `svn:mime-type` SVN property!
- `text/html`

Note that the outgoing requests will be invisible and **errors will not be reported at this time**.

### Skip

You can set `webmention:skip` SVN property (detects existence) for any documents you do not want links to incur an outgoing Webmention.
This is valuable for feed and sitemap documents who have references to other documents but is not appropriate to send a Webmention to them.

## License

Copyright 2024 by carrvo

I have not decided on which license to declare as of yet.


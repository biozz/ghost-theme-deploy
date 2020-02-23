# ghost-theme-deploy

This is just a basic node alpine lts container with a couple of tools and ghost-admin-api npm package.

Working directory of a container is `/tmp/build`.

All the ideas are taken from [TryGhost/action-deploy-theme](https://github.com/TryGhost/action-deploy-theme). But I needed a platform-agnostic way to build my theme, because I use [Drone](https://drone.io/).

## How to

The image has an executable named `deploy` in `/usr/bin`, so you basically just need to call it in your pipeline with appropriate environment variables setup beforehand. Below you can find some examples for different CI/CD solutions.

### Drone

```yaml
kind: pipeline
type: docker
name: default

steps:
- name: deploy
  image: biozz/ghost-admin-api:latest
  environment:
    GHOST_ADMIN_API_KEY:
      from_secret: GHOST_ADMIN_API_KEY
    GHOST_ADMIN_API_URL:
      from_secret: GHOST_ADMIN_API_URL
    GHOST_THEME_BASE_PATH: /drone/src
    GHOST_THEME_NAME: myawesometheme
    # GHOST_THEME_ZIP_EXCLUDE: 'node_modules*'
  commands:
  - deploy
```

## Additional stuff

These are the things I added to the image for scripts to work properly:

- `zip` - to be able to zip theme files
- [`@actions/exec`](https://www.npmjs.com/package/@actions/exec) - simple wrapper used for zip command call
- [`@tryghost/admin-api`](https://www.npmjs.com/package/@tryghost/admin-api) - interraction with ghost admin api

## Environment variables

- `GHOST_ADMIN_API_URL` - url and key can be generated in ghost admin site
- `GHOST_ADMIN_API_KEY`
- `GHOST_THEME_BASE_PATH` - where the source will be cloned
- `GHOST_THEME_NAME` - the name of the theme
- `GHOST_THEME_ZIP_EXLCUDE` - optional, excludes files from final zip (passed directly into zip command)

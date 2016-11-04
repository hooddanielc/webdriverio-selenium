> Save your hands... Automate it

Selenium and WebDriverIO
========================

Behold, a docker machine that runs selenium in a headless environment. This is a base project to help you get up and running with selenium 3 and webdriverio. This repository was started shortly after the release of selenium 3.0.1.

```
# build it if you need to add more stuff
./build.sh

# execute run.sh which run entrypoint.sh
./run.sh
```

You should be able to get up and running by copying this repo and by using the following Dockerfile.

```
FROM dhoodlum/webdriverio-selenium
```
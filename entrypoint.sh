cd /data && ls
xvfb-run java -jar /opt/selenium/selenium-standalone-3.0.1.jar &
sleep 2
cd /data && npm i && node index.js
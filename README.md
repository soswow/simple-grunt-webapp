Simplest webapp boilerplate
===========================
It has **CoffeeScript** + **Compass** and just it =)

If you need version with **Bootstrap** + **jQuery** + **FontAwesome**, go in [with-bootstrap branch](../../tree/with-bootstrap)

How to
-------
Run following where you want this awesome simple sceleton appears:
```
git clone https://github.com/soswow/simple-grunt-webapp.git .tmp --single-branch && 
cp -r .tmp/* . && rm -rf .tmp README.md && 
npm install && bower install
```

or if you don't have git
```
wget https://github.com/soswow/simple-grunt-webapp/archive/master.zip && unzip master.zip && 
cp -rf simple-grunt-webapp-master/* . &&
rm -rf simple-grunt-webapp-master/ master.zip README.md && 
npm install && bower install
```

Simplest webapp boilerplate
===========================
It has **CoffeeScript** + **Compass** + **Bootstrap** + **jQuery** + **FontAwesome** =)

How to
-------
Run following where you want this awesome simple sceleton appears:
```
git clone https://github.com/soswow/simple-grunt-webapp.git .tmp --single-branch --branch with-bootstrap && 
cp -r .tmp/* . && rm -rf .tmp README.md && 
npm install && bower install
```

or if you don't have git
```
wget https://github.com/soswow/simple-grunt-webapp/archive/with-bootstrap.zip && unzip master.zip && 
cp -rf simple-grunt-webapp-with-bootstrap/* . &&
rm -rf simple-grunt-webapp-with-bootstrap/ with-bootstrap.zip README.md && 
npm install && bower install
```

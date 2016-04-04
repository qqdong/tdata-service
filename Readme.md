run dev:
```
nodemon app.coffee
```

run production:
```
node: v0.11.14
pm2: 0.12.1

NODE_ENV=production pm2 start start.js -n muse-service -i 2 --max-memory-restart 300
```

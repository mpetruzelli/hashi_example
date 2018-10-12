## API Docs
```https://www.nomadproject.io/api/```


## API Register
``` curl -XPOST --data @api_dispatch.json localhost:4646/v1/jobs ```

## API Dispatch

``` 
cat << EOF > payload.json
{
    "Meta": {
        "string": "APIs are wunderbar!"
    }
} 
EOF
```

``` curl  -XPOST --data @payload.json localhost:4646/v1/job/api_dispatch/dispatch ```

## API Force Periodic
``` curl  -XPOST localhost:4646/v1/job/every_minute/periodic/force ```


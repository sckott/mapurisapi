mapuris
=======

Clone down

```sh
git clone git@github.com:sckott/mapurisapi.git
cd mapurisapi
bundle install
```

Get Couch database up

```sh
git clone git@github.com:danielebailo/couchdb-dump.git
cd couchdb-dump/bin
#start couchdb
#add new database called mapuris
bash couchdb-restore.sh localhost mapuris mapuris.txt
```

Start Sinatra

```sh
cd mapurisapi
ruby api.rb
```

Heartbeat

```sh
curl http://localhost::4567/heartbeat
```

```sh
{
  status: "ok"
}
```

The root redirects to `/heartbeat`

```sh
curl http://localhost::4567
```

```sh
{
  status: "ok"
}
```

Get links to other resources for a DOI.

```sh
curl http://localhost::4567/links/10.12688/f1000research.3817.1
```

```sh
{
    status: "ok",
    data: {
        _id: "10.12688/f1000research.3817.1",
        _rev: "1-16b4fe65ddc6be789c76761a8e7fb810",
        doi: "10.12688/f1000research.3817.1",
        url: "http://dx.doi.org/10.12688/f1000research.3817.1",
        pdf: "http://f1000research.com/articles/3817/1/pdf",
        xml: "http://f1000research.com/articles/3817/1/xml",
        cm_target_doi: { },
        cm_assertions: [
            "http://f1000research.com/articles/3-80/v1#article-reports",
            "http://f1000research.com/articles/3-80/v1#referee-response-4304",
            "http://f1000research.com/articles/3-80/v1#referee-response-5889"
        ],
        figs: "f1000research-3-4089-g0000.gif",
        media: { }
    }
}
```

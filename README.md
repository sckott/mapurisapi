mapuris
=======

This project was started at the [PLOS article level metrics hackathon](http://articlemetrics.github.io/workshop_2014/) on 2014-12-06. The hackathon repo: https://github.com/articlemetrics/hackathon_2014 

This repo contains a Ruby Sinatra API for serving versions of articles, based on a article DOI, or a query. Data is stored in, and search provided by, Elasticsearch.

## Clone this repo

```sh
git clone git@github.com:sckott/mapurisapi.git
cd mapurisapi
bundle install
```

## Install Elasticsearch

* Download zip or tar file from Elasticsearch see here for download, e.g., `curl -L -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.1.tar.gz`
* Unzip it: `untar elasticsearch-1.4.1.tar.gz`
* Move it: `sudo mv /path/to/elasticsearch-1.4.1 /usr/local` (replace version with your version)
* Navigate to /usr/local: `cd /usr/local`
* Add shortcut: `sudo ln -s elasticsearch-1.4.1 elasticsearch` (replace version with your verioon)

You can also install via Homebrew: `brew install elasticsearch`

## Get data into Elasticsearch

Install `elasticdump` tool

```sh
sudo npm install elasticdump -g
```

Push data into ES via the bulk endpoint

```sh
cd mapurisapi
elasticdump --bulk=true --input=data.json --output=http://localhost:9200/
```

Then ping ES to make sure it's there

```sh
curl localhost:9200/mapuris
```

## Start Sinatra

```sh
cd mapurisapi
ruby api.rb
```

## Heartbeat

```sh
curl http://localhost::4567/heartbeat
```

```sh
{
  status: "ok"
}
```

The root redirects to `/heartbeat` (`/heartbeat` gives the same thing)

```sh
curl -L http://localhost:4567
```

```sh
{
  "status": "ok",
  "paths": [
    "/heartbeat",
    "/links/:doi",
    "/search"
  ]
}
```

## Get links to other resources for a DOI.

```sh
curl http://localhost:4567/links/10.12688/f1000research.3817.1
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

# Basic Configuration

For most basic setups, you can use environment variables to configure the Phorge image to your liking.  This works well with tools like `docker-compose`.

A full list of all available environment variables can be found in the [Full Environment Variable List](ENV-LIST.md).

# Configuring MySQL

You need to do this before running the container, or things won't work.  If you have MySQL running in another container, you can use `MYSQL_HOST`, like so:

```
docker run ... \
    --env MYSQL_HOST=mysql \
    --env MYSQL_USER=phorge \
    --env MYSQL_PASS=password \
    --link somecontainer:mysql \
    ...
```

If your instance of MySQL is running on the host or some external system, you can connect to it using the `MYSQL_USER` and associated variables like so:

```
docker run \
    --env MYSQL_HOST=externalhost.com \
    --env MYSQL_PORT=3306 \
    --env MYSQL_USER=phorge \
    --env MYSQL_PASS=password \
    ...
```

The `MYSQL_PORT` environment variable is set to a sensible default, so normally you don't need to explicitly provide it.

# Configuring Phorge

Phorge needs some basic information about how clients will connect to it.  You can provide the base URI for Phorge with the `PHORGE_HOST` environment variable, like so:

```
docker run ... \
    --env PHORGE_HOST=myphorge.com \
    ...
```

By default, Phorge will run on `phorge.localhost`; if you would like to test it locally you should edit your hosts file to resolve this address.

It's recommended that you specify an alternate domain to serve files and other user content from.  This will make Phorge more secure.  You can configure this using the `PHORGE_CDN` option, like so:

```
docker run ... \
    --env PHORGE_CDN=altdomain.com \
    ...
```

You also need to configure a place to store repository data.  This should be a volume mapped from the host, for example:

```
docker run ... \
    --env PHORGE_REPOSITORY_PATH=/repos \
    -v /path/on/host:/repos \
    ...
```

To provide SSH access to repositories, you need to set a path to store the SSH host keys in.  If you are not baking a derived image (see [Advanced Configuration](ADVANCED-CONFIG.md)), then you need to map that path to a location on the host.  If you are baking an image, you can omit the mapping and the SSH keys will form part of your derived image.  You can configure SSH access to repositories like so:

```
docker run ... \
    --env PHORGE_HOST_KEYS_PATH=/hostkeys/persisted \
    -v /path/on/host:/hostkeys \
    ...
```

By default, Phorge stores file data in MySQL.  You can change this with the `PHORGE_STORAGE_TYPE` option, which can be either `mysql` (the default), `disk` or `s3`.

You can configure Phorge to store files on disk by selecting the `disk` option, mapping a volume and configuring the path:

```
docker run ... \
    --env PHORGE_STORAGE_TYPE=disk \
    --env PHORGE_STORAGE_PATH=/files \
    -v /path/on/host:/files \
    ...
```

Alternatively if you want to store file data in S3, you can do so by selecting the `s3` option, configuring the bucket and setting the AWS access and secret keys to use:

```
docker run ... \
    --env PHORGE_STORAGE_TYPE=s3 \
    --env PHORGE_STORAGE_BUCKET=mybucket \
    --env AWS_S3_ACCESS_KEY=... \
    --env AWS_S3_SECRET_KEY=... \
    ...
```

# Configuring SSL

You can configure SSL in one way: you can omit it entirely. I don't feel like testing LetsEncrypt setup tonight. This will change eventually.

## No SSL

This is the default.  If you provide no SSL related options, this image doesn't serve anything on port 443 (HTTPS).

## Load Balancer terminated SSL

This is an actual, supported second option. If your load balancer is terminating SSL, you should set `SSL_TYPE` to `external` so that Phorge will render out all links as HTTPS.  Without doing this (i.e. if you left the default of `none`), all of the Phorge URLs would be prefixed with `http://` instead of `https://`.

```
docker run ... \
    --env SSL_TYPE=external \
    ...
```

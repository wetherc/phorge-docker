# Phorge

This is a Docker image which provides a fully configured Phorge image, including SSH connectivity to repositories, real-time notifications via Web Sockets and all of the other parts that are normally difficult to configure done for you.

You'll need an instance of MySQL for this Docker image to connect to, and for basic setups you can specify it with either the `MYSQL_LINKED_CONTAINER` or `MYSQL_HOST` environment variables, depending on where your instance of MySQL is.

The most basic command to run Phorge is:

```
docker run \
    --rm -p 80:80 -p 443:443 -p 22:22 \
    --env PHORGE_HOST=mydomain.com \
    --env MYSQL_HOST=10.0.0.1 \
    --env MYSQL_USER=user \
    --env MYSQL_PASS=pass \
    --env PHORGE_REPOSITORY_PATH=/repos \
    -v /host/repo/path:/repos \
    phorge
```

Alternatively you can launch this image with Docker Compose. Refer to [Using Docker Compose](./DOCKER-COMPOSE.md) for more information.

## Configuration

For basic configuration in getting the image running, refer to [Basic Configuration](./BASIC-CONFIG.md).

For more advanced configuration topics including:

* Using different source repositories (for patched versions of Phorge)
* Running custom commands during the boot process, and
* Baking configuration into your own derived Docker image

refer to [Advanced Configuration](./ADVANCED-CONFIG.md).

For users that are upgrading to this version and currently using the old `/config` mechanism to configure Phorge, this configuration mechanism will continue to work, but it's recommended that you migrate to environment variables or baked images when you next get the chance.

## Support

For issues regarding environment setup, missing tools or parts of the image not starting correctly, file a GitHub issue.

For issues encountered while using Phorge itself, report the issue with reproduction steps on the [upstream bug tracker](https://we.phorge.it/book/contrib/article/bug_reports/).

## License

The configuration scripts provided in this image are licensed under the MIT license.  Phorge itself and all accompanying software are licensed under their respective software licenses.

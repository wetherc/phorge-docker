# Launch Phorge with docker-compose command

Docker Compose configuration file supplied in this repository defines a Phorge service and a MySQL service.

The MySQL service uses official MySQL Docker image mysql:5.7.14 and the Phorge service uses image redpointgames/phorge.


## Configure `PHORGE_HOST`

Before you start, you should modify the `PHORGE_HOST` inside docker-compose.yml so that `PHORGE_HOST` represents the real domain name you want to use.

If you do not modify the `PHORGE_HOST`, Phorge will not function correctly.

## Docker Volume

By default, it tries to mount host directory /srv/docker/phorge/mysql as /var/lib/mysql in MySQL service container and host directory /srv/docker/phorge/repos as /repo in Phorge service container.

It mounts host directory /srv/docker/phorge/extensions as /srv/phorge/phorge/src/extensions in Phorge service.

If you would like to add additional translations for phorge, you can just drop php files in host directory /srv/docker/phorge/extensions.

To ensure that MySQL database and code repositories are both persistent, please make sure the following directories exist in your docker host.

```bash
/srv/docker/phorge/repos
/srv/docker/phorge/mysql
```

The following directory is optional and can be absent in your docker host.

```bash
/srv/docker/phorge/extensions
```

It is required if you need extra Phorge translations.

## Launch Phorge

Once you configure `PHORGE_HOST` and Docker Volume, you can run the following command within the directory where docker-compose.yml resides.

To launch Phorge in daemon mode

```bash
docker-compose up -d
```

To launch Phorge in interactive mode

```bash
docker-compose up
```